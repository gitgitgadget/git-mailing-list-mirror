From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Re: Probably a bug with "~" symbol in filenames on
 Windows 7 x64 in git 1.9.5
Date: Thu, 08 Jan 2015 17:37:26 +0100
Message-ID: <54AEB246.4010109@web.de>
References: <CADb7K9rELHWgy_NYJWrSr9gZn7pcMvETv93d0j+u2fXinj5iTg@mail.gmail.com> <CAPc5daVddkaMkx=43nCeQKbbkrV6nExOqvEBJNyugzDQB2n6kQ@mail.gmail.com> <alpine.DEB.1.00.1501081100570.21312@s15462909.onlinehome-server.info> <20150108102815.GA4806@peff.net> <54AE7F46.9060103@web.de> <alpine.DEB.1.00.1501081652230.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Git Mailing List <git@vger.kernel.org>,
 Dmitry Bykov <pvrt74@gmail.com>, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?B?VG9yc3Rlbg==?=
 =?UTF-8?B?IELDtmdlcnNoYXVzZW4=?= <tboegi@web.de>
X-From: msysgit+bncBCUZ3EUT2ADRBUXEXKSQKGQESABNFKI@googlegroups.com Thu Jan 08 17:38:05 2015
Return-path: <msysgit+bncBCUZ3EUT2ADRBUXEXKSQKGQESABNFKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f63.google.com ([209.85.220.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCUZ3EUT2ADRBUXEXKSQKGQESABNFKI@googlegroups.com>)
	id 1Y9G5b-0003ib-Q0
	for gcvm-msysgit@m.gmane.org; Thu, 08 Jan 2015 17:37:40 +0100
Received: by mail-pa0-f63.google.com with SMTP id bj1sf1392547pad.8
        for <gcvm-msysgit@m.gmane.org>; Thu, 08 Jan 2015 08:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=lUzzIe//5GNTY1Bk2Q1j+3IJulaem0FXVMCrRQkrntM=;
        b=mlywTaDJHeAI1UPhE6IKWoa2S2x+adkde40V+eJxuBeUuns2ogs7WavV5AyjIZUyMV
         6a0yNPv3d1KigYAD3Ey+BgJ6A+omY22fxCL4GGXGVDy2xz5JuaA7i2V1eWgkGdgactxe
         AoYfF7MCMl/bfwhSgLhHwQiI7popSCk45FrbuzP+7GZRxSGIOWSBzPsTiZtQzHtfkmRQ
         zQZvzmQcPedtSCGzk7bTFhPMV52tly6qgaY+V03AaeF/DvbhyiAKub8kB8U8wzci8/VN
         mSiskYx1MKozVOlBPjPQC+FuRDsPbDRbuhkIOBL4GG2zrsNPPTZ8b9UScmVppe5l2x5D
         9XQg==
X-Received: by 10.140.28.180 with SMTP id 49mr230525qgz.4.1420735058975;
        Thu, 08 Jan 2015 08:37:38 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.95.75 with SMTP id h69ls1175604qge.92.gmail; Thu, 08 Jan
 2015 08:37:38 -0800 (PST)
X-Received: by 10.224.121.204 with SMTP id i12mr7276841qar.0.1420735058447;
        Thu, 08 Jan 2015 08:37:38 -0800 (PST)
Received: from mout.web.de (mout.web.de. [212.227.15.4])
        by gmr-mx.google.com with ESMTPS id e5si550014igy.2.2015.01.08.08.37.38
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2015 08:37:38 -0800 (PST)
Received-SPF: pass (google.com: domain of tboegi@web.de designates 212.227.15.4 as permitted sender) client-ip=212.227.15.4;
Received: from [192.168.209.17] ([78.72.72.190]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MdpWf-1YSIVi3UfF-00PgH7; Thu, 08 Jan 2015 17:37:31
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <alpine.DEB.1.00.1501081652230.21312@s15462909.onlinehome-server.info>
X-Provags-ID: V03:K0:teVbggBBQkUho9hA3VM9u5FxjZs+vie1NQr7n8Nibu//QmULoOG
 LEXEI7jldmQbbI+CnjjPnvICVT4qi2n7dtTsRAUemfDe/rCuYhmXq9TQ8RsyGCmFGnEj0ag
 msohSdyG+XubNJtYIa/d5P+ijlWCHSK7IdFETqTDdz9BNIVo1EI0CG+tZjk2F6asXhZUQti
 cn2IjhSJT07JGfogiGNRA==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: tboegi@web.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of tboegi@web.de designates 212.227.15.4 as permitted
 sender) smtp.mail=tboegi@web.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262199>

On 01/08/2015 04:58 PM, Johannes Schindelin wrote:
> Hi Torsten,
>=20
> On Thu, 8 Jan 2015, Torsten B=C3=B6gershausen wrote:
>=20
>> There is something more then just the "tilde" protection going on, [...]
>=20
> Indeed. What is going on is that you build Git yourself, from git.git,
> while Dmitry obviously used Git for Windows -- which carries a couple of
> patches on top of upstream git.git.
>=20
> In this particular case, the tilde protection was introduced in
> https://github.com/msysgit/git/commit/2e2a2d12.
>=20
> Ciao,
> Johannes
>=20
My bad, I was building the msysgit master branch, which didn't have the 2e2=
a2d12.

However, I am wondering if 2e2a2d12 is really needed that much ?
In the same spirit that we do not prevent the checkout of "FILE" when "file=
" is present,
why do we prevent people from using "~" in file names ?
When a file is visible under different file names, I assume that the user c=
hooses only
one representation to run "git add" on.
But that is another discussion.

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
