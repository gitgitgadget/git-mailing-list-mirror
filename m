From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH 10/12] MINGW: compat/poll/poll.c: undef NOGDI
Date: Sun, 4 May 2014 20:52:44 +0200
Organization: <)><
Message-ID: <20140504185244.GA17183@camelia.ucw.cz>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org> <1398762726-22825-11-git-send-email-marat@slonopotamus.org> <20140430114125.GA23046@camelia.ucw.cz> <20140503070050.GA8580@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCU63DXMWULRB7MYTKNQKGQEI35CH7A@googlegroups.com Sun May 04 20:52:49 2014
Return-path: <msysgit+bncBCU63DXMWULRB7MYTKNQKGQEI35CH7A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f183.google.com ([74.125.82.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB7MYTKNQKGQEI35CH7A@googlegroups.com>)
	id 1Wh1Wp-0003FV-4l
	for gcvm-msysgit@m.gmane.org; Sun, 04 May 2014 20:52:47 +0200
Received: by mail-we0-f183.google.com with SMTP id u57sf20218wes.10
        for <gcvm-msysgit@m.gmane.org>; Sun, 04 May 2014 11:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=ahcV7d7q5wunYej4aXRAuqSIgFCRLAiZRVefNhRQyyI=;
        b=O/+K3/oaD0FRBW7kzb55D9kDeN3+RGW/tGq4RmiSlv6h7vi8/9P/ij2JEf5YOSKUvx
         jVWYAC2feoAZOA/Vm/xfS5lekrDrlc7RA9iqmdqz3Tqi2MVPwNORdlYD8JAv77kBQvjq
         Xn603s4LBOnl0BnDF4SWr74Iz+KkyCFpD2g9I+J3fy6goyhydf8t1lk3De+KSgwIx892
         z5OhsxApbAwuHdvdIl62gccK/yldr+noB2rbWULkUmGJCvC38vwyaTqE9C73DH6TGlpU
         zWd9GWfOntThRwWS09yLnMq96B2YAew32xmXDXLC2MDWogNF87yiACZ4HP8Icc1jivFe
         Ai1Q==
X-Received: by 10.180.109.17 with SMTP id ho17mr66730wib.18.1399229566652;
        Sun, 04 May 2014 11:52:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.11.193 with SMTP id s1ls329586wib.16.canary; Sun, 04 May
 2014 11:52:45 -0700 (PDT)
X-Received: by 10.180.93.37 with SMTP id cr5mr1151465wib.1.1399229565327;
        Sun, 04 May 2014 11:52:45 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id u49si989639eeo.1.2014.05.04.11.52.45
        for <msysgit@googlegroups.com>;
        Sun, 04 May 2014 11:52:45 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 075A91C01FB;
	Sun,  4 May 2014 20:52:45 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s44Iqi7X017325;
	Sun, 4 May 2014 20:52:44 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s44IqipU017324;
	Sun, 4 May 2014 20:52:44 +0200
In-Reply-To: <20140503070050.GA8580@seldon>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248106>

Hello Marat,

On Sat, May 03, 2014 at 11:00:51AM +0400, Marat Radchenko wrote:
> On Wed, Apr 30, 2014 at 01:41:25PM +0200, Stepan Kasal wrote:
> > On Tue, Apr 29, 2014 at 01:12:04PM +0400, Marat Radchenko wrote:
> > > On MinGW-W64, MsgWaitForMultipleObjects is guarded with #ifndef NOGDI.
> > > 
> > > Removal -DNOGDI=1 from config.mak.uname has an undesirable effect of
[..]
> > 
> > compat/poll/poll.c comes from Gnulib, so it would be better to submit
[..]
> 
> That's why v1 of this patch [1] didn't touch poll.c at all.

ouch!  It looks like you everyone sending you elsewhere.  I apologize
for being part of that.  (I was not aware about the previous version.)

> I don't think it's gnulib problem that combination of two third-parties
> (git and mingw-w64) set up such conditions where poll.c fails to compile.

Well, yes and no: gnulib is mostly a collection of compatibility
reimplementaions of functions that should be available on an ideal
system.

> If one wants to dig deeper, I'd say the problem is in MinGW-W64 headers
> because their behavior of hiding MsgWaitForMultipleObjects doesn't
> match behavior of MSVC headers.

Thank you very much for this analysis.
It enables us to redirect you the third time: to report this as a
bug in MinGW-W64 !  ;-)

Seriously, it looks you found the best description of the problem,
and it would be nice if you could modify your patch so that it
is really a work around: it would be in effect only for MinGW-W64,
and the comment would explain that this is a hack to work around the
bug.  

If you manage to change the defs for poll.c without changing its
content, no one could tell you to report to gnulib first.

OTOH, if MsgWaitForMultipleObjects is present ustream (in gnulib's
poll.c, sorry that I cannot check right now), it still might be
better to submit the work-around there first.

Thanks for your work,
	Stepan Kasal

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
