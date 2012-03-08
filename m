From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/2] post-receive-email: declaring and consistently
 using one output encoding
Date: Thu, 08 Mar 2012 11:12:03 -0800
Message-ID: <7v62eeewl8.fsf@alter.siamese.dyndns.org>
References: <20120308115119.GA2604@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gerrit Pape <pape@smarden.org>,
	Alexey Shumkin <zapped@mail.ru>, Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jon Jensen <jon@endpoint.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 20:12:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5il2-0007Fl-VQ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 20:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493Ab2CHTMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 14:12:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756530Ab2CHTMF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 14:12:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 432566E13;
	Thu,  8 Mar 2012 14:12:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eRQCy4sO8HigreYJSKiVeRFflXc=; b=dn/hqA
	hTH3MU3DwBI8H0778LDrNpKoM4LmJ6tSOdLXlCpWHPcVwKdCBvZX2+22Ar7DOUKz
	VTa7DH7xg7SIgv7mMRHj7Z0C3b2NBgSmHIvPmhXtYU/PfuFYVpnohJFU2fzZ1ObC
	Riaru33GDHCfOQIy0zAcqh0xB3CCldLQscvZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dELc85x4Cq8xFITYQu5YcN+QgTOtY6as
	DQ44+PB0SiRn3zADyVE2EdfgoQvRlZeu6VXIVDwkKy0D+aHirHkkd16Dlf+6KBZG
	rZ5GgGlM9T3ruqZj+Q0Tl7HBe9UUpYtyK9nZVufWWQK7/NeUdBflPSZ0BebvmL1T
	5j3whgdlXDg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 390B36E10;
	Thu,  8 Mar 2012 14:12:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B90AA6E0E; Thu,  8 Mar 2012
 14:12:04 -0500 (EST)
In-Reply-To: <20120308115119.GA2604@burratino> (Jonathan Nieder's message of
 "Thu, 8 Mar 2012 05:51:19 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9782ABBE-6952-11E1-BA81-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192632>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Patches are targetted at 1.7.11 unless there is overwhelming
> interest in them landing sooner.

Even if there is none, I wouldn't mind taking it for 1.7.10, if only
to reduce the chance that the patch gets forgotten again, provided
that there is a clear concensus that this is a good change that won't
regress people who have been actually using this sample in real life.

> <gq@cs.msu.su> for the writing a patch long ago to get this
> started[1].
>
> Thoughts?
>
> Gerrit Pape (1):
>   bug#506445: hooks/post-receive-email: set encoding to utf-8
>
> Jonathan Nieder (1):
>   post-receive-email: defend against non-utf8 [i18n] logoutputencoding
>     setting
>
>  contrib/hooks/post-receive-email |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/181737/focus=181755
> [2] http://bugs.debian.org/506445
