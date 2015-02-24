From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: [RFH] GSoC 2015 application
Date: Tue, 24 Feb 2015 13:01:17 +0100
Organization: gmx
Message-ID: <5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org>
References: <20150218191417.GA7767@peff.net>
 <20150218193234.GA8298@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCZPH74Q5YNRBE6QWGTQKGQEGDKAQCI@googlegroups.com Tue Feb 24 13:01:29 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBE6QWGTQKGQEGDKAQCI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f184.google.com ([74.125.82.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBE6QWGTQKGQEGDKAQCI@googlegroups.com>)
	id 1YQEB2-0007xB-1F
	for gcvm-msysgit@m.gmane.org; Tue, 24 Feb 2015 13:01:24 +0100
Received: by wesw55 with SMTP id w55sf5446449wes.4
        for <gcvm-msysgit@m.gmane.org>; Tue, 24 Feb 2015 04:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=LG1OdjHKzf+c3d3ZYx4Ja5vw6qUdUy8dmiXHd9PCQOw=;
        b=ck+baNwJjuUOa2Yd9sbikzyLH2QA5hX93SARxcjlyVccyynGZbJrreGWXlH/BvD/U1
         NU0jk6aVx/XB5Ca/+nwILop+VrhCfRmkfMl7ADyB/2PDr0rBnJaH+n//Fd//Ns09aKWm
         PTFOcwc0vLbYXc6u/W6Te6otShkqVMTwpke+gt0ZtRTZnQkXMVTNVe0VD/lxP7U6P4Db
         lThk0ByVCyVTAiQnWg8k1fOTdbV8F0tBLpb6UnQRM72Nx1byV7BFWwpNQPzADENVNubs
         ke0k4XTvQ47kL9GJtK9rluH6AoRtpa2W7wBFXNdbUSsOg0xhi3V7NYHsGMWLx+mlPIyT
         yEhA==
X-Received: by 10.152.36.129 with SMTP id q1mr124582laj.2.1424779283707;
        Tue, 24 Feb 2015 04:01:23 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.4.131 with SMTP id k3ls655377lak.21.gmail; Tue, 24 Feb
 2015 04:01:22 -0800 (PST)
X-Received: by 10.112.219.102 with SMTP id pn6mr1435923lbc.12.1424779282555;
        Tue, 24 Feb 2015 04:01:22 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id i7si903788wif.0.2015.02.24.04.01.22
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2015 04:01:22 -0800 (PST)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M9OMc-1YEdrV0hlW-00CeSF; Tue, 24 Feb 2015 13:01:19
 +0100
In-Reply-To: <20150218193234.GA8298@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:+Qc2m8Ke4rnjcs6iBwYW/AMUqk4U1HRNrHtoO8FbRKrldGsm9xL
 UIr06/MiXNwIeTENztb5SJfLV68WMjCogzMwvqP8HUB5xXrwldZBX7Mt0rFljjZZ5WtT6fm
 6lP2MOpBommSfHR0GInZCrD9sLg5UrV8lzeqkbTsUp+DS+HZfr4HdYZWOGufahvz04H5m5d
 4DREztjX9BczAfVwGQymA==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264319>

Hi Peff,

On 2015-02-18 20:32, Jeff King wrote:

> On Wed, Feb 18, 2015 at 02:14:17PM -0500, Jeff King wrote:
> 
>> The response to my previous email was not overwhelming, but people did
>> express some interest in Git doing GSoC this year. So I've started on
>> the application, using last year's version as a template.

I feel unqualified to fill in the information, having kept out of the loop of the past years' GSoC efforts.

After considerable consideration, I am offering to mentor Windows-related projects (into which I count conversion of scripts into builtins).

Thanks,
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
