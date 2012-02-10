From: David Barr <davidbarr@google.com>
Subject: Re: fatal: Unable to find remote helper for 'https'
Date: Fri, 10 Feb 2012 13:25:30 +1100
Message-ID: <CAFfmPPOxFn2=Z9EcYKpe+j9gTQ8V6G4jZHXJAJZ60NzWHyaT+Q@mail.gmail.com>
References: <loom.20120209T224147-400@post.gmane.org>
	<CALUzUxq=5iJJNcXH-Xg1htZzGFVT4f5WQS=dy4k7Y_mRemXMSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nickolai Leschov <nleschov@gmail.com>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 03:26:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvgBW-0003Ml-6V
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 03:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758071Ab2BJCZd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 21:25:33 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43926 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683Ab2BJCZc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 21:25:32 -0500
Received: by yhoo21 with SMTP id o21so1271171yho.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 18:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=34Fsn4ENqhKvNn6CcOMQGABeL5FgGW9saCTJRJw6Xq0=;
        b=OYIv/qyxGEQ7pHdf4cMKaOMPkN1n78QKxtufgiQzkhb0VStrB4jWNM8OTaGDW5GX1b
         h6No3LIs4muIcpzEHeNB0FDnlgBfUgYw2sAR63aaTzxYbEEy5mTU5R9m1r1MuKBWqK1C
         03lvrtHkjSSUxgkeB5P09ccHxMQTS4MSPibZA=
Received: by 10.236.173.132 with SMTP id v4mr6145969yhl.78.1328840731581;
        Thu, 09 Feb 2012 18:25:31 -0800 (PST)
Received: by 10.236.173.132 with SMTP id v4mr6145912yhl.78.1328840730397; Thu,
 09 Feb 2012 18:25:30 -0800 (PST)
Received: by 10.101.197.7 with HTTP; Thu, 9 Feb 2012 18:25:30 -0800 (PST)
In-Reply-To: <CALUzUxq=5iJJNcXH-Xg1htZzGFVT4f5WQS=dy4k7Y_mRemXMSw@mail.gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQk+vvTu5OYjcNRMNeYRMzvPgQnG2YrrlSJ2XT1G91VYCYgDsUV0LHYEDRaDf8pj00v3LPYRDyikT+OC8/QHD+MKGRoH6n7HaKDL5xuG2N0GBQJTesRtYClWIHgxZbRjKk5MeOPzD9NyNFvKhdpEdCUkbquJVw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190369>

On Fri, Feb 10, 2012 at 11:25 AM, Tay Ray Chuan <rctay89@gmail.com> wro=
te:
> Have you installed libcurl4-(gnutls|openssl)-dev? You'll need to
> choose between gnutls and openssl for the underlying ssl
> implementation.
>
> --
> Cheers,
> Ray Chuan
>
>
> On Fri, Feb 10, 2012 at 5:51 AM, Nickolai Leschov <nleschov@gmail.com=
> wrote:
>> Hello,
>>
>> I have compiled git 1.7.9 from source on Ubuntu 9.04 and I get the f=
ollowing
>> message when cloning a git repo:
>>
>> fatal: Unable to find remote helper for 'https'
>>
>> I get this message when I try to use https; or similar one for http.=
 Only
>> cloning via git:// protocol works. My system is Ubuntu 9.04 i386. gi=
t 1.7.9 and
>> two previous versions I tried all exhibit this problem. I have unins=
talled the
>> git that comes in Ubuntu repositories and build from source instead =
because I
>> need a newer version.
>>
>> How can I make git work on that system?
>>
>> I have another system with Ubuntu 11.04 i386 and it there git 1.7.4.=
1 (from
>> repositories) doesn't exhibit such problem.
>>
>> Best regards,
>>
>> Nickolai Leschov
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

You might be interested in the git PPA:
https://launchpad.net/~git-core/+archive/ppa

I noticed that there is no Jaunty package for git 1.7.9, so I asked
the maintainer about it.

"Jaunty is long past EOL, and I don't think the PPA builders still
work with it. =A0You can try the hardy or lucid builds."
- andersk

--
Hope this helps,
David Barr
