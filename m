From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: Re: [PATCH 0/5] First part of Unicode console support
 for msysgit
Date: Fri, 6 Jun 2014 20:39:35 +0200
Organization: <)><
Message-ID: <20140606183935.GA4197@camelia.ucw.cz>
References: <1402062173-9602-1-git-send-email-kasal@ucw.cz> <5391FE01.9040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRB2MVZCOAKGQES33OA6I@googlegroups.com Fri Jun 06 20:39:40 2014
Return-path: <msysgit+bncBCU63DXMWULRB2MVZCOAKGQES33OA6I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f63.google.com ([209.85.215.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB2MVZCOAKGQES33OA6I@googlegroups.com>)
	id 1Wsz3B-000431-St
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 20:39:37 +0200
Received: by mail-la0-f63.google.com with SMTP id b8sf387762lan.28
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=zqqMIgZgGkBG15z2NqDrHbuiMRYEljtNzpjci2/TOGQ=;
        b=vv58XlDpWzphfu3HqrImXNt837f5ilagvXlrAA8GK9e4t7YM21AZAZGApt8zNbCBSH
         5DykIGiMWtnvuaMEeQ3qpetMf5uuoLns9BDTpIh8BflmqJHJ+SkWTtyPjlhSKTuI+KfF
         RlECOVNxKMuradRRqvhNMMEOJR2nvSg9MKQIPFLF6WScJI3ZhDFL421Nj60HFku9uXSd
         V5PAXgBhheYg94otDVjicEVGnmsbEZAueUEo7QaoIBSrNSRh58WNA7h/YBGMZQbfNCUi
         RnMI10rnqDiBjxcZx3z6Pegw7TiE0heztMrrm23rB9GvLycPbLKkIsEhxVh/2i7MuZtH
         bsCg==
X-Received: by 10.180.75.13 with SMTP id y13mr32825wiv.3.1402079977668;
        Fri, 06 Jun 2014 11:39:37 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.13.50 with SMTP id ev18ls149882wid.48.gmail; Fri, 06 Jun
 2014 11:39:36 -0700 (PDT)
X-Received: by 10.14.198.200 with SMTP id v48mr2183425een.5.1402079976704;
        Fri, 06 Jun 2014 11:39:36 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id x7si1397161wiw.1.2014.06.06.11.39.36
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 11:39:36 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 64FA11C00A0;
	Fri,  6 Jun 2014 20:39:36 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s56IdaOv004208;
	Fri, 6 Jun 2014 20:39:36 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s56IdZAS004207;
	Fri, 6 Jun 2014 20:39:35 +0200
In-Reply-To: <5391FE01.9040501@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250956>

Hello Karsten,

On Fri, Jun 06, 2014 at 07:44:33PM +0200, Karsten Blees wrote:
> Nicely done, thanks!

thank you for your kind words.

Please hold back, I will re-submit in a few days.

> Note: this one was submitted seperately on May 29 and May 1 (can't
> find it in the gmane archive, though).

It was cc'ed to msysgit as usual and gmane selected it as the primary
place to store it:
http://thread.gmane.org/gmane.comp.version-control.msysgit/20324

regards,
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
