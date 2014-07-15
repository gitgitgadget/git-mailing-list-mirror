From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: Topic sk/mingw-unicode-spawn-args breaks tests
Date: Tue, 15 Jul 2014 02:21:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1407150217300.18949@s15462909.onlinehome-server.info>
References: <53BEF21E.9090007@kdbg.org> <53C03FBB.1080807@gmail.com> <20140712075035.GA12400@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>, Johannes Sixt <j6t@kdbg.org>, 
    Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCZPH74Q5YNRBG7ISGPAKGQETRG72GY@googlegroups.com Tue Jul 15 02:21:48 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBG7ISGPAKGQETRG72GY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f57.google.com ([74.125.82.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBG7ISGPAKGQETRG72GY@googlegroups.com>)
	id 1X6qVA-0004iY-IK
	for gcvm-msysgit@m.gmane.org; Tue, 15 Jul 2014 02:21:48 +0200
Received: by mail-wg0-f57.google.com with SMTP id n12sf522290wgh.2
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Jul 2014 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=AtRmfpAf0e3q1m3FAwOMOgFqSPLmnPRzr+OCDEv4lwY=;
        b=QPU+r/LGvtpDvV9K0NWICm/RQEaOTQaPdWUPwI8ufhViTDIquuAPU/91tKkz5Wlehc
         c7RWZ1VBxgTx6GzpAPjZSlDHfqRekDjRVHWAWM9ujXXyPaXDLv0yJN8IEzPK8IB/UUPy
         cDbtFrA70Svjs9WhKjyRk1OSdCGvJ578WZWX6/K9qtLw4d7A6SaKFJbeTUx1RIYJCs6F
         cW6yIKlPK++zgSk2zUFfEjkIfxr/+V9bmyKxEHXIH/yq3hIaMhG3OOGdQ5HXlKNxin/Y
         t6r1at1f05kdC6Scll4bZq58447eq1QDHn0rdye6dl2puQqk1cPLwJZmhET+a85hKiJS
         F0jQ==
X-Received: by 10.180.82.230 with SMTP id l6mr6698wiy.11.1405383708320;
        Mon, 14 Jul 2014 17:21:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.182.197 with SMTP id eg5ls498438wic.1.canary; Mon, 14 Jul
 2014 17:21:47 -0700 (PDT)
X-Received: by 10.180.89.232 with SMTP id br8mr115308wib.1.1405383707334;
        Mon, 14 Jul 2014 17:21:47 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id r19si409166wik.0.2014.07.14.17.21.47
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jul 2014 17:21:47 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MEWkb-1XMTh232DZ-00FnET;
 Tue, 15 Jul 2014 02:21:45 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140712075035.GA12400@ucw.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:1FWF/NXQ5zGXoo75V2zuiuHFnbnwGT+6E9eHF+uZ+xulvgYVWhs
 oW3Fc4rEffQ1kykr+3vnNT1G8BTucyUMsCBusUI3S7wC8yw6BTyEhiWIhGGS/v2awvJXdtd
 62/QChGZFGPSQYlmtOKPUAakh1iFxSmF6K6Da1dxJp8xv0+4Ac6fUg/f1uDqcs+sc4sswRv
 l8FiYwWwvNdnBljAZLotg==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253546>

Hi Stepan,

On Sat, 12 Jul 2014, Stepan Kasal wrote:

> > Am 10.07.2014 22:05, schrieb Johannes Sixt:
> > > It looks like I totally missed the topic sk/mingw-unicode-spawn-args.
> ...
> > > Am I doing something wrong? Does the topic depend on a particular
> > > version of MSYS (or DLL)?
> 
> unfortunately, I paused my submissions at random point.

;-)

> I'm sorry for breaking your setup.  I was not aware there is any
> working Windows setup beyond msysGit.

There is one other, very notable development environment relevant to Git
for Windows: https://github.com/sschuberth/mingwGitDevEnv. It is slated to
be the development environment to produce Git for Windows starting with
version 2.0.0.

I have pretty concrete plans to work on that switch, which will most
likely also affect Hannes (who has so far successfully resisted to develop
Git using the msysGit environment).

Those plans to step up my efforts regarding Git for Windows imply my
spending more time on the project again, subject to a couple of things
that are still being hashed out.

Stay tuned,
Dscho

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
