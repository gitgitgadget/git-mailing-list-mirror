From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] README: Git is released under the GPLv2, not just "the
 GPL"
Date: Sat, 15 Dec 2012 10:35:37 -0800
Message-ID: <7v38z7tb7q.fsf@alter.siamese.dyndns.org>
References: <966a27bab02e7deb41ad2268800bfd4a53279a8f.1355499408.git.stefano.lattarini@gmail.com> <7vhanntchw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 19:36:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjwai-0006YN-I6
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab2LOSfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:35:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42798 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995Ab2LOSfk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:35:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BA18AF33;
	Sat, 15 Dec 2012 13:35:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ErhG2BL+7PfuvEG97EmtzUFI/lc=; b=qmF/4C
	ej8aCMJAVhetOXOtZ/LtdlVeHPyWMXr6HbORz80HlwK0KFrZBZq/b7C0qRY/9uu6
	OKXkgNheUu33fq72HbcBZo2vuO6Q5/5/77dNVH2b84Pmi6kFcMncPb3f5YNHGWN9
	qKL9yElbNl2ui2Bv1lA7aBS7+O0VpyTJ7Jkkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k1nDbcRsVuGhWRTfR0tqTzf55TomhrR1
	vpE+Vw7rlZMtBFfVIRsnxijQXigRkhpcdSpVASEd3+1LrxQ5XFRn+bJT8I01fyAm
	9BnE4nOkZTvEMSIZIwogWKNGwVC+ZIENlOGieQfJdQUAl55QOnss9grCrMrbeqe1
	PE2O4POWdQg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07C8EAF32;
	Sat, 15 Dec 2012 13:35:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58C29AF30; Sat, 15 Dec 2012
 13:35:39 -0500 (EST)
In-Reply-To: <7vhanntchw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 15 Dec 2012 10:07:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39626E94-46E6-11E2-A102-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211555>

Junio C Hamano <gitster@pobox.com> writes:

> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
>
>> And this is clearly stressed by Linus in the COPYING file.  So make it
>> clear in the README as well, to avoid possible misunderstandings.
>>
>> Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
>> ---
>
> I have nothing against this patch, but I am curious if you saw any
> misunderstandings in the real world, or if you are merely trying to
> avoid "possible" ones.
>
>>  README | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/README b/README
>> index d2690ec..c50e6f4 100644
>> --- a/README
>> +++ b/README
>> @@ -19,9 +19,10 @@ Git is a fast, scalable, distributed revision control system with an
>>  unusually rich command set that provides both high-level operations
>>  and full access to internals.
>>  
>> -Git is an Open Source project covered by the GNU General Public License.
>> -It was originally written by Linus Torvalds with help of a group of
>> -hackers around the net. It is currently maintained by Junio C Hamano.
>> +Git is an Open Source project covered by the GNU General Public License
>> +(version 2).  It was originally written by Linus Torvalds with help
>> +of a group of hackers around the net. It is currently maintained by
>> +Junio C Hamano.
>>  
>>  Please read the file INSTALL for installation instructions.

The project as a whole is GPLv2, and inclusion of pieces licensed
under different but compatible terms does not change it, but we may
want to do this instead.

I am just one of the "group of hackers around the net" in the
context of this overview, so I think it is OK to drop that
"currently maintained by" bit. The audience of this document does
not have to find out and interact with the maintainer.

diff --git a/README b/README
index d2690ec..c365e3c 100644
--- a/README
+++ b/README
@@ -19,9 +19,10 @@ Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
 
-Git is an Open Source project covered by the GNU General Public License.
+Git is an Open Source project covered by the GNU General Public
+License version 2 (some parts of it are under different licenses).
 It was originally written by Linus Torvalds with help of a group of
-hackers around the net. It is currently maintained by Junio C Hamano.
+hackers around the net.
 
 Please read the file INSTALL for installation instructions.
 
-- 
1.8.1.rc1.148.gfac1be9
