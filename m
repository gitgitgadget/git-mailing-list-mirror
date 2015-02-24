From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: [RFH] GSoC 2015 application
Date: Tue, 24 Feb 2015 21:33:13 +0100
Organization: gmx
Message-ID: <c9ff859363d2d637b3607aaf6cb9295d@www.dscho.org>
References: <20150218191417.GA7767@peff.net>
 <20150218193234.GA8298@peff.net>
 <5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org>
 <vpqioerz03s.fsf@anie.imag.fr>
 <CAPc5daXTLRZW-uk++ZjbtafbR6SB41dyc0Cu1gN=Qy7CEhOq-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, Jeff King <peff@peff.net>,
 Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCZPH74Q5YNRBFWAWOTQKGQEVCQVYMY@googlegroups.com Tue Feb 24 21:33:28 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBFWAWOTQKGQEVCQVYMY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f183.google.com ([209.85.217.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBFWAWOTQKGQEVCQVYMY@googlegroups.com>)
	id 1YQMAZ-0007Fs-PJ
	for gcvm-msysgit@m.gmane.org; Tue, 24 Feb 2015 21:33:27 +0100
Received: by lbjf15 with SMTP id f15sf6354764lbj.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 24 Feb 2015 12:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=rIZASckCzh4Uhw6hB5EqpIvCI9pNAVso4aqYUtrRpxI=;
        b=Sc1wCXMA1aFOw1TPtsPRVToa8MSKhdsnF78Js3KlsHXmrtcsEbKbguh+5116w4SKFM
         wtUlxg6qbzJ0X0x0HTpEevDscMPvnSgSCj5Z4yo58QzyJU4D0jlfocAfqFR448WBB+uu
         2pb7FsxTGHUrSoteFzkgr9FgZQX49Fdivve8USPMjGG14e+2xOG+JRpD7pAFbvGWGxb1
         8KIbrBtWe3qWHxe02WqzLvJHUyvdoudErsxfFd377mgv7or00aguix8oaFigRBvM+TNy
         6xnxf1a6oQkTbfK/IbNfDyBQVqmMCUSaV0Mqai84BnrvnbCWaDQsW0t3ami73TcMogQF
         MHLw==
X-Received: by 10.180.198.148 with SMTP id jc20mr124120wic.17.1424810007481;
        Tue, 24 Feb 2015 12:33:27 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.106.101 with SMTP id gt5ls860801wib.28.gmail; Tue, 24 Feb
 2015 12:33:25 -0800 (PST)
X-Received: by 10.180.89.194 with SMTP id bq2mr8354wib.4.1424810005013;
        Tue, 24 Feb 2015 12:33:25 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id by11si1207772wib.1.2015.02.24.12.33.24
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2015 12:33:25 -0800 (PST)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0ML6XF-1YQdHX29j7-000J4T; Tue, 24 Feb 2015 21:33:14
 +0100
In-Reply-To: <CAPc5daXTLRZW-uk++ZjbtafbR6SB41dyc0Cu1gN=Qy7CEhOq-A@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:dOrbgHj5b1Ahv6lDcl6+q78i7awpGV6PasDD7QhvGEG1Xg8JqY7
 Nw5SObFh87fmH3V2+YU0iNd4MOCqOww4C9/J2g6LZtaphAYT+DtxBldeBhyIaoM4HiVF0uc
 PjQOCcv5QI1qiaO5O57MHrnA3mhGsuscanTDE6VdlSjnlTLSkfgBVQj8i8UIzhdKVjBlwDw
 MznJtdiQaaHjnAH1meBkg==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.21 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264344>

Hi Junio,

On 2015-02-24 19:25, Junio C Hamano wrote:
> On Tue, Feb 24, 2015 at 9:32 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> About the proposal:
>>
>>   The idea of this project is to dive into the Git source code and
>>   convert, say, git-add--interactive.perl and/or git stash into proper C
>>   code, making it a so-called "built-in".
>>
>> My advice would be to try converting several small scripts, and avoid
>> targetting a big one....
>> add--interactive and stash are relatively complex beasts, perhaps
>> git-pull.sh would be easier to start with.
> 
> Yeah, I think that is a very good suggestion.

Well, git-pull.sh is really small. I did not want to give the impression that the Git project is giving out freebies. But I have no objection to change it if you open that PR.

> Also drop "proper" as if scripted Porcelains are second class citizens ;-)

If you had to deal with the portability/performance issues of the shell scripts I am frequently faced with, you would not call them first class citizens, either.

Ciao,
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
