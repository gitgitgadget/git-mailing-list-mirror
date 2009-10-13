From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: Git 1.6.5-rc git clone unhandled exception using http
 protocol
Date: Tue, 13 Oct 2009 22:43:01 +1100
Message-ID: <d2e97e800910130443m56ea2850nf72274fc55a4be68@mail.gmail.com>
References: <4ACF7296.3010809@gmail.com> <be6fef0d0910100355v41de0771m30c153f413a46d2e@mail.gmail.com>  <4AD09F5E.9090304@gmail.com> <be6fef0d0910100811l325d3df1jdf8d3d9dd51e3385@mail.gmail.com>  <4AD0AE84.1070500@gmail.com> <be6fef0d0910100907t61ea922bqf117e6c025e94ce7@mail.gmail.com>  <4AD0BBCB.8000306@gmail.com> <d2e97e800910130310wa9731a6j9b9bdd25047ade85@mail.gmail.com>  <4AD45C28.4080501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Junio C Hamano <gitster@pobox.com>, eduard stefan <eduard.stefan@gmail.com>,  Tay Ray Chuan <rctay89@gmail.com>, Git Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 13:44:33 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f153.google.com ([209.85.212.153])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxfng-0002BC-HG
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 13:44:20 +0200
Received: by vws17 with SMTP id 17so5224426vws.24
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 04:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:content-type
         :content-transfer-encoding:received:in-reply-to:references:from:date
         :message-id:subject:to:cc:x-google-approved:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=823j+NyZjyRU/u5tav8Gb0ryu6xT3pZ1UCLQQlsk3KA=;
        b=pEXkvBiAEjc4UsDtfIklIX3ekvDg+Ucwqi7fo5fdVZhFm/ehxVkhhdPhyWovd7fTlZ
         OJ6ps931+kntPPNEpA8tMxYahPXpcgHFF+FELqkMEu8jDPtLFbJ9HZbM/hVoFbxnsh4H
         cZ3Ig2yfFcjG+hJhMyhTuWtMFe1TouwOGV2do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:content-type
         :content-transfer-encoding:in-reply-to:references:from:date
         :message-id:subject:to:cc:x-google-approved:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=CkP3GYpoYVId1cm4yxkCv9f/xjPxwESXo2DctyDtODRAab6lN0wWmYq/xV0OcjvVE3
         GQbqFmgJyVWxE+xNxsov0otcr3zbXG7f6hkNa/O4x7+MjcGsw0pLFXxMzq+u6oWvdO+B
         jWqQcH8C04joxti3reGapqMaRr3AENTKDFOqw=
Received: by 10.220.82.208 with SMTP id c16mr330924vcl.28.1255434253280;
        Tue, 13 Oct 2009 04:44:13 -0700 (PDT)
Received: by 10.177.117.7 with SMTP id u7gr7386yqm.0;
	Tue, 13 Oct 2009 04:44:12 -0700 (PDT)
X-Sender: michaelwookey@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.220.81.196 with SMTP id y4mr2660854vck.11.1255434202667; Tue, 13 Oct 2009 04:43:22 -0700 (PDT)
Received: by 10.220.81.196 with SMTP id y4mr2660849vck.11.1255434202425; Tue, 13 Oct 2009 04:43:22 -0700 (PDT)
Received: from mail-yx0-f172.google.com (mail-yx0-f172.google.com [209.85.210.172]) by gmr-mx.google.com with ESMTP id 18si396033gxk.1.2009.10.13.04.43.21; Tue, 13 Oct 2009 04:43:21 -0700 (PDT)
Received-SPF: pass (google.com: domain of michaelwookey@gmail.com designates 209.85.210.172 as permitted sender) client-ip=209.85.210.172;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of michaelwookey@gmail.com designates 209.85.210.172 as permitted sender) smtp.mail=michaelwookey@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by yxe2 with SMTP id 2so8964842yxe.18 for <msysgit@googlegroups.com>; Tue, 13 Oct 2009 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :from:date:message-id:subject:to:cc:content-type :content-transfer-encoding; bh=3PUEJWvEwsjHrn87T9kx1mO3iEXQr1Q8jH32vQ5A7BI=; b=kiGbEuyKJUchVd+Ak3FZh8rNoM1gKgFh5XgiC+Ak7U7nivtqhvbpxXLpziWOCT9Oja hnvvC4crxPo4nZNpmRz3pEcds70xXMv64nOD+IoP2fsx2N1FCHzeTXetL8lZ9oLIqhax RXiokK0Dgdyhy6vQs6rxL//2enMzHMUEQ22dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:from:date:message-id:subject:to :cc:content-type:content-transfer-encoding; b=f2EWJ49PUhxsdXhzSScZak+gRMNO+m44W9Wy2h2FwVRmP7nZanRbp22f26mQ3PuIW7 YP40cZUiirN6d3Kb65bUAs3PnKknRXZE3t1X6eZ0slRek3z1gTiJ7nB61i0wRTc7XhAQ BQsMsmro7MET3ONJX38MQMkh3HMf4g1lPcC60=
Received: by 10.91.45.22 with SMTP id x22mr4283547agj.120.1255434201268; Tue,  13 Oct 2009 04:43:21 -0700 (PDT)
In-Reply-To: <4AD45C28.4080501@viscovery.net>
X-Google-Approved: kusmabite@googlemail.com via web at 2009-10-13 11:44:10
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130160>


2009/10/13 Johannes Sixt <j.sixt@viscovery.net>:
> Michael Wookey schrieb:
>> Using the above repository, I see the same crash with msysGit at git
>> revision 1.6.5. Using windbg as the post-mortem debugger, the
>> following information is captured:
>> [ ... snip ... ]
> Wow, this is great work, thank you very much! The function is
> strip_path_suffix(). And here is a patch that fixes the crash.
>
> --- >8 ---
> From: Johannes Sixt <j6t@kdbg.org>
> Subject: [PATCH] remote-curl: add missing initialization of argv0_path
>
> All programs, in particular also the stand-alone programs (non-builtins)
> must call git_extract_argv0_path(argv[0]) in order to help builds that
> derive the installation prefix at runtime, such as the MinGW build.
> Without this call, the program segfaults (or raises an assertion
> failure).
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> =C2=A0remote-curl.c | =C2=A0 =C2=A01 +
> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index ad6a163..d8d276a 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -82,6 +82,7 @@ int main(int argc, const char **argv)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *url;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct walker *walker =3D NULL;
>
> + =C2=A0 =C2=A0 =C2=A0 git_extract_argv0_path(argv[0]);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0setup_git_directory();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (argc < 2) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "R=
emote needed\n");
> --
> 1.6.5.1024.g31034.dirty

No more crashes for me :)

Tested-by: Michael Wookey <michaelwookey@gmail.com>
