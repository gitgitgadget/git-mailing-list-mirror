From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 0/2] wincred makefile changes
Date: Tue, 13 May 2014 07:59:53 +0200
Organization: <)><
Message-ID: <20140513055953.GA28182@camelia.ucw.cz>
References: <20140430064610.GA22094@camelia.ucw.cz> <CABPQNSZsviaGqFeKZE4ofF6HoUQrPvNPuowar4YDjk_Mbu5iCQ@mail.gmail.com> <20140430112724.GA22929@camelia.ucw.cz> <CABPQNSafKXDLyBj5OYW-PPWdxfxQtC23vKQsQ-_Pa1empU=n8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBW7JY2NQKGQEOYFCECA@googlegroups.com Tue May 13 07:59:56 2014
Return-path: <msysgit+bncBCU63DXMWULRBW7JY2NQKGQEOYFCECA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f190.google.com ([209.85.217.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBW7JY2NQKGQEOYFCECA@googlegroups.com>)
	id 1Wk5kq-0007Dj-Gm
	for gcvm-msysgit@m.gmane.org; Tue, 13 May 2014 07:59:56 +0200
Received: by mail-lb0-f190.google.com with SMTP id p9sf757019lbv.27
        for <gcvm-msysgit@m.gmane.org>; Mon, 12 May 2014 22:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=XBP7IxU3eSPcFAhO2EqsQyEJEyA5XKVDw4ODP+oVymM=;
        b=QIY2CJelU/3jt3gYuUNySQ5szPFWbccVUJcgt2kNjG+wpUMtazmfDl53Ca7lTnXeaE
         gOY2QDzc4BSVjwoKu+t+a8RHGJD8qUp6oHubrQIdEwkwrzkjt744lnH3DeIq1+goqYy/
         tzJyvPqPHdw8R2rthMSJJ+bkO4JHpOSo9H64qKTzheXLC0DrOjNCCpcg46CjpuHkodtN
         1vUKKybIezX8NvzhVV8tDTsEX0EK8Uir0+kNnKmBwLZVESGm+09qwVQfddEH8zvpLs3z
         Q2PZDbcIV+ZKyLhpfNcitUrwYCK2VHBVw4q5LrEgI0ZsnFtcDWnnJJVz8lUinTekVhuS
         AAvw==
X-Received: by 10.152.43.202 with SMTP id y10mr85lal.33.1399960796241;
        Mon, 12 May 2014 22:59:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.43.201 with SMTP id y9ls21627lal.64.gmail; Mon, 12 May
 2014 22:59:54 -0700 (PDT)
X-Received: by 10.112.184.227 with SMTP id ex3mr12886lbc.16.1399960794892;
        Mon, 12 May 2014 22:59:54 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r49si785383eep.0.2014.05.12.22.59.54
        for <msysgit@googlegroups.com>;
        Mon, 12 May 2014 22:59:54 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 9B44F1C0075;
	Tue, 13 May 2014 07:59:54 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4D5xsgR028211;
	Tue, 13 May 2014 07:59:54 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4D5xrVM028210;
	Tue, 13 May 2014 07:59:53 +0200
In-Reply-To: <CABPQNSafKXDLyBj5OYW-PPWdxfxQtC23vKQsQ-_Pa1empU=n8g@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248747>

Hello again,
  I revisited a patch that is present in msysgit since Oct 2012.
Dropping the cosmetic changes, there are two separate parts:

Pat Thoyts (2):
  wincred: add install target
  wincred: avoid overwriting configured variables

wincred: add install target
   Git for Windows does contain git-credential-wincred
wincred: avoid overwriting configured variables
   Generally, overriding these variables this deep is evil.
   (We could use ?= if really necessary.)

Erik, does this iteration look better?

Stepan

 contrib/credential/wincred/Makefile | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
1.9.2.msysgit.0.161.g83227c1

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
