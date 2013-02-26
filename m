From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] improve-wincred-compatibility
Date: Tue, 26 Feb 2013 17:19:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1302261718210.32206@s15462909.onlinehome-server.info>
References: <50E73B80.4070105@gmail.com> <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com> <50EC473A.6060203@gmail.com> <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com> <50EEAF9A.6020302@gmail.com>
 <CABPQNSaUizZPVOeeuEyb=o-Qmm4mYCRxV27qkmp62cSpFkinqA@mail.gmail.com> <7vsj4k3nbu.fsf@alter.siamese.dyndns.org> <512BF61B.4020708@dcon.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com, 
    git@vger.kernel.org, msysgit@googlegroups.com, Jeff King <peff@peff.net>, 
    patthoyts@gmail.com
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBKOBWOEQKGQEL6LXQKY@googlegroups.com Tue Feb 26 17:20:16 2013
Return-path: <msysgit+bncBCZPH74Q5YNRBKOBWOEQKGQEL6LXQKY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f60.google.com ([209.85.161.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBKOBWOEQKGQEL6LXQKY@googlegroups.com>)
	id 1UANGJ-0007UR-3V
	for gcvm-msysgit@m.gmane.org; Tue, 26 Feb 2013 17:20:15 +0100
Received: by mail-fa0-f60.google.com with SMTP id x10sf1649647fax.25
        for <gcvm-msysgit@m.gmane.org>; Tue, 26 Feb 2013 08:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :x-y-gmx-trusted:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=CNSHcVWqWa4Y/MNxCJ1jJitbzM7MtINjJhI8EBnh+dk=;
        b=QDNhipFF/6rTFMi6LptHaMU4VJPlEuFfRAUiY2lKzO/sA3LRdWr2I1d8XTE9EoZhi0
         lXkrPVWiG6IWxLay5njwY+PKu4fe4mA21gRqS6bnq9YpIeyI+1sJ1oj/M1mue5V8/EKi
         5zwpF7Phb+g3ebcQ2GYa+/qS+r8y7I89FKBzhdiEfPyXH6Is/WJhq7Rv/fNLMbRgV7x6
         YQaFO/gcpBC1RS3wdYoc1xXctgWVQXreXX6iUaNeD45flufIh0jS5 
X-Received: by 10.181.13.100 with SMTP id ex4mr1516790wid.0.1361895594022;
        Tue, 26 Feb 2013 08:19:54 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.8.70 with SMTP id p6ls294644wia.27.gmail; Tue, 26 Feb 2013
 08:19:53 -0800 (PST)
X-Received: by 10.14.220.131 with SMTP id o3mr17382512eep.3.1361895592948;
        Tue, 26 Feb 2013 08:19:52 -0800 (PST)
X-Received: by 10.14.220.131 with SMTP id o3mr17382511eep.3.1361895592941;
        Tue, 26 Feb 2013 08:19:52 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTP id 47si426520eeh.1.2013.02.26.08.19.52;
        Tue, 26 Feb 2013 08:19:52 -0800 (PST)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from mailout-de.gmx.net ([10.1.76.12]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0LfUwx-1Ud6MT2NlB-00p1bT for
 <msysgit@googlegroups.com>; Tue, 26 Feb 2013 17:19:52 +0100
Received: (qmail invoked by alias); 26 Feb 2013 16:19:51 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp012) with SMTP; 26 Feb 2013 17:19:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EWohL8qFEMn6koL/76/t4Ve5QIrxtaeUKn9CwRO
	jVR+dDusN/MaGt
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <512BF61B.4020708@dcon.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.21 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217142>

Hi Karsten,

On Tue, 26 Feb 2013, Karsten Blees wrote:

> @Pat, Dscho: the rebase-merge script should automatically drop patches
> found in upstream, correct?

Yep, that's the idea. Under some circumstances, --cherry will fail to pick
up on it and the commits will still be marked for 'pick', but when it
comes to them, there will be no changes to be committed.

Ciao,
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
For more options, visit https://groups.google.com/groups/opt_out.
