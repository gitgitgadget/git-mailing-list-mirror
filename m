From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH 0/3] fix test suite with mingw-unicode patches
Date: Tue, 15 Jul 2014 15:53:45 +0200
Message-ID: <20140715135345.GA21697@ucw.cz>
References: <20140712075035.GA12400@ucw.cz>
 <1405431797-20899-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>, Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBCU63DXMWULRB2PESSPAKGQENJAP5NQ@googlegroups.com Tue Jul 15 15:53:50 2014
Return-path: <msysgit+bncBCU63DXMWULRB2PESSPAKGQENJAP5NQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f57.google.com ([209.85.215.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB2PESSPAKGQENJAP5NQ@googlegroups.com>)
	id 1X73Aw-0002lH-K0
	for gcvm-msysgit@m.gmane.org; Tue, 15 Jul 2014 15:53:46 +0200
Received: by mail-la0-f57.google.com with SMTP id e16sf384063lan.12
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Jul 2014 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=dyFWU3RRRziG9NxoH6C/UXOS949BaxdFqtuvsf/BolQ=;
        b=PRGwASS2QpzHdw1ipRsOaH6PTyAsRSCPz1ZyUgXGHDgpxPaJaCxnXD74DwqX14euRq
         DE9zxCCN+Pm1eLkHhfezZitMy6vU4AQ/WPNoBWJgOfGJNRpQHPN9dBp4YTDSX4ZyWa8a
         YzQ5Hpzn31epN0wlYQ6RXuebBcie+PonN2Dsek1+ewhg688HEm306P3z8XSoChMdM8PR
         o6MwyFBC3aRRKjwlv6Z45zzCKgtol2Q+0O1mQJHFKZ9EXaEkhWY+UkcQF6q910Bk+v2v
         buI1BCGY0rBykmJuCRpWcrEzBX1qlkV9D3+p7GcoEUtTKai0VOXO9/crQgqj+2RTXnay
         SSvw==
X-Received: by 10.152.2.195 with SMTP id 3mr3340law.34.1405432426354;
        Tue, 15 Jul 2014 06:53:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.45.35 with SMTP id j3ls41123lam.86.gmail; Tue, 15 Jul 2014
 06:53:45 -0700 (PDT)
X-Received: by 10.112.54.169 with SMTP id k9mr2102771lbp.1.1405432425371;
        Tue, 15 Jul 2014 06:53:45 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id b9si648081wic.2.2014.07.15.06.53.45
        for <msysgit@googlegroups.com>;
        Tue, 15 Jul 2014 06:53:45 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 2561E1C0157; Tue, 15 Jul 2014 15:53:45 +0200 (CEST)
In-Reply-To: <1405431797-20899-1-git-send-email-kasal@ucw.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253561>

Hello,

I'm sorry that I have to reply to my own mail, but I forgot this:

> Karsten Blees (2):
>   Win32: Unicode file name support (except dirent)
.. has this one squashed in:
   Win32: fix detection of empty directories in is_dir_empty
https://github.com/msysgit/git/commit/91db148

>   Win32: Unicode file name support (dirent)

Both of theese patches are in msysgit for more than 2 years.

> Pat Thoyts and Stepan Kasal(1):
>   tests: do not pass iso8859-1 encoded parameter

This one is relatively new: replaces "git commit -m"
by "git commit -F -" to work around a Windows bug^H^H^Hfeature.

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
