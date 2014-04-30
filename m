From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Makefile: do not depend on curl-config
Date: Wed, 30 Apr 2014 18:52:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404301851210.14982@s15462909.onlinehome-server.info>
References: <1398702545-9860-1-git-send-email-kusmabite@gmail.com> <xmqqfvkuhm77.fsf@gitster.dls.corp.google.com> <CABPQNSZUCPd=1Eu8VUCP01tkdYkBC=xspFZuDuywuYZUH8ewvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Dave Borowitz <dborowitz@google.com>, 
    GIT Mailing-list <git@vger.kernel.org>, Pat Thoyts <patthoyts@gmail.com>, 
    Marat Radchenko <marat@slonopotamus.org>, tuomas.silvola@knowit.fi, 
    msysGit <msysgit@googlegroups.com>, sschuberth@gmail.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBWOUQSNQKGQEXL5BDSA@googlegroups.com Wed Apr 30 18:52:44 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBWOUQSNQKGQEXL5BDSA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f63.google.com ([74.125.83.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBWOUQSNQKGQEXL5BDSA@googlegroups.com>)
	id 1WfXkQ-0000fL-V0
	for gcvm-msysgit@m.gmane.org; Wed, 30 Apr 2014 18:52:42 +0200
Received: by mail-ee0-f63.google.com with SMTP id d17sf199646eek.8
        for <gcvm-msysgit@m.gmane.org>; Wed, 30 Apr 2014 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=yOPf1niB1xiWoj5J8jUTbPcfC+kLNRX8nib76Cs4Ric=;
        b=bUgZ/k7UdugvUCcU+mnRrezAcj7695lP4xdqQmBFjwi1qX5mjqsX0DypV5h3hbiCKL
         FKdRVH4jGtqZNVVqCz8uNvAI1V4aPULbUt0NmV8zNaFppDcoGYOFyI4/DgY3BYjurmGz
         NSBzdIyk/bMtdvE+slHSyX4vXNd/o1jgVLgIGh//xpfT7z+kXtFZayzheCl/0TOMH0d1
         uq0+Q45k9QujDVeZ0uab//pN+ZPxB/VMX3/3Ab6EQmkSQgnhtppietu5QL2kC1mYvjv0
         Hq8+uZWroM7la7aNeRiQx1GG+KwFi7tFdf3ifQ3zRCoDCP2YS81YYYqbFBIzUJrrJY/1
         ubkQ==
X-Received: by 10.180.81.69 with SMTP id y5mr26850wix.19.1398876762647;
        Wed, 30 Apr 2014 09:52:42 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.83.65 with SMTP id o1ls266888wiy.5.gmail; Wed, 30 Apr 2014
 09:52:41 -0700 (PDT)
X-Received: by 10.180.76.143 with SMTP id k15mr603999wiw.6.1398876761351;
        Wed, 30 Apr 2014 09:52:41 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id u49si631105eeo.1.2014.04.30.09.52.41
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 09:52:41 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MEo4s-1WdrjB0MBu-00G2gA;
 Wed, 30 Apr 2014 18:52:39 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABPQNSZUCPd=1Eu8VUCP01tkdYkBC=xspFZuDuywuYZUH8ewvw@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:jWN99Fux9elzA9Uw0a7rQ5/YCzDp4EwYfnBPKKQeNysimn+py8x
 lgqls2VTh7O8Dtauxj1zoB5VutH7oDCtO1McCrrsGQBEh3y3tzbU18aZuQCpbE3czcrtJvk
 CIF1Yfr1a2n1/h7O+WS5/RB92dT0ToQmZgJAV+vhKcwBnPHh2wJ/ol0R1lj+XpM1FWPKJ35
 OG8v4nHK7syBplFYBYewA==
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
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247743>

Hi kusma,

On Wed, 30 Apr 2014, Erik Faye-Lund wrote:

> We can keep this patch in the msysGit repo for the 2.0 release.

FWIW the plan is to switch to mingwGitDevEnv for the 2.0 release. It is
not quite clear as of yet how patches will be managed with said
environment.

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
