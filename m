From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: [PATCH bc/connect-plink] t5601-clone: remove broken
 and pointless check for plink.exe
Date: Thu, 13 Aug 2015 09:30:40 +0200
Organization: gmx
Message-ID: <43f88e9611755e20715bf9f38795f276@www.dscho.org>
References: <55CA6066.5070500@kdbg.org>
 <866a41f50ef9b4807da72576a4bca717@www.dscho.org>
 <CABPQNSZHtAKbe6JwxRoK3LpCabfp6r2_kTmF1qokObt_yKnSDg@mail.gmail.com>
 <55CB9110.4060005@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: kusmabite@gmail.com, Git Mailing List <git@vger.kernel.org>, msysGit
 <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBCZPH74Q5YNRBJEPWGXAKGQEAEYQAEQ@googlegroups.com Thu Aug 13 09:30:46 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBJEPWGXAKGQEAEYQAEQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f183.google.com ([209.85.217.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBJEPWGXAKGQEAEYQAEQ@googlegroups.com>)
	id 1ZPmyL-0008Ol-Cz
	for gcvm-msysgit@m.gmane.org; Thu, 13 Aug 2015 09:30:45 +0200
Received: by lbck9 with SMTP id k9sf9430885lbc.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 13 Aug 2015 00:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:content-transfer-encoding:date:from:to:cc
         :subject:organization:in-reply-to:references:message-id:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-spam-checked-in-group:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=/AhUfxFtf5E9wwxLKiQQcCqXCysAf5R7tgZ4dQ8aNxY=;
        b=EQa+Zqxf4CjfEHaXzMYIxT2reCljZAW113jJWeD2RhuZHIItBKQOmjp7tNINm+21Sa
         dt7ciJ3zYZ8JNcv/17aS9GEuAXsRgyqnI0CQv+hmqqGlH8fZqn/gG7X5ukr4VCIwWVaJ
         vj6fBoHx5MZ7i8eF75iXfsQsKrZx0ziQxaZSbcDmPrDwwXmCs4qCHZwEyLsLKGb05Uul
         lLeStA9nZJAAMdFcvPktVvG8W1EoL+svN3S6gHpqHkuC7q4Zwfvi8psVYwBwt+31M5fA
         Ep4KsYaijIj3oZmiIsSTIeRSFQfMovxAqMhUxSS076IesWqGEOlNtfCTbfmATfU8 
X-Received: by 10.180.79.35 with SMTP id g3mr120182wix.17.1439451045057;
        Thu, 13 Aug 2015 00:30:45 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.37.144 with SMTP id y16ls315593wij.38.gmail; Thu, 13 Aug
 2015 00:30:43 -0700 (PDT)
X-Received: by 10.180.89.104 with SMTP id bn8mr4771370wib.4.1439451043838;
        Thu, 13 Aug 2015 00:30:43 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id x20si52691wia.0.2015.08.13.00.30.43
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 00:30:43 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MMoU7-1ZRjSA1w9H-008Wqp; Thu, 13 Aug 2015 09:30:41
 +0200
In-Reply-To: <55CB9110.4060005@kdbg.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:zMgaTyfUTQBRx8lbpQHUKebprE0hybNmVVLKgwrN2LoW/V0i7Yg
 9TwDL/tdz+56C7/wjVnnojWHFKLY2hOx3mQ1gT3Vnb3plb681R8iG8ZlFvvlbnoslyqbwmm
 stQV+cVSY3LwClWfx5PYBOJVlNMN82ZYzGfCgpC+OjzzKETpXEzccG4+8CmSlCtnxX5BT8P
 j6MzfbMKtR3qzhaBpGXtw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0wW945cK/K8=:tXr91hkssDtr/dkdYbGGPz
 gtKS0FWUGezaDLZpzP4uBGeFcy3sZ51BpsH4WwH1cNYQY6wSRg7/cSFTgke4A/Yh5UXN+GnVq
 JPbaOcYFXV2DJZ0nBOLr2ohDLTn45TSJdCHcXAP4X73iO0WcOXvE2/F4rdaVonVEIFR2Ry0s0
 O9NTlKLG+LesYrPNMbgyUh7RIp7Fauf8ul5nVNp09LN0lzl5lDLYQ4mSgVVeSbEATRwR1iCZY
 aW/oUncUVuovG1J7noI35HkflpAvhlNKmcLkEqqXIOKkRg+xjbE8rAxWji9p1qA1jFKqcQId9
 QXZc89FWhDy5MdrA02ZsUqVIGy8h9JSPDFY6U0+vqYQuq3gCtKD41PHk1wJ+FIgY87Iu/7wId
 giUOGDtWIzcEV8yUiicopoFptTSH9hCZA+xYHewkxrXMKCpD07qpmu+B4a7PENmj0QmcpLNz1
 Ml7Cv4A3IHNnrohwtYbbGltyNj+UAB8ZmerdoS+Tt1eHvUbeo0e45iE3f8g99YaPq3VGPLo0j
 Ce5EvrWJ4moCeUDUHIJzA319jKiHLYpoX7AFetbUdFaoRmneXM+TYAGZgjvXyS7RIiXc2+GI6
 JUVj476CXI5Mc9lPgipzyZxDU22NVvz+o8wc4n3s8e0hpO3tAfgkdrQPXOMl+8MgqcPERUFEa
 +YcUL3/PSi8UWITie7RWOV3ViKSWpIyVIV40tnHfET685rS3/XX9bKQgb2zK+Gf+5M+qnvEVb
 FrJXonphP9SZPBEp8fNui4LoHzz1PhXrWR1AKA==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as
 permitted sender) smtp.mailfrom=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275833>

