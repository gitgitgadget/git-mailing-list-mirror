From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 10/12] MINGW: compat/poll/poll.c: undef NOGDI
Date: Mon, 5 May 2014 00:55:52 +0400
Message-ID: <20140504205552.GA15590@seldon>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
 <1398762726-22825-11-git-send-email-marat@slonopotamus.org>
 <20140430114125.GA23046@camelia.ucw.cz>
 <20140503070050.GA8580@seldon>
 <20140504185244.GA17183@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCE7TAPITACRBXWSTKNQKGQESE46GJQ@googlegroups.com Sun May 04 22:56:01 2014
Return-path: <msysgit+bncBCE7TAPITACRBXWSTKNQKGQESE46GJQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f184.google.com ([209.85.216.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBXWSTKNQKGQESE46GJQ@googlegroups.com>)
	id 1Wh3S4-0003Pc-8E
	for gcvm-msysgit@m.gmane.org; Sun, 04 May 2014 22:56:00 +0200
Received: by mail-qc0-f184.google.com with SMTP id w7sf553808qcr.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 04 May 2014 13:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=AmMv4syur97PMFQUu7F7qB6FapF7RoV2DxzG0o4S7PY=;
        b=fp4D2//bPNva952pCGDPOw869Zs9Q1+EkG798dm416EGoF3SfxznICkDxUl0a0BeBH
         UXXvD6rPKxcy1YWdhruiQ482xu1Qqg31qJogrJavF07fp0zwMIas8nJ2i6CU/HLs1mLS
         gTbxgqEm6yP4pzZRKrvr2Y/fgZw0VIYzgpRlnVMPnQ0HTCzEABlO/QdbtwhC1jB6s3d3
         wzjOTWLS82qCSeTWF2RPJ5jya3LtAM7gNVOCbgep4QoJxC7JtEUN6m3w+0yTVyJ/kX6R
         MCQk7i0WwOOslXp6vT62Wg9tI3NZkd4ogCV0HNhpsiuh4vtqBhqFAekpnlTah/nDoL7H
         A6Hg==
X-Received: by 10.51.18.101 with SMTP id gl5mr340708igd.2.1399236959358;
        Sun, 04 May 2014 13:55:59 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.4.98 with SMTP id j2ls147478igj.39.gmail; Sun, 04 May 2014
 13:55:58 -0700 (PDT)
X-Received: by 10.43.141.196 with SMTP id jf4mr14383010icc.9.1399236958566;
        Sun, 04 May 2014 13:55:58 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id t4si418042igh.2.2014.05.04.13.55.57
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 May 2014 13:55:58 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wh3Rw-000447-Pv; Mon, 05 May 2014 00:55:53 +0400
In-Reply-To: <20140504185244.GA17183@camelia.ucw.cz>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248112>

On Sun, May 04, 2014 at 08:52:44PM +0200, Stepan Kasal wrote:
> Thank you very much for this analysis.
> It enables us to redirect you the third time: to report this as a
> bug in MinGW-W64 !  ;-)

I'll report this to MinGW-W64 soon, though even if/when they fix
the issue on their side, I'd still like to have a workaround in
Git to be able to use older MinGW-W64 versions that didn't
receive a fix.

> Seriously, it looks you found the best description of the problem,
> and it would be nice if you could modify your patch so that it
> is really a work around: it would be in effect only for MinGW-W64,
> and the comment would explain that this is a hack to work around the
> bug.  

Workarounds do not have to be ugly and full of #ifdef's.

> If you manage to change the defs for poll.c without changing its
> content, no one could tell you to report to gnulib first.

v1 does exactly this.

> OTOH, if MsgWaitForMultipleObjects is present ustream (in gnulib's
> poll.c, sorry that I cannot check right now), it still might be
> better to submit the work-around there first.

Workaround is "just don't pass -DNOGDI on MinGW-W64 if you want
MsgWaitForMultipleObjects", there's nothing to send to gnulib.
After all, was there a strong reason why Git started passing it?
What is there was no option to disable part of windows.h?

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
