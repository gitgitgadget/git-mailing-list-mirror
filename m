From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Re: Windows performance / threading file access
Date: Tue, 22 Oct 2013 17:40:08 +0200
Message-ID: <52669C58.4020801@gmail.com>
References: <CAHOQ7J_ZZ=7j-5ULd7Tdvbiqg4inhwi+fue_w6WAtNRkvZSwsg@mail.gmail.com>	<52570BC1.2040208@gmail.com>	<52574B90.3070309@gmail.com>	<CAHOQ7J_sNnajm9M+QUd-QwkQGP2vOidzAW5_5EzsdwBGTDCnSA@mail.gmail.com>	<3bb056f6-5f8b-486e-8e5e-9bf541bd0d0b@googlegroups.com>	<52601562.2090301@gmail.com>	<49cde110-f3e5-43d9-b399-6b5a6ce59014@googlegroups.com>	<52668C0F.9050702@gmail.com> <CAHGBnuOVpMU6wBmjesYK7qWWpKPyCFhmDcWny7MN5nM4zYFjDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: pro-logic <pro-logic@optusnet.com.au>, 
 msysGit Mailinglist <msysgit@googlegroups.com>,
 Git Mailing List <git@vger.kernel.org>, szager@google.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: msysgit+bncBCH3XYXLXQDBBWFYTKJQKGQEMUFGPMA@googlegroups.com Tue Oct 22 17:40:09 2013
Return-path: <msysgit+bncBCH3XYXLXQDBBWFYTKJQKGQEMUFGPMA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f59.google.com ([74.125.83.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBWFYTKJQKGQEMUFGPMA@googlegroups.com>)
	id 1VYe40-0000ny-O3
	for gcvm-msysgit@m.gmane.org; Tue, 22 Oct 2013 17:40:08 +0200
Received: by mail-ee0-f59.google.com with SMTP id c1sf970eek.14
        for <gcvm-msysgit@m.gmane.org>; Tue, 22 Oct 2013 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=sD4Ba8qH+AZc3hNz24gQJQs8F77Uz7ht3wPABgUjZmI=;
        b=oJiEv/+Jp8WjjbK+B1CDgv36DNvVWhDdzL7spUY9RTTs475epXKVghfznGqkegbVEH
         LRfYelOd9W2c0iB+IKMG7bQQwg3ctOt8VVb1SRId/UfP4gLo6ZgClOms+5c3rxx871fK
         F6G4s6GsMriTxehurgYIbUwkJUOdMo1nWXY1RPmctQXXyj1rBT/+9qh3N4ZH3p/ndxsz
         F2unG/SZlfeAvtHWSfvJddYjfNE1yjYyh4JMAxkyRasSGvU3QHA6bGJtyH4JReLtXhLW
         8pHvz/bemzN8amTtdoYs90+vAaVWjt0PNhIW4aOWlB2mVbakfZdf1ZAHsp1X7fx0KoHZ
         C7VQ==
X-Received: by 10.152.26.163 with SMTP id m3mr48876lag.24.1382456408451;
        Tue, 22 Oct 2013 08:40:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.8.193 with SMTP id t1ls55193laa.23.gmail; Tue, 22 Oct 2013
 08:40:07 -0700 (PDT)
X-Received: by 10.152.37.165 with SMTP id z5mr8637268laj.6.1382456407613;
        Tue, 22 Oct 2013 08:40:07 -0700 (PDT)
Received: from mail-ee0-x22c.google.com (mail-ee0-x22c.google.com [2a00:1450:4013:c00::22c])
        by gmr-mx.google.com with ESMTPS id a1si420986ees.1.2013.10.22.08.40.07
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Oct 2013 08:40:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::22c as permitted sender) client-ip=2a00:1450:4013:c00::22c;
Received: by mail-ee0-f44.google.com with SMTP id b47so4570539eek.31
        for <msysgit@googlegroups.com>; Tue, 22 Oct 2013 08:40:07 -0700 (PDT)
X-Received: by 10.14.216.136 with SMTP id g8mr3171241eep.61.1382456407543;
        Tue, 22 Oct 2013 08:40:07 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id m54sm58234044eex.2.2013.10.22.08.40.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Oct 2013 08:40:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <CAHGBnuOVpMU6wBmjesYK7qWWpKPyCFhmDcWny7MN5nM4zYFjDA@mail.gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::22c
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236477>

Am 22.10.2013 16:49, schrieb Sebastian Schuberth:
> On Tue, Oct 22, 2013 at 4:30 PM, Karsten Blees <karsten.blees@gmail.com> =
wrote:
>=20
>>>> Could you post details about your test setup? Are you still using
>>>> WebKit for your tests?
>>> I'm on Win7 x64, Core i5 M560, WD 7200 Laptop HDD, NTSF, no virus
>>> scanner, truecrypt, no defragger.
>>>
>>
>> OK, so truecrypt and luafv may screw things up for you (according to my =
measurements, luafv roughly doubles lstat times on C:).
>=20
> Aren't we disabling UAC / LUAFV on a per-executable basis using
> manifests? At least the blog article at [1] suggests that we are in
> fact doing it the right way using our script to genera the manifests
> [2].
>=20
> Oh but wait, we're not generating a manifest for git.exe itself, only
> for executables that contain "setup", "install", "update", "patch"
> etc. So maybe having a manifest for git.exe, too, would improve
> performance?
>=20

Even with UAC disabled in control panel, the luafv.sys driver slows things =
down on C: (no impact on non-system drives). Procmon shows that with disabl=
ed luafv, GetFileAttributesEx is a single FASTIO call. With luafv running, =
FASTIO fails and is followed by three IRP calls (open, query, close).

I haven't tried with UAC enabled, or if disabling virtualization for git.ex=
e has an impact.

Karsten

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
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