Hi Johannes,

On 2015-08-12 20:31, Johannes Sixt wrote:
> Am 12.08.2015 um 13:58 schrieb Erik Faye-Lund:
>> On Wed, Aug 12, 2015 at 1:07 PM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>>> FWIW Git for Windows has this patch (that I wanted to contribute
>>> in  due time, what with being busy with all those tickets) to solve the
>>> problem mentioned in your patch in a different way:
>>>
>>> https://github.com/git-for-windows/git/commit/2fff4b54a0d4e5c5e2e4638c9=
b0739d3c1ff1e45
>>
>> Yuck. On Windows, it's the extension of a file that dictates what kind
>> of file it is (and if it's executable or not), not the contents. If we
>> get a shell script written with the ".exe"-prefix, it's considered as
>> an invalid executable by the system. We should consider it the same
>> way, otherwise we're on the path to user-experience schizophrenia.
>>
>> I'm not sure I consider this commit a step in the right direction.
>=20
> I, too, think that it is a wrong decision to pessimize git for the
> sake of a single test case.

Oh, you make it sound as if you believe that I had indeed weakened Git *jus=
t* for a single test case.

That is quite a strong assumption, and could not be further from the truth,=
 though, I have to point out. It is important to keep in mind that we (actu=
ally, IIRC it was you) taught Git to recognize shell scripts when executing=
 external programs *because Windows does not do that for us*. So yes, we ar=
e deviating from the standard Windows way of things, and we do that quite i=
ntentionally so.

Now, let's look at the test case for a moment and let's try to understand t=
he technique it uses (that breaks the test case currently). It puts a scrip=
t in place of an `.exe`, with the intention to execute the script instead o=
f the original executable.

This technique is an age-old technique on Unix, and it just works. There ar=
e a range of valid reasons, from debugging to slightly modifying the functi=
on of a particular `.exe` (possibly renaming the original `.exe` and callin=
g it from the script) in the easiest way: by scripting on top of it.

If we want to allow such a thing -- allowing users to use scripts to modify=
 the behavior of executables -- then we *have* to allow `.exe` suffixes for=
 scripts, because that happens to be the suffix of executables on Windows.

I guess you would have had an easier time to understand my thinking if I ha=
d replaced the sentence

    So the assumption that the `.exe` extension implies that the file is *n=
ot* a shell script is now wrong.

by

    So this is a strong indicator that it was wrong to assume that `.exe` e=
xtensions imply that the file is *not* a shell script.

Further, I even looked at the performance impact, but that is at least well=
 documented in the commit message.

I also have to point out that the alternative "solution" presented by your =
patch -- to disable the test case -- is no solution at all: the very platfo=
rm that is most likely to have plink users is Windows. And to *exclude* tha=
t platform from running that unit test is questionable at best.

Ciao,
Johannes

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
