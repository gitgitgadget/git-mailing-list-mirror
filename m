From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: Re: [PATCH 0/5] First part of Unicode console support
 for msysgit
Date: Fri, 6 Jun 2014 22:48:30 +0200
Organization: <)><
Message-ID: <20140606204830.GA4671@camelia.ucw.cz>
References: <1402062173-9602-1-git-send-email-kasal@ucw.cz> <5391FE01.9040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBH6SZCOAKGQEKDJROBQ@googlegroups.com Fri Jun 06 22:48:34 2014
Return-path: <msysgit+bncBCU63DXMWULRBH6SZCOAKGQEKDJROBQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f187.google.com ([209.85.212.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBH6SZCOAKGQEKDJROBQ@googlegroups.com>)
	id 1Wt13w-0005Lp-DP
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 22:48:32 +0200
Received: by mail-wi0-f187.google.com with SMTP id f8sf198151wiw.14
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 13:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=OXdWbjF9eQdF3NjnZzP5226JAq9KYhuQQZdl4fN3G0o=;
        b=U/UzRktTkZDYEbxoxdbbZTWvt4a+XZ463uMC+UhEykEN0C5HIZMYeFDd5pt70YgvEa
         jOgoi3D6w/LTA0Ti7jk8jNtLa0MDOYnfPyhaTkCzq+yDMhtbc50wf5OIPfGrLiImfCbB
         OfZMFp2w/Cni77WEILp0pLEqG3oBunN9XDiRS8JLS5+8bGqiWn1+ScBgjwZizD8QMbJ2
         SEF5dWHmywDrRlGFjtopE5vp5O9xZ/oF/Aq0fkSSVr96T3Qyv6NB0uGQJUBUJ4zPe0ZF
         cfPK7vh+OepianRAj6DMyO0JAuABVbUSVdUbTY1hce2dSRsebhI0LP9zpAUs5Tloh+Ne
         ViRA==
X-Received: by 10.180.188.105 with SMTP id fz9mr37740wic.0.1402087712104;
        Fri, 06 Jun 2014 13:48:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.79.232 with SMTP id m8ls165116wix.38.canary; Fri, 06 Jun
 2014 13:48:31 -0700 (PDT)
X-Received: by 10.180.36.234 with SMTP id t10mr1897090wij.1.1402087711286;
        Fri, 06 Jun 2014 13:48:31 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id gz10si1772498wib.0.2014.06.06.13.48.31
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 13:48:31 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id EF5821C00A0;
	Fri,  6 Jun 2014 22:48:30 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s56KmU3f004732;
	Fri, 6 Jun 2014 22:48:30 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s56KmU5x004731;
	Fri, 6 Jun 2014 22:48:30 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250966>

Hello,

On Fri, Jun 06, 2014 at 07:44:33PM +0200, Karsten Blees wrote:
> > Karsten Blees (5):
> >   Support Unicode console output on Windows
> 
> [..] you could have squashed half of
> "Win32: fix segfault in WriteConsoleW when debugging in gdb" [2] (second  half in [5/5]).
> 
> >   Detect console streams more reliably on Windows
> >   Warn if the Windows console font doesn't support Unicode
> 
> I think this one includes
> "MSVC: fix winansi.c compile errors " [3] and
> "Unicode console: fix font warning on Vista and Win7" [4]
[...]
> >   Win32: move main macro to a function
> >   Win32: Thread-safe windows console output

> [2] https://github.com/msysgit/git/commit/cd0792af
> [3] https://github.com/msysgit/git/commit/3abcb04d
> [4] https://github.com/msysgit/git/commit/981aa538

Indeed, you identified them correctly.  And [2] is actually squashed
in [5/5]; I think I can keep it that way.

I'll add the missing fix, take care about original dates, improve the
cover letter (the above links), and resubmit.

Thanks for review this batch of your patches.

Regards,
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
