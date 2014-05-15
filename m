From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] transport-helper: add trailing --
Date: Thu, 15 May 2014 11:16:43 +0200
Organization: <)><
Message-ID: <20140515091643.GA13165@camelia.ucw.cz>
References: <20140515053214.GA12133@camelia.ucw.cz> <20140515090013.GB27033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
        Sverre Rabbelier <srabbelier@gmail.com>,
        msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCU63DXMWULRB74L2KNQKGQEC3IXNZQ@googlegroups.com Thu May 15 11:16:50 2014
Return-path: <msysgit+bncBCU63DXMWULRB74L2KNQKGQEC3IXNZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f57.google.com ([209.85.215.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB74L2KNQKGQEC3IXNZQ@googlegroups.com>)
	id 1WkrmS-0004Kl-2q
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 11:16:48 +0200
Received: by mail-la0-f57.google.com with SMTP id hr17sf76725lab.22
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 May 2014 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=N1K6sksSS6RVN/Nut2EYZTSsahaieqqbfk3r0vwheBM=;
        b=dNFhTytFZU+fN9qzdAOCO141Hut1m/QvAdEzTVtf9I0y/rqBqpli9AY3s7n/ENXKFg
         s9HqRrAB2JlaU0rDreQNuIxI1w/wCCcwSkmBNT4UjFMA2aJZBMXfMFxo6JxVzwp16Ahd
         dCKsmQ+jV+g/mF2nyrUYVhGxDxH8B/Em7mUmsdpsU0HTMeCQH48xNnHhHNIID/OjKGKk
         KhSdNF1SfTjinbaOub58KG2BfM7gG28qFDjTUrDHtf7omRu5Dr9gnVZkdjTAFuCy7cM6
         7qYWittfPE4j+P69NQipTltYJrOH/QvOam6VY10NrOCb0y6X553E8vEQaj4cJhcO8+hz
         +zJw==
X-Received: by 10.152.43.202 with SMTP id y10mr9750lal.33.1400145407697;
        Thu, 15 May 2014 02:16:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.203.169 with SMTP id kr9ls27461lac.102.gmail; Thu, 15 May
 2014 02:16:46 -0700 (PDT)
X-Received: by 10.112.13.36 with SMTP id e4mr166114lbc.11.1400145406552;
        Thu, 15 May 2014 02:16:46 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r49si1538184eep.0.2014.05.15.02.16.46
        for <msysgit@googlegroups.com>;
        Thu, 15 May 2014 02:16:46 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 4C3861C00EF;
	Thu, 15 May 2014 11:16:46 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4F9GjQ1013180;
	Thu, 15 May 2014 11:16:46 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4F9GhGF013179;
	Thu, 15 May 2014 11:16:43 +0200
In-Reply-To: <20140515090013.GB27033@sigill.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249078>

Hi Peff,

On Thu, May 15, 2014 at 05:00:13AM -0400, Jeff King wrote:
> I just posted a series that addresses those leaks and converts this
> site. I do not want to hold your patch hostage to my series, [...]

no problem, let's return to it later.

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
