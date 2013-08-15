From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email uses contacts to propose recipients
Date: Thu, 15 Aug 2013 15:38:56 -0700
Message-ID: <7v4naqpojj.fsf@alter.siamese.dyndns.org>
References: <1376605069-525-1-git-send-email-stefanbeller@googlemail.com>
	<7vhaeqpoyh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>, mst@kernel.org,
	felipe.contreras@gmail.com, bebarino@gmail.com, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 00:39:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA6C8-0000z2-54
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 00:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab3HOWi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 18:38:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab3HOWi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 18:38:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3373339868;
	Thu, 15 Aug 2013 22:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kGLby7v2Ar5NDqOZoBh5vGROgkU=; b=RZVrIS
	XerOuFhHkUR8gYZOa4FTqQpiP/SksfbjdMRTKlY/aSbcYp4SUva8RfHYwBllEzM3
	tRHALbgmhq1UfGjsJ/Pk1RPI1goEtEI/0s/pnQQ5JA0ZAMZc3qYo1yCmFO4r7lzi
	FWxQYNxbyxAaEhbEIr19/otIzdL42Jgfb0t20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j4nVVf1pjeYCUkmG4FsY5j7P5pU/D59Y
	DLn1GMOw9PXPysBnhrri4hop2dNg103ct/WyI/0FjTOP13KbZnf60a+a+o6MR25k
	rBRcRiWym5INZLuE3vrfy/sBhd45fHq7DGi8Owf4W7JeCq0H7NvhyTKj3Xkgr7wx
	9gjO/6+4kq0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27B6939867;
	Thu, 15 Aug 2013 22:38:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79F7239865;
	Thu, 15 Aug 2013 22:38:57 +0000 (UTC)
In-Reply-To: <7vhaeqpoyh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 15 Aug 2013 15:29:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78FAF344-05FB-11E3-BFCC-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232383>

Junio C Hamano <gitster@pobox.com> writes:

> ... we may have to restrict "is available" a bit
> tighter.

As Eric pointed out, that "bit tighter" opt-in could just be an
explicit use of --cc-cmd option to specify this script ;-)
