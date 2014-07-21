From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH 4/6] t4210: skip command-line encoding tests
 on mingw
Date: Mon, 21 Jul 2014 19:45:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1407211944510.3456@s15462909.onlinehome-server.info>
References: <20140716092959.GA378@ucw.cz> <1405611425-10009-1-git-send-email-kasal@ucw.cz> <1405611425-10009-5-git-send-email-kasal@ucw.cz> <CABPQNSaiogqGryK8YOzQXs_z_syvXMBqvOpvGfMNdbLkNzRq_w@mail.gmail.com> <xmqqvbqqk5qu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: kusmabite@gmail.com, Stepan Kasal <kasal@ucw.cz>, 
    Karsten Blees <karsten.blees@gmail.com>, Johannes Sixt <j6t@kdbg.org>, 
    GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
    Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCZPH74Q5YNRBV5DWWPAKGQEV37LNBI@googlegroups.com Mon Jul 21 19:46:02 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBV5DWWPAKGQEV37LNBI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f57.google.com ([209.85.213.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBV5DWWPAKGQEV37LNBI@googlegroups.com>)
	id 1X9Hey-000650-V8
	for gcvm-msysgit@m.gmane.org; Mon, 21 Jul 2014 19:46:01 +0200
Received: by mail-yh0-f57.google.com with SMTP id 29sf2187491yhl.2
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Jul 2014 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=E/izxG5UkAh7158pucWV3UkdrUGEdXGlwWU9r8vG16c=;
        b=CnPwOt43jTr03noP/nw82J7gfz2H/mkjKoRY3RwmWnSwdsjvHTofO8mbwneRIGuEa+
         lAZlxXnqLTcl+mtYSCo6/ls7qtgnkxaVRVr9YAU/+z9KpKSKtLkckyKuldlExmB0eyGs
         J2VmYH/x7FenmqHXodTHT8ZMXMvuivX2U4UX5p01ltNdd29Jy1guSN619wAScMPZQ8lO
         sz43BcEbp7GBhIafVWfKO2sTFdXgcQKGhLMOVhzcQBs+nbds4+ZCS515BF7H7mdfmTma
         w4oPwrnYJlb25WcpHHGYG8Ty2hJOSJpGtQLHjEWipDVyvYnBw9kpIP0/he5GnHjaVKYi
         Z2ig==
X-Received: by 10.50.67.98 with SMTP id m2mr109857igt.15.1405964760145;
        Mon, 21 Jul 2014 10:46:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.78.162 with SMTP id c2ls1790166igx.17.canary; Mon, 21 Jul
 2014 10:45:59 -0700 (PDT)
X-Received: by 10.66.187.137 with SMTP id fs9mr5460294pac.10.1405964759487;
        Mon, 21 Jul 2014 10:45:59 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id y50si1073893yhk.4.2014.07.21.10.45.59
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jul 2014 10:45:59 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MSMr9-1WyXD03NH9-00TTjG;
 Mon, 21 Jul 2014 19:45:37 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqvbqqk5qu.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:6jV/UsaUtQg6j/B5nxhi/OuCz+IsLLlgiXZAe5YOj1OmpFJGTIO
 LD7J5LEmhYC6qWCtVE1cWGYUyXByWyZgTcmaBDZ59MKZX3EfL4PWMLBgADH6Vnu2uzy4eqe
 pL7b6kqqr2mO36ldWf4dQoiJImPC/3OT1+/QDAYY7cIkelTb8kuk9nTyTBxUUEtF7F1Be9b
 uPmW58nMMHwGhQ4af6y8Q==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253981>

Hi Junio,

On Mon, 21 Jul 2014, Junio C Hamano wrote:

> Oh by the way, can somebody remind me why we spell these as
> NOT_MINGW,  instead of !MINGW?

I guess that is my mistake; when I introduced the use of NOT_MINGW I was
simply unaware of the !MINGW syntax.

Let's use the latter consistently?

Ciao,
Johannes

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
