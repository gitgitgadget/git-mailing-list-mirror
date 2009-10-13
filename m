From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git 1.6.5-rc git clone unhandled exception using http
 protocol
Date: Tue, 13 Oct 2009 12:53:28 +0200
Message-ID: <4AD45C28.4080501@viscovery.net>
References: <4ACF7296.3010809@gmail.com> <be6fef0d0910100355v41de0771m30c153f413a46d2e@mail.gmail.com> 	<4AD09F5E.9090304@gmail.com> <be6fef0d0910100811l325d3df1jdf8d3d9dd51e3385@mail.gmail.com> 	<4AD0AE84.1070500@gmail.com> <be6fef0d0910100907t61ea922bqf117e6c025e94ce7@mail.gmail.com> 	<4AD0BBCB.8000306@gmail.com> <d2e97e800910130310wa9731a6j9b9bdd25047ade85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: eduard stefan <eduard.stefan@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>, Git Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com
To: Michael Wookey <michaelwookey@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 12:53:57 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f143.google.com ([209.85.221.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxf0u-0003lH-Ez
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 12:53:56 +0200
Received: by mail-qy0-f143.google.com with SMTP id 7so10053715qyk.15
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 03:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:received
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-spam-score:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=5XiPTpvpkubb/yOmHYEPudrpYQDbZUr9pe71BfvpdMQ=;
        b=6RSmnrao69KvNB5oa9adWk+hdf/kiHCKeCVpcC4dTw750ELv5vXO5qsInWv+Nge7AG
         0F/yb5JiPORuGB2xLssuUoi60nQw4ATtpOkGx3D8kYQmFNsv/WjvhbaNxASUmUQZpPrZ
         EztO8H6/zkyZ9PnBqvXtMlQcYASv8Ps/RkVRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-spam-score:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=bq8IhV0JsIzYACQcKAZQwBRrOf6b9zi5xBsvq2UJfdrJvEp9coHreI6shfjJGiQ+Ld
         sMQCJ2LQ87YW8y2csI/aAX3mNrxHmYe/2WPEBPNK7fLCeQxoQPdMb/uXXm7SO6P+8LJw
         f7p0fnkGfo7nxN6PrX4e452sbCFzNNMFjSuoc=
Received: by 10.224.68.12 with SMTP id t12mr326468qai.12.1255431229784;
        Tue, 13 Oct 2009 03:53:49 -0700 (PDT)
Received: by 10.176.133.2 with SMTP id g2gr7385yqd.0;
	Tue, 13 Oct 2009 03:53:37 -0700 (PDT)
X-Sender: j.sixt@viscovery.net
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.223.16.88 with SMTP id n24mr88950faa.28.1255431216284; Tue, 13 Oct 2009 03:53:36 -0700 (PDT)
Received: by 10.223.16.88 with SMTP id n24mr88949faa.28.1255431216265; Tue, 13 Oct 2009 03:53:36 -0700 (PDT)
Received: from lilzmailso02.liwest.at (lilzmailso02.liwest.at [212.33.55.13]) by gmr-mx.google.com with ESMTP id 14si172105fxm.3.2009.10.13.03.53.36; Tue, 13 Oct 2009 03:53:36 -0700 (PDT)
Received-SPF: neutral (google.com: 212.33.55.13 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) client-ip=212.33.55.13;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 212.33.55.13 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) smtp.mail=j.sixt@viscovery.net
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com) by lilzmailso02.liwest.at with esmtpa (Exim 4.69) (envelope-from <j.sixt@viscovery.net>) id 1Mxf0S-0007Uj-TX; Tue, 13 Oct 2009 12:53:29 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95]) by linz.eudaptics.com (Postfix) with ESMTP id 9ADAA9614; Tue, 13 Oct 2009 12:53:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <d2e97e800910130310wa9731a6j9b9bdd25047ade85@mail.gmail.com>
X-Spam-Score: -1.4 (-)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130156>


