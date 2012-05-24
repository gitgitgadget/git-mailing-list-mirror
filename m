From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2012, #06; Wed, 23)
Date: Thu, 24 May 2012 09:52:25 -0700
Message-ID: <7vpq9ty112.fsf@alter.siamese.dyndns.org>
References: <7vmx4yzgce.fsf@alter.siamese.dyndns.org>
 <4FBDC8FA.9050501@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu May 24 18:52:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXbH8-0007wo-R6
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 18:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768Ab2EXQwa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 12:52:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943Ab2EXQw3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 12:52:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C85338CE4;
	Thu, 24 May 2012 12:52:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hUI05jx49kF9
	WF2HpYM4DiZsxec=; b=toruRTYCjSNWPkzE0RxARVO9/G2YxsT5UjE5xcpuQ0QD
	WdnMl0ufwKwrrg/T1sC+bJmdpxN7D/DpUndZe/DVAQwKt5r0OOt9Fg9TYNwNjIqM
	TVuqz1HqtAja4WCVXvAvjhyylyWAvoNIqqlauZ4kssMxE6d5EM2bd7ZDCC8joeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AhzYVT
	8EZ/CbBO+wzCK+ee6zlVzztvG4BdndGGQwz1SVNyooYutAsecSrvDXEAMotfu9+v
	uGwaowXaoV46bBO4VJHz87SdjsHkqzSYjZ2w35ZHnbSPeu6No2gn/gKkGqz/d3Nf
	WWydf4iYEIJfVromDjt6JvHlUEFmOuf89SfW8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF4B68CE3;
	Thu, 24 May 2012 12:52:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4786E8CE1; Thu, 24 May 2012
 12:52:27 -0400 (EDT)
In-Reply-To: <4FBDC8FA.9050501@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Thu, 24 May 2012 07:36:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7F11046-A5C0-11E1-BCDD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198392>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 24.05.2012 00:24, schrieb Junio C Hamano:
>> * rs/maint-grep-F (2012-05-21) 4 commits
>>    (merged to 'next' on 2012-05-23 at b24143c)
>>   + grep: stop leaking line strings with -f
>>   + grep: support newline separated pattern list
>>   + grep: factor out do_append_grep_pat()
>>   + grep: factor out create_grep_pat()
>>
>> "git grep -F", unlike the case where it reads from a file, did not t=
reat
>> individual lines in the given pattern argument as separate patterns =
as it
>> should.
>
> This is not specific to -F; grep(1) accepts newline-separated pattern
> lists with -E etc. as well, as does git grep with the patches above.

Yeah, I noticed that "unlike where reading from a file" should contrast
against "where params come from the command line", not with any particu=
lar
way to interpret individual pattern. after sending it out.

Thanks.
