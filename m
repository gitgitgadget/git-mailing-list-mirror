From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: [PATCH] fix many comment typos
Date: Sat, 2 Jun 2012 16:47:29 -0700
Message-ID: <CAE1pOi0g1UCebpWGP6FpH0-RbUBxyoWMj_XT7=gNudHrztx0+g@mail.gmail.com>
References: <8762baf8do.fsf@rho.meyering.net> <7vmx4lz5bm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 01:47:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Say33-0005np-Cm
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 01:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933626Ab2FBXrv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jun 2012 19:47:51 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:60472 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933071Ab2FBXru convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jun 2012 19:47:50 -0400
Received: by gglu4 with SMTP id u4so2474958ggl.19
        for <git@vger.kernel.org>; Sat, 02 Jun 2012 16:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=C+QUvuqVJyHRzDv4Ie2/HFzqUGAnYL5yANVjGJ9YEZs=;
        b=FTK/PxudL6uVWYBIGXQgxdkzQMEU3T+0h7aGTXx6WhHBPoWHSN57Rgznjh/te8wGQJ
         syncg+VL/YaQYyZJXecMS2YEELWlb3zDjvEpjTj7Rs7zG2hASxeGGYTZwl90p9JAhFdx
         fUb+PkKqkRugPsIKbyc3Zfau8/Xak0CFCVkp1dzcbK9LUW8qI64Xun6c83IDKj3vRVS8
         oaLE9GLNzSstQ6pvaIAC0fMXnExVqpLRsm482Osoi4F59FjYgdPHsosviXCekN9CmBGq
         gODAwncttvNHD6bIfac+z2kuuP2jc4S5lLzJkHaT3zi/F57Iip1YJNq2JEwBydYgvQek
         XGrQ==
Received: by 10.236.192.169 with SMTP id i29mr2692612yhn.100.1338680869924;
 Sat, 02 Jun 2012 16:47:49 -0700 (PDT)
Received: by 10.236.29.230 with HTTP; Sat, 2 Jun 2012 16:47:29 -0700 (PDT)
In-Reply-To: <7vmx4lz5bm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199064>

On 2 June 2012 16:01, Junio C Hamano <gitster@pobox.com> wrote:
> Jim Meyering <jim@meyering.net> writes:
>
>> Use http://github.com/lyda/misspell-check to identify many typos.
>> Culprits identified and fixed automatically using these commands,
>> converting diagnostics to single-quote-safe sed -i commands:
>>
>> git ls-files|misspellings -f -|perl -nl \
>> =C2=A0 -e '/^(.*?)\[(\d+)\]: (\w+) -> "(.*?)"$/ or next;' \
>> =C2=A0 -e '($file,$n,$l,$r)=3D($1,$2,$3,$4); $q=3D"'\''"; $r=3D~s/$q=
/$q\\$q$q/g;'\
>> =C2=A0 -e 'print "sed -i $q${n}s!$l!$r!$q $file"' \
>> =C2=A0| grep -vE '\.po$|pt_BR' > k
>>
>> Filter out s/seeked/sought/ false positives (they relate to cg-seek)=
:
>> =C2=A0 grep -vE 'seeked' k > j && mv j k
>
> ??
>> diff --git a/Documentation/RelNotes/1.5.4.4.txt b/Documentation/RelN=
otes/1.5.4.4.txt
>> index 323c1a8..83453db 100644
>> --- a/Documentation/RelNotes/1.5.4.4.txt
>> +++ b/Documentation/RelNotes/1.5.4.4.txt
>> @@ -21,7 +21,7 @@ Fixes since v1.5.4.3
>>
>> =C2=A0 * "git send-email" in 1.5.4.3 issued a bogus empty In-Reply-T=
o: header.
>>
>> - * "git bisect" showed mysterious "won't bisect on seeked tree" err=
or message.
>> + * "git bisect" showed mysterious "won't bisect on sought tree" err=
or message.
>
> ??

http://en.wiktionary.org/wiki/seeked
