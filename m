From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 12/12] [TODO] setup: bring changes from
 4msysgit/next to next
Date: Wed, 2 Jul 2008 19:08:09 +0200
Message-ID: <D35A2542-3943-4BDB-AEDA-0F8B7052EF7D@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <1214987532-23640-7-git-send-email-prohaska@zib.de> <1214987532-23640-8-git-send-email-prohaska@zib.de> <1214987532-23640-9-git-send-email-prohaska@zib.de> <1214987532-23640-10-git-send-email-prohaska@zib.de> <1214987532-23640-11-git-send-email-prohaska@zib.de> <1214987532-23640-12-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0807021716030.9925@racer>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, Junio C Hamano <gitster@pobox.com>, Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 19:09:03 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.25])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE5pC-0006Mu-BT
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 19:08:58 +0200
Received: by yx-out-2122.google.com with SMTP id 22so114418yxm.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=oub+1SS9TNCz8LtNSj4UUV8L2TUZdHc4i0yBbki5A/w=;
        b=MnnKCaRGEKgQ2uRxlsaV2dhPiW2ZMcuLefQRsZaX9gcJbTUud0iR1eccNd4n47EYzc
         Kfp9q8KQGFmEX9FsStrEVQsH8kP9Rtfiv9Vv+Ix68EOlBBAT799HGGJU7gDbJ8Y2WSy/
         UJkLcEBfbaPAZfcJaiH9CcrkdiO0v59TSu6WI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=bZetREHZRH2JeobJkfeRw/d3gCxLQa40WRM2YpW/O0mOKOxQp08ifnNmuqAJVtHKnu
         b+YKXy2a8SOwNOn/I/r+jOl9z4tTccPBV+NU1v+gSutUrMn+4FpTqkFJNfAIRMksrGnI
         fPq4rAPA3Bov2Ellvp/vDt3vV3LTH0/tr+qlQ=
Received: by 10.114.58.6 with SMTP id g6mr576887waa.27.1215018476403;
        Wed, 02 Jul 2008 10:07:56 -0700 (PDT)
Received: by 10.107.3.34 with SMTP id f34gr2572pri.0;
	Wed, 02 Jul 2008 10:07:56 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.141.34.12 with SMTP id m12mr314579rvj.0.1215018476073; Wed, 02 Jul 2008 10:07:56 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 39si8451042yxd.0.2008.07.02.10.07.55; Wed, 02 Jul 2008 10:07:56 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m62H7kgH017957; Wed, 2 Jul 2008 19:07:51 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db94382.pool.einsundeins.de [77.185.67.130]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m62H7i0A004979 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Wed, 2 Jul 2008 19:07:45 +0200 (MEST)
In-Reply-To: <alpine.DEB.1.00.0807021716030.9925@racer>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87161>



On Jul 2, 2008, at 6:17 PM, Johannes Schindelin wrote:

> On Wed, 2 Jul 2008, Steffen Prohaska wrote:
>
>>
>> From: Johannes Sixt <johannes.sixt@telecom.at>
>>
>> Hannes,
>> You introduced "minoffset" in 861429a7c37c7.
>
> AFAICT it was redone differently in 'next', because 'next' has this
> ceiling dir thingie, which allows a different (much smaller) patch.
>
> It might be more sensible to base your patch series on 'next'...

Hmm.. it is based on next.  But obviously I needed to merge
mingw's master to 4msysgit's master and resolve conflicts.
Maybe I made the wrong decisions then.

Hannes,
If you believe that your setup.c is good, then I'll copy your version
to 4msysgit's master.

	Steffen
