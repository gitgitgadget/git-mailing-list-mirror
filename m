From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH 0/7] Second part of msysgit/unicode
Date: Wed, 18 Jun 2014 05:05:07 +0200
Organization: <)><
Message-ID: <20140618030507.GA3809@camelia.ucw.cz>
References: <1402479466-8500-1-git-send-email-kasal@ucw.cz> <53A0052C.6040604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBZ4DQSOQKGQEJOWZVYI@googlegroups.com Wed Jun 18 05:05:15 2014
Return-path: <msysgit+bncBCU63DXMWULRBZ4DQSOQKGQEJOWZVYI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f59.google.com ([74.125.82.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZ4DQSOQKGQEJOWZVYI@googlegroups.com>)
	id 1Wx6BW-0001Bx-2V
	for gcvm-msysgit@m.gmane.org; Wed, 18 Jun 2014 05:05:14 +0200
Received: by mail-wg0-f59.google.com with SMTP id k14sf8696wgh.4
        for <gcvm-msysgit@m.gmane.org>; Tue, 17 Jun 2014 20:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=jD9/TaFj9ZjxJDCD3PKgQEXGxf4f6M/JHfyaS8vL3vM=;
        b=KOoKyFwj6u/fYkMx3V/JzWHvLjT3J3SCQO3xzxtkLs5CewZvl6QXe/vMzwJcG1r1Xq
         AMq92eMJibUkt7l8o2thlav6F669oAMD2ZomDz9K9a9k2vr8LKr3L/mxBpK6feA1EOc5
         SdZyEZez5J4s3OhFb9I3yrwIA1baQkIbd3jIFAiO/qd5bt1kZ2SdmbE9xSv3hIzcIlgN
         SwddPCH7qYdU8RYVEyNMf2gK05ZDCTRPyk+VaS2Cv+7b6b7RdOE7tFVhy1Rmeu1Ue8Up
         0VNHElBo3WdZMwV1x+JylCfhP47l3vOgd/GsqkCEXA3BvWjQ1ySw5ww5NvYvPQ7t80kh
         YtTA==
X-Received: by 10.152.23.165 with SMTP id n5mr258658laf.5.1403060713721;
        Tue, 17 Jun 2014 20:05:13 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.170.133 with SMTP id am5ls766596lac.36.gmail; Tue, 17 Jun
 2014 20:05:11 -0700 (PDT)
X-Received: by 10.152.37.100 with SMTP id x4mr673121laj.6.1403060711301;
        Tue, 17 Jun 2014 20:05:11 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id s1si58735wiw.3.2014.06.17.20.05.09
        for <msysgit@googlegroups.com>;
        Tue, 17 Jun 2014 20:05:09 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id E3B2D1C00AB;
	Wed, 18 Jun 2014 05:05:08 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s5I358rS003871;
	Wed, 18 Jun 2014 05:05:08 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s5I3588a003870;
	Wed, 18 Jun 2014 05:05:08 +0200
In-Reply-To: <53A0052C.6040604@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251964>

Hello Karsten,

On Tue, Jun 17, 2014 at 11:06:52AM +0200, Karsten Blees wrote:
> Am 11.06.2014 11:37, schrieb Stepan Kasal:
> > This is the second part of the time-proven unicode suport branch from msysgit.
> > This batch is a collection of small independent changes, limited to mingw.c.
> > The only exception is the last patch: it changes gitk and git-gui.
> 
> I'm missing the other two "Unicode file name" patches (and "Win32: fix detection

indeed.  I noticed that after sending the plan quoted above.
Luckily, the gitk/git-gui patch was not accepted and has to be
resubmitted.

So the plan for future submissions is:

1) two "Unicode file name" patches (with "fix... is_dir_empty"
squashed)
2) the environament patches from your unicode branch (several
patches)
3) "color term" (and env. var. TERM); updated according to your
instructions, thus sent separately after the series
4) resubmit gitk / git-gui (have separate maintainers)

This is work in progress, I suppose to mail 1) and 2) in a few days.

Stepan

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
