From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 12/12] [TODO] setup: bring changes from
 4msysgit/next to next
Date: Thu, 3 Jul 2008 08:06:30 +0200
Message-ID: <B01C53C6-6FB6-44EF-987F-1574A77C2F95@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <alpine.DEB.1.00.0807021716030.9925@racer> <D35A2542-3943-4BDB-AEDA-0F8B7052EF7D@zib.de> <200807022132.27751.johannes.sixt@telecom.at>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Jul 03 08:07:28 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.172])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEHya-0004y7-Cm
	for gcvm-msysgit@m.gmane.org; Thu, 03 Jul 2008 08:07:28 +0200
Received: by py-out-1314.google.com with SMTP id u10so1266600pyb.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 23:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=SLwBsZdOsHyC4kup9i5/d4NY/mApbpcviX8OPkdFYxs=;
        b=x12padaAAk9SnOLTdrrQYoQlSjHxq7D7K4qPTo/6k10T3KKZDyrPeZbW1aGY+oUVEZ
         CRCRUz4Ip4+8qmlH0nQ4HeVPhiCR5GpfseBP6z7xFozfHJNY8Zz2rifqjcY1z8O/Ni9y
         bayO04nA/bIpkLggF6UXGzIOZ1t0ri1aCoExM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=Gfv6uKUaI48QGyVLDGqwMWfxLg+/GRzX6DHCm7L+VmAoILuMHabqhvykDaL/uHn2Nn
         oKP9kWeaI2gynH8NLdCzTEB52Lw/LTTiFWorcG/hteDrWQ5+uMP1+JpjIh4z2+B+Lfme
         uEEdWObzqJ4K5SXGrhfofUK5NDK4FITEKm4Bk=
Received: by 10.141.175.5 with SMTP id c5mr555799rvp.22.1215065188337;
        Wed, 02 Jul 2008 23:06:28 -0700 (PDT)
Received: by 10.107.13.30 with SMTP id q30gr2588pri.0;
	Wed, 02 Jul 2008 23:06:28 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.83.18 with SMTP id g18mr10225424agb.17.1215065187767; Wed, 02 Jul 2008 23:06:27 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 7si9240664yxg.1.2008.07.02.23.06.26; Wed, 02 Jul 2008 23:06:27 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6366BtI025034; Thu, 3 Jul 2008 08:06:16 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db80397.pool.einsundeins.de [77.184.3.151]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m63666lF015012 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Thu, 3 Jul 2008 08:06:06 +0200 (MEST)
In-Reply-To: <200807022132.27751.johannes.sixt@telecom.at>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87220>



On Jul 2, 2008, at 9:32 PM, Johannes Sixt wrote:

> On Mittwoch, 2. Juli 2008, Steffen Prohaska wrote:
>> On Jul 2, 2008, at 6:17 PM, Johannes Schindelin wrote:
>>> On Wed, 2 Jul 2008, Steffen Prohaska wrote:
>>>> From: Johannes Sixt <johannes.sixt@telecom.at>
>>>>
>>>> Hannes,
>>>> You introduced "minoffset" in 861429a7c37c7.
>>>
>>> AFAICT it was redone differently in 'next', because 'next' has this
>>> ceiling dir thingie, which allows a different (much smaller) patch.
>>>
>>> It might be more sensible to base your patch series on 'next'...
>>
>> Hmm.. it is based on next.  But obviously I needed to merge
>> mingw's master to 4msysgit's master and resolve conflicts.
>> Maybe I made the wrong decisions then.
>>
>> Hannes,
>> If you believe that your setup.c is good, then I'll copy your version
>> to 4msysgit's master.
>
> The setup.c in mingw.git (and soon Junio's master) and Junio's next  
> are
> _different_, but both are correct. If you reverse-apply the patch you
> presented here, then you get the version from Junio's next, which is  
> a good
> state.

Ok, I'll wait until Junio's master has the changes and will remove
the changes to 4msysgit then.

	Steffen
