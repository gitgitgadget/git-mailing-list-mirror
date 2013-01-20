From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 20 Jan 2013 03:06:18 -0800
Message-ID: <20130120110618.GF16339@elie.Belkin>
References: <50E9F7C2.1000603@gmail.com>
 <FBDECCA565D94DF9838DD81FE2E2543A@black>
 <7v1udxladc.fsf@alter.siamese.dyndns.org>
 <50EB8EB5.6080204@gmail.com>
 <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com>
 <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com>
 <50F303D8.20709@gmail.com>
 <50F5A435.5090408@ramsay1.demon.co.uk>
 <20130120101007.GD16339@elie.Belkin>
 <50FBCB95.6020201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jason Pyeron <jpyeron@pdinc.us>,
	git@vger.kernel.org, Stephen & Linda Smith <ischis2@cox.net>,
	Eric Blake <eblake@redhat.com>, msysGit <msysgit@googlegroups.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBD6LRKOE4AIRBMM756DQKGQET44IFAI@googlegroups.com Sun Jan 20 12:06:47 2013
Return-path: <msysgit+bncBD6LRKOE4AIRBMM756DQKGQET44IFAI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f190.google.com ([209.85.220.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRBMM756DQKGQET44IFAI@googlegroups.com>)
	id 1Twsjc-0005YX-9J
	for gcvm-msysgit@m.gmane.org; Sun, 20 Jan 2013 12:06:44 +0100
Received: by mail-vc0-f190.google.com with SMTP id fw7sf859442vcb.7
        for <gcvm-msysgit@m.gmane.org>; Sun, 20 Jan 2013 03:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:date:from:to:cc:subject:message-id:references
         :mime-version:in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition
         :content-transfer-encoding;
        bh=HQIivOl/Lxu9MKObXx01lHDDYFmqg7m/24TPoEKbvms=;
        b=DNuNXgs2w/fRcci0xHlk2I9/PKESkusFGGraBBRY8i/3se7rCtCcUOgShEa52ApZMO
         yN5rqOSxHnucn6oqoQ3n+ryWLWFTLzcYGFYCeFHRk+w572rSu2BW7JDhnxjhc/JdGT0J
         8bnJyIEYzY0jd3CYdfTVbSKpKCvqhKu9XvzpxkEGIuyn3QdFY0kwVZFkf/fT/aIvRz/K
         vP8MwXMtyHtDtx5t3BAuvKXqaPx5WtbDScs+w2hIEeFw7SJj8SiN 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:date:from:to:cc:subject:message-id:references
         :mime-version:in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition
         :content-transfer-encoding;
        bh=HQIivOl/Lxu9MKObXx01lHDDYFmqg7m/24TPoEKbvms=;
        b=vgEj9Ts1EyMFi9Y2j7X9lz3bith28QbuHL+6l9vdko36M6jFWvR7RCK+C/+JWhqyb9
         HtJQg9OwV9hkFRoVTJrnNBzUe4UihrTaM7E+wZXFQayeBOHCMIadSQKe9KzYuwrNDG+u
         MQQyFvwiC7r7nva2aWkEOzoGlb61xe+HBiIPQnqZu8nfmZmAnD0oLbaRxIDSinBxbVVO
         18Ad5V+RsCC3jTRdfTo3BMeiQ8HxmKmxIP/mEoptYmgaPd+tGvKcDbAQjuI 
X-Received: by 10.50.45.226 with SMTP id q2mr2086827igm.0.1358679986634;
        Sun, 20 Jan 2013 03:06:26 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.213.2 with SMTP id no2ls1595602igc.15.gmail; Sun, 20 Jan
 2013 03:06:25 -0800 (PST)
X-Received: by 10.66.86.138 with SMTP id p10mr1762514paz.14.1358679985013;
        Sun, 20 Jan 2013 03:06:25 -0800 (PST)
X-Received: by 10.66.86.138 with SMTP id p10mr1762513paz.14.1358679985004;
        Sun, 20 Jan 2013 03:06:25 -0800 (PST)
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com [209.85.220.42])
        by gmr-mx.google.com with ESMTPS id n8si1937331paz.2.2013.01.20.03.06.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Jan 2013 03:06:25 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 209.85.220.42 as permitted sender) client-ip=209.85.220.42;
Received: by mail-pa0-f42.google.com with SMTP id rl6so2894120pac.1
        for <msysgit@googlegroups.com>; Sun, 20 Jan 2013 03:06:24 -0800 (PST)
X-Received: by 10.68.197.9 with SMTP id iq9mr21104720pbc.130.1358679984924;
        Sun, 20 Jan 2013 03:06:24 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id qr8sm6595810pbc.64.2013.01.20.03.06.22
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Jan 2013 03:06:23 -0800 (PST)
In-Reply-To: <50FBCB95.6020201@web.de>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 209.85.220.42 as
 permitted sender) smtp.mail=jrnieder@gmail.com;       dkim=pass header.i=@gmail.com
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214002>

Torsten B=F6gershausen wrote:

> I wonder, if if we can go one step further:
>
> Replace
> #ifdef WIN32 /* Both MinGW and MSVC */
[...]
> with
> #if defined(_MSC_VER)

I thought Git for Windows was built using mingw, which doesn't define
_MSC_VER?

Puzzled,
Jonathan

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den
