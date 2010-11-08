From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: history missing
Date: Mon, 8 Nov 2010 14:48:10 +0100
Message-ID: <201011081448.10723.jnareb@gmail.com>
References: <AANLkTikFB5HNOmg0iTdjHxtrhU9vdua5O8btgFzpg-2F@mail.gmail.com> <m3mxpkeyh4.fsf@localhost.localdomain> <AANLkTin2-WAHMjKFKVqq7Wbzvjg-KzMkBh1kCGxDH6Mf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Vitaliy Semochkin <vitaliy.se@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 14:48:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFS5D-00015x-VN
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 14:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab0KHNsV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 08:48:21 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34430 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541Ab0KHNsU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 08:48:20 -0500
Received: by bwz11 with SMTP id 11so4852881bwz.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 05:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=73eCeMFf/JD+ITYwaJ2bSDz5T0WK+FhYXoCp+gI7tPY=;
        b=f9eJk1yx47czwDEXcP6wMlmB8w1eUp3OFKPZ0kYwrAuyWf1Qv7uRJtN5+QidKjvDav
         XT7N18bNCyGQNYXk601kFw7xvqyXRkLXGYCVZ3dGQU78Reb8Q/nsLF3HcgV1Gmyt3MfG
         2zzumhVoBQzZ5KvvFWNRxujIZkfyVpTCgtX0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZA5Q/+9MkPHVvnUA6m9f66VPT8egY4Mj72xrE8ce02Se3oDixc0BfnKeGxXFYTWQQ7
         2tDHLonw9awPKZWFb9kdXk7lXNf1tS2eAkqMBOQ1h+JmNu2JDsKYEA29rEKUoXH4v2aq
         j8/SFb4WER1LoiIM9qFw3d4MUG42KZEFcwvrE=
Received: by 10.204.76.79 with SMTP id b15mr4868863bkk.168.1289224099485;
        Mon, 08 Nov 2010 05:48:19 -0800 (PST)
Received: from [192.168.1.13] (abvu240.neoplus.adsl.tpnet.pl [83.8.218.240])
        by mx.google.com with ESMTPS id v1sm2302453bkt.5.2010.11.08.05.48.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 05:48:18 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTin2-WAHMjKFKVqq7Wbzvjg-KzMkBh1kCGxDH6Mf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160939>

On Mon, 8 Nov 2010, Martin von Zweigbergk wrote:
> On Mon, Nov 8, 2010 at 8:29 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>>> On Mon, Nov 8, 2010 at 4:02 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>>>> Vitaliy Semochkin wrote:
>>>>
>>>>> I cloned a remote repository
>>>>> to check recent changes in origin/master I do:
>>>>> git fetch origin master
>>
>> This fetches into FETCH_HEAD _only_ from "origin" *remote*.
>>
>>>>> git log origin master
>>
>> This show log of 'origin/HEAD', which probably is 'origin/master'...
>> but which didn't get updated, and local branch 'master'.
>>
>>>>>
>>>>> recently I found out that log doesn't show recent commits
>>>>
>>>> Yes, this can be confusing.
>>>
>>> I agree and I believe this has come up a lot of times before. I tal=
ked
>>> to Jeff and Junio about this at GitTogether and Jeff said he has a =
patch
>>> for it that he would try to get up to date in a while. (Thanks, Jef=
f!)
>>
>> How can this issue be solved? =A0The meaning of parameters in 'git f=
etch'
>> is different from meaning of parameters in 'git log'.
>=20
> Sorry, maybe I misunderstood what the confusion was about. What I was
> referring to was the confusion caused by 'git fetch origin master' no=
t
> updating 'refs/remotes/origin/master'.

Should it really do it?  What if it does not exist?  What if <remote>
is specified via URL?

If I understand correctly current behavior of 'git fetch <remote> <bran=
ch>'
wrt. FETCH_HEAD was meant for one-off 'git pull <remote> <branch>', or
rather 'git pull <URL> <branch>'.

Sidenote: if original poster used

  $ git fetch origin
  $ git log origin

I think everything would be all right.

--=20
Jakub Narebski
Poland
