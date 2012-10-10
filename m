From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MALLOC_CHECK: Allow checking to be disabled from
 config.mak
Date: Wed, 10 Oct 2012 12:16:26 -0700
Message-ID: <7v391mcf3p.fsf@alter.siamese.dyndns.org>
References: <50706B54.8090004@ramsay1.demon.co.uk>
 <7vbogfquc8.fsf@alter.siamese.dyndns.org>
 <5075B47C.6030607@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Elia Pinto <gitter.spiros@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Oct 10 21:16:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM1lo-0001tV-WF
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 21:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752Ab2JJTQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 15:16:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789Ab2JJTQa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 15:16:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6D139EC8;
	Wed, 10 Oct 2012 15:16:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ODRC3cZhGvFZP/GwIXb6slicbO4=; b=I4reEn
	lvyE9t0Y5nZh9kgQZ9GzgyIfXW7ZoPMJYaVCp/2aqeG7kWiwBoZir5/oAj7y4qaY
	x8poErFD3wVXOxQRSdf/l0/ekCt6e/fbbXqsaP266aq2DnwsEsNc+HFeSblIDUBj
	TjffdAS5tBVaq1HLQPfHBJF8I3cXJfZRKasGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hjRGR7jcjvPLpMpsFFRZ0bfswHNuPoz1
	lwCVmKDeiUg8nCGa3MWyDhpwQ+Yn4lea3bGQKafnfxtBw0dMxK9tcI6sldVx3Siv
	WqtK3Qybe9LPDa7R8WpwOMQ0rSY7fLxJJasY+ppMypDJreHtqzjncn52uBnm0H+e
	BtmwQGRGSzw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C36469EC7;
	Wed, 10 Oct 2012 15:16:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4190B9EC5; Wed, 10 Oct 2012
 15:16:28 -0400 (EDT)
In-Reply-To: <5075B47C.6030607@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Wed, 10 Oct 2012 18:46:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDC838D8-130E-11E2-BE49-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207427>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Yes, so I can simply disable the malloc checks in my ~/.bashrc file.
> However, it would be disappointing to have my config tweeks in two
> places ... :(
>
> I guess I can live with it ...

You could write "export that-variable" in your config.mak yourself
;-)  Let's apply the patch as-is.
