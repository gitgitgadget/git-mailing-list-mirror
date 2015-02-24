From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: [RFH] GSoC 2015 application
Date: Tue, 24 Feb 2015 13:25:32 +0100
Organization: gmx
Message-ID: <ed760450b06fd41c8bcaea7aaf526b94@www.dscho.org>
References: <20150218191417.GA7767@peff.net>
 <20150218193234.GA8298@peff.net>
 <5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org>
 <20150224120607.GA1906@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCZPH74Q5YNRBP63WGTQKGQEBGHIXLI@googlegroups.com Tue Feb 24 13:25:37 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBP63WGTQKGQEBGHIXLI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f63.google.com ([209.85.215.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBP63WGTQKGQEBGHIXLI@googlegroups.com>)
	id 1YQEYS-0002Ui-36
	for gcvm-msysgit@m.gmane.org; Tue, 24 Feb 2015 13:25:36 +0100
Received: by labgd6 with SMTP id gd6sf5421791lab.2
        for <gcvm-msysgit@m.gmane.org>; Tue, 24 Feb 2015 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=TFxMGmR4o4QWHttyxo2a/aJRbbIZlyrYVRqArlL86mI=;
        b=JwLLpO+9/Zbq7bcxdm6/Yzdblomg1c5nhf92LY9AChBPQYso6qUvHVhhZV3HRoNQTv
         KBsgyr6tF3rPpGRo1lyKqroqjkNfnmrzLOlhMr0hIjbTKVFp3HG7D+QWUXjder3+aTL/
         9dUo+RhceCpu9NR/4MJzn8qkAP3UB7sVk+T7mZVN1IFdvpzFD2TdTJ1K6A5NESm/PSdT
         UdIWuknWD3EyCRrb1oxwFKaRiVYdjLbGPRav3l2ItbcehGFwPVrz1pmgWpee1oO4LJDF
         MkI8IeVkifWzo54b2Z82hiRFpcunNYVTF0cFGaVZjHETjdehtO1fOZHs7N0ZQMaCg+6R
         vsog==
X-Received: by 10.152.36.193 with SMTP id s1mr130050laj.17.1424780735844;
        Tue, 24 Feb 2015 04:25:35 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.28.42 with SMTP id y10ls661421lag.71.gmail; Tue, 24 Feb
 2015 04:25:34 -0800 (PST)
X-Received: by 10.112.138.202 with SMTP id qs10mr2053739lbb.24.1424780734666;
        Tue, 24 Feb 2015 04:25:34 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id ta1si903468wic.1.2015.02.24.04.25.34
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2015 04:25:34 -0800 (PST)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LeMWL-1XjiW9437V-00q8jS; Tue, 24 Feb 2015 13:25:32
 +0100
In-Reply-To: <20150224120607.GA1906@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:2z/wvl+xUnlm6TEFf5MHmXhNeb9Ss91zm2uqIwwtj81NmGiA/0r
 DF2Rn1V3VA2aOvkcEXzZZ4GpJZc5x556nlJ/j9VcRjStjHCIWeryTfaJl9tOTXyQeqP0bIv
 i1qQu9l8tp71zDlpzCEugiWGk1L4YHxymevbvIphwwFRtyBlrtPvXbKGr2XC5dlibOHc1pZ
 3IwtLuvy/pwtb/ktMxxyg==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264323>

Hi Peff,

On 2015-02-24 13:06, Jeff King wrote:
> On Tue, Feb 24, 2015 at 01:01:17PM +0100, Johannes Schindelin wrote:
> 
>> After considerable consideration, I am offering to mentor
>> Windows-related projects (into which I count conversion of scripts
>> into builtins).
> 
> Thanks! No rush, as we are not even accepted yet, but you can create a
> profile at:
> 
>   http://google-melange.com
> 
> and ask to join the "git" project as a mentor.

I guess I can only ask that after the org is accepted, I will do so when (and if) that is the case.

> You may also want to add Windows-specific ideas to the page at:
> 
>   https://github.com/git/git.github.io/blob/master/SoC-2015-Ideas.md
> 
> Even something high-level like "helping move programs to builtins to
> help Windows" will let students know that it's a potential direction.

Done: https://github.com/git/git.github.io/pull/12

Thank you,
Dscho

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
