From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/2] log decorations for HEAD
Date: Tue, 10 Mar 2015 10:06:52 -0700
Message-ID: <xmqqr3sw234j.fsf@gitster.dls.corp.google.com>
References: <54FEC8D0.2060304@drmicha.warpmail.net>
	<cover.1425995310.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Julien Cretel <j.cretel@umail.ucc.ie>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 18:07:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVNcS-0007Kq-WE
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 18:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbbCJRG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 13:06:56 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64741 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751435AbbCJRGz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 13:06:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5ECC13DAD9;
	Tue, 10 Mar 2015 13:06:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vhWWtHOgFgThr15Utc9cpsGklP0=; b=YMhORc
	tbEWXB7Sh/L6niWS/y1gMtCkbmZBRr/eBk07bkWozEl4kVWpxyZDatfPAGLN5kay
	AM9/HjX3wmdDPE29qa1Dt4JG9uI5gqr0B8LEtDFqdL4qpddzVHRT57EkQSxFcQAy
	d57+1amcwxOqqK0SfnLrYMLc2SXbJ4GYvicqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A9UPuQofYXlq3Po5AqoRwTn9oh8b30YM
	l/rCd6vyx1/eTSN5hJoCqMiAQsF0w6M5n4f9RddTWDB7sdDhFKpxMB6/Unuxv0qz
	epIVWU2bMYM2IFVVm+16/Oow9L023k8J3dyL5l1/m1QAv2Y64PVXFrt53GvCh16u
	ny/kanl6ubs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46ECB3DAD7;
	Tue, 10 Mar 2015 13:06:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ABFC53DAD6;
	Tue, 10 Mar 2015 13:06:53 -0400 (EDT)
In-Reply-To: <cover.1425995310.git.git@drmicha.warpmail.net> (Michael
	J. Gruber's message of "Tue, 10 Mar 2015 14:53:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D9B96030-C747-11E4-A520-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265243>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> So it didn't take too long to convince me after all :)
>
> Here comes Junio's version, preceded by a cleanup of the color
> setting and resetting for decorations.
>
> Junio C Hamano (1):
>   log: decorate HEAD with branch name
>
> Michael J Gruber (1):
>   log-tree: properly reset colors
>
>  log-tree.c                        | 76 ++++++++++++++++++++++++++++++++++-----
>  t/t4013/diff.log_--decorate_--all |  2 +-
>  t/t4207-log-decoration-colors.sh  | 16 ++++-----
>  3 files changed, 77 insertions(+), 17 deletions(-)

Hmph, is the "do not leak commit color" one the same as 5ee87585
(log --decorate: do not leak "commit" color into the next item,
2015-03-04) aka $gmane/264788 [*1*] or is there something I missed?


[References]

*1* http://thread.gmane.org/gmane.comp.version-control.git/264063/focus=264788
