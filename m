From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [ANNOUNCE] GIT 1.5.6.1
Date: Tue, 1 Jul 2008 13:29:26 +0200
Message-ID: <3675460F-F3DE-4EE4-B6E9-0FFE36B8A5BC@zib.de>
References: <7vmylixr6h.fsf@gitster.siamese.dyndns.org> <7v3an0u367.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Jul 01 13:30:38 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.245])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDe4D-0005KY-D5
	for gcvm-msysgit@m.gmane.org; Tue, 01 Jul 2008 13:30:37 +0200
Received: by wa-out-0708.google.com with SMTP id n36so5917136wag.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2008 04:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=N3f4Sk8xVcd+jvI1LesBqQNdUDolINK+ktu6Wksc3qY=;
        b=N1gRQa1a9du1Hptv1/vX7uIGBOOi8LBiu+9aUX7j/tPx+pGieLKC6ZaGBg37lxBuMu
         I6oDVsbH3HYcFJMCHeJ7SLLwK4cmP0jSCY3qtCqe5bN8bc8qZfmmoul93J5C9/Btytbi
         HtbOu+GJyLqP86/t+5N4o+qBHPYO+T8B+/NWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=VuT8hae/Vlw8a/Lw8zNU6sAyh1ox3+ZKfLYCjA6XaHxpGLQOLk2YysTSG58EkxkF3D
         L+rgyWbBRlFzArCkVfbZRbGFWP06YvxI2dCiSQTaoAsZPn5aK9xYnyaYhjKGlh3n7ZR0
         2SsLOFVUNaYnb17S7iGLL56AJKZnNoTeboCL0=
Received: by 10.114.149.2 with SMTP id w2mr455188wad.12.1214911761392;
        Tue, 01 Jul 2008 04:29:21 -0700 (PDT)
Received: by 10.107.3.34 with SMTP id f34gr2535pri.0;
	Tue, 01 Jul 2008 04:29:21 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.100.95.19 with SMTP id s19mr3589440anb.11.1214911760385; Tue, 01 Jul 2008 04:29:20 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 39si6513346yxd.0.2008.07.01.04.29.19; Tue, 01 Jul 2008 04:29:20 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m61BT7Sg024426; Tue, 1 Jul 2008 13:29:12 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db92d82.pool.einsundeins.de [77.185.45.130]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m61BT20C007946 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Tue, 1 Jul 2008 13:29:02 +0200 (MEST)
In-Reply-To: <7v3an0u367.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87025>



On Jun 26, 2008, at 8:21 AM, Junio C Hamano wrote:

> The latest maintenance release GIT 1.5.6.1 is available at the
> usual places:


The msysgit release is available at

    http://code.google.com/p/msysgit/downloads

Besides GIT 1.5.6.1, the installer also brings an updated
msys-1.0.dll that works on Vista.

	Steffen
