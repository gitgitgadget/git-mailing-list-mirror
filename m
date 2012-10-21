From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subtree in Git
Date: Sat, 20 Oct 2012 23:32:23 -0700
Message-ID: <7vbofwgwso.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
 <nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl>
 <87fwbgbs0h.fsf@smith.obbligato.org>
 <7v8vh78dag.fsf@alter.siamese.dyndns.org> <4FA82799.1020400@initfour.nl>
 <nngzk9jvemb.fsf@transit.us.cray.com> <nngaa0z3p8b.fsf@transit.us.cray.com>
 <87bokpxqoq.fsf@smith.obbligato.org> <4FD89383.70003@initfour.nl>
 <nng4npe6zsj.fsf@transit.us.cray.com> <50830374.9090308@initfour.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dag@cray.com, greened@obbligato.org,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Herman van Rink <rink@initfour.nl>
X-From: git-owner@vger.kernel.org Sun Oct 21 08:32:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPp5U-0005Q2-RK
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 08:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662Ab2JUGc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 02:32:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57824 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806Ab2JUGc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 02:32:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E6C36409;
	Sun, 21 Oct 2012 02:32:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BYcIMghipi+bShpXHtxZWSlY8Ws=; b=xfVVqa
	81xPSkuEI/C0pWXm3/n5XbmQZZ/WPxDA9g25HshCMGjYoU5hZ9yI5QwDLSq0m2t6
	lzhwpO7w8NnE5jlFBwjtayBYVYziXeiU8rY6Rw7BNA8umJCpCiGhNbxrpRcwKX9q
	VAJ9zrvNVHcUn8LU7mMcG69dB6g6EZNCvysOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F/vHbmKhwonVZgj46dn2yy15TAxw/K0B
	1mVQl0BtWxM6NnhwwiehoNva5SRrejPRiHqXlBJW/QUwr7xJDFNm5k19ogdo8vNw
	+6a+0vNuWef/neFGo+fWTGtxUYPHfOIz8F44w0ALa/dXZO4e1dyVsa79+ZSAbPEa
	RzKBxoem3Ek=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79E756407;
	Sun, 21 Oct 2012 02:32:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8EE063F2; Sun, 21 Oct 2012
 02:32:24 -0400 (EDT)
In-Reply-To: <50830374.9090308@initfour.nl> (Herman van Rink's message of
 "Sat, 20 Oct 2012 22:03:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1394E714-1B49-11E2-B001-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208112>

Herman van Rink <rink@initfour.nl> writes:

> Junio, Could you please consider merging the single commit from my
> subtree-updates branch? https://github.com/helmo/git/tree/subtree-updates

In general, in areas like contrib/ where there is a volunteer area
maintainer, unless the change something ultra-urgent (e.g. serious
security fix) and the area maintainer is unavailable, I'm really
reluctant to bypass and take a single patch that adds many things
that are independent from each other.

Especially not immediately before tagging 1.8.0 final.