Michael Wookey schrieb:
> Using the above repository, I see the same crash with msysGit at git
> revision 1.6.5. Using windbg as the post-mortem debugger, the
> following information is captured:
> 
>   (a14.e8c): Access violation - code c0000005 (!!! second chance !!!)
>   eax=00000000 ebx=00000000 ecx=ffffffff edx=0046cc00 esi=0046f98f edi=00000000
>   eip=00420354 esp=0022fd80 ebp=0022fda8 iopl=0         nv up ei pl zr na pe nc
>   cs=001b  ss=0023  ds=0023  es=0023  fs=003b  gs=0000             efl=00010246
> 
> ...and the faulting instruction is:
> 
>   git_remote_curl+0x20354:
>   00420354 f2ae            repne scas byte ptr es:[edi]
> 
> so, a NULL dereference. The initial disassembly of the function is this:
> 
>   0:000> u 0042033C
>   git_remote_curl+0x2033c:
>   0042033c 55              push    ebp
>   0042033d 89e5            mov     ebp,esp
>   0042033f 57              push    edi
>   00420340 56              push    esi
>   00420341 53              push    ebx
>   00420342 83ec1c          sub     esp,1Ch
>   00420345 8b5d08          mov     ebx,dword ptr [ebp+8]
>   00420348 8b750c          mov     esi,dword ptr [ebp+0Ch]
>   0042034b 31c0            xor     eax,eax
>   0042034d b9ffffffff      mov     ecx,0FFFFFFFFh
>   00420352 89df            mov     edi,ebx
>   00420354 f2ae            repne scas byte ptr es:[edi]
>   00420356 f7d1            not     ecx
>   00420358 8d51ff          lea     edx,[ecx-1]
>   0042035b b9ffffffff      mov     ecx,0FFFFFFFFh
>   00420360 89f7            mov     edi,esi
>   00420362 f2ae            repne scas byte ptr es:[edi]
>   00420364 f7d1            not     ecx
>   00420366 49              dec     ecx
>   00420367 7466            je      git_remote_curl+0x203cf (004203cf)
>   00420369 85d2            test    edx,edx
>   0042036b 0f84b1000000    je      git_remote_curl+0x20422 (00420422)
>   00420371 89f7            mov     edi,esi
>   00420373 89de            mov     esi,ebx
>   ...
> 
> So its the first parameter that is NULL. The second parameter is:
> 
>   0:000> da poi(ebp+c)
>   0046f98f  "libexec/git-core"
> 
> I don't know how to build msysGit so that symbols are generated so
> I've attempted to reconstruct the source code; which ends up looking
> something like the following:
> 
>   int some_unknown_func(char *arg1, char *arg2)
>   {
>       len1 = strlen(arg1) - 1;  // <- crash here
>       len2 = strlen(arg2);
>       len3 = len2 - 1;
> 
>       if (len2 != 1) {
>           if (!len1)
>               return 0;
>           for (;;) {
>               x = arg1[len1 - 1];
> 
>               if (x != '/' && x != '\\') {
>                   --len1;
>                   --len3;
>                   if (arg1[len1] != arg2[len3])
>                       return 0;
>               } else {
>                   ...
>               }
>           }
>       }
>   }
> 
> Perhaps those more familiar with git's sources might recognise code
> that looks similar to the above sequence.

Wow, this is great work, thank you very much! The function is
strip_path_suffix(). And here is a patch that fixes the crash.

--- >8 ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] remote-curl: add missing initialization of argv0_path

All programs, in particular also the stand-alone programs (non-builtins)
must call git_extract_argv0_path(argv[0]) in order to help builds that
derive the installation prefix at runtime, such as the MinGW build.
Without this call, the program segfaults (or raises an assertion
failure).

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 remote-curl.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index ad6a163..d8d276a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -82,6 +82,7 @@ int main(int argc, const char **argv)
 	const char *url;
 	struct walker *walker = NULL;

+	git_extract_argv0_path(argv[0]);
 	setup_git_directory();
 	if (argc < 2) {
 		fprintf(stderr, "Remote needed\n");
-- 
1.6.5.1024.g31034.dirty
