From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH/RFC] Makefile: do not depend on curl-config
Date: Wed, 30 Apr 2014 21:46:38 +0200
Message-ID: <CAHGBnuPrQzSAVRZCneHdodAAQjA4dkGk0AguNm3xhW+cQ4XESQ@mail.gmail.com>
References: <1398702545-9860-1-git-send-email-kusmabite@gmail.com>
	<xmqqfvkuhm77.fsf@gitster.dls.corp.google.com>
	<CABPQNSZUCPd=1Eu8VUCP01tkdYkBC=xspFZuDuywuYZUH8ewvw@mail.gmail.com>
	<alpine.DEB.1.00.1404301851210.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Dave Borowitz <dborowitz@google.com>, GIT Mailing-list <git@vger.kernel.org>, 
	Pat Thoyts <patthoyts@gmail.com>, Marat Radchenko <marat@slonopotamus.org>, tuomas.silvola@knowit.fi, 
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDZMLEGXWQLBBHVGQWNQKGQEJY2A2QY@googlegroups.com Wed Apr 30 21:46:41 2014
Return-path: <msysgit+bncBDZMLEGXWQLBBHVGQWNQKGQEJY2A2QY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f61.google.com ([209.85.213.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBBHVGQWNQKGQEJY2A2QY@googlegroups.com>)
	id 1WfaSm-0008Vi-IA
	for gcvm-msysgit@m.gmane.org; Wed, 30 Apr 2014 21:46:40 +0200
Received: by mail-yh0-f61.google.com with SMTP id b6sf486754yha.16
        for <gcvm-msysgit@m.gmane.org>; Wed, 30 Apr 2014 12:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=fSVo5OegKAbVQvWtiCJ9rZWZ/frF7KtZ2+Hc4Vc9eoc=;
        b=oFE197Qa5R8UE9BLZ2s4e6hX8qZaBOxf28zFRzX0FVYeSEn+alzkQsPCXEFMi1cQTY
         /pG4lpbQhDP5LAVY8zp8XPLe0kyeHumPT4nWFlH29akzV0q+PXO3GfT4ylDT433ffOZa
         /qP/0Z52Q0btoxU7rMWAS23G1rzV0AFEUpuZTsg4GZ1eFAygntxV6MLQcLOvLGHjwWTt
         H/UYLIvicJODD741siUTmn3Mv31Qq5uFthaY15Na31OuiF4e81BflfseT/MuYfmKrc9W
         OrMpHTfewedHpg+ngBagDPuayxjJ8LIAeWms8swLoxMEmOXmPcN2g5A5+maIOMQWlepe
         7Buw==
X-Received: by 10.50.59.179 with SMTP id a19mr160555igr.10.1398887199747;
        Wed, 30 Apr 2014 12:46:39 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.36.99 with SMTP id p3ls2957318igj.19.canary; Wed, 30 Apr
 2014 12:46:38 -0700 (PDT)
X-Received: by 10.43.158.9 with SMTP id ls9mr3220221icc.18.1398887198803;
        Wed, 30 Apr 2014 12:46:38 -0700 (PDT)
Received: from mail-yh0-x22d.google.com (mail-yh0-x22d.google.com [2607:f8b0:4002:c01::22d])
        by gmr-mx.google.com with ESMTPS id y50si3128459yhk.4.2014.04.30.12.46.38
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 12:46:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2607:f8b0:4002:c01::22d as permitted sender) client-ip=2607:f8b0:4002:c01::22d;
Received: by mail-yh0-f45.google.com with SMTP id z6so2155317yhz.32
        for <msysgit@googlegroups.com>; Wed, 30 Apr 2014 12:46:38 -0700 (PDT)
X-Received: by 10.236.99.99 with SMTP id w63mr9063454yhf.52.1398887198689;
 Wed, 30 Apr 2014 12:46:38 -0700 (PDT)
Received: by 10.170.151.10 with HTTP; Wed, 30 Apr 2014 12:46:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1404301851210.14982@s15462909.onlinehome-server.info>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2607:f8b0:4002:c01::22d
 as permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247764>

On Wed, Apr 30, 2014 at 6:52 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>> We can keep this patch in the msysGit repo for the 2.0 release.
>
> FWIW the plan is to switch to mingwGitDevEnv for the 2.0 release. It is
> not quite clear as of yet how patches will be managed with said
> environment.

The environment is just that: The environment to build Git for
Windows. This means that patches on top of Git for Windows could still
be maintained in msysgit/git (or a fork thereof) on GitHub.

-- 
Sebastian Schuberth

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
