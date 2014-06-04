From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] t5000, t5003: do not use test_cmp to compare
 binary files
Date: Wed, 4 Jun 2014 14:42:57 +0200
Organization: <)><
Message-ID: <20140604124257.GA22415@camelia.ucw.cz>
References: <20140604114252.GA22250@camelia.ucw.cz> <538F0D78.3020708@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>, msysgit@googlegroups.com
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: msysgit+bncBCU63DXMWULRBVFIXSOAKGQE7JFPHZQ@googlegroups.com Wed Jun 04 14:43:01 2014
Return-path: <msysgit+bncBCU63DXMWULRBVFIXSOAKGQE7JFPHZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f189.google.com ([74.125.82.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBVFIXSOAKGQE7JFPHZQ@googlegroups.com>)
	id 1WsAWz-0005Bd-0E
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 14:43:01 +0200
Received: by mail-we0-f189.google.com with SMTP id w62sf753168wes.16
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=1qErtNuymdzE+rdOnukvSFNpIzMaB2ah/2+r1dymh6Y=;
        b=jCWPeInJdGCBpsynSiCONJw32sI+9MmnI8VqhDXOAX8C/Nkkl+0F5D3lKq/mzqkdAB
         Czmr9EsEDV0KdGdyS8eHrN84Ap5B3GuqaTi9hzonq/mgYF72gHLbdgitUXhWmkWG1B6X
         vfrPP0UMzljhfIb6zJcahKfiEZvGXEVGx1TmfTwU9N6vxyxJ4puCi99UJGAgYS3B/5Uy
         J8qxQiB46bn+a2h1Se7X2XvuPphaD5E/eIwAzQmnyKmsaOllCOJrNYjRN+rqjpCreito
         vpWdk/TKknGT6ApTkYW4lyh6D3QkfhtPKv0pme68codnlVAfQ0V9wXkExN6oTH0iE+Nr
         BAtQ==
X-Received: by 10.152.87.105 with SMTP id w9mr7828laz.31.1401885780723;
        Wed, 04 Jun 2014 05:43:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.26.4 with SMTP id h4ls420415lag.58.gmail; Wed, 04 Jun 2014
 05:42:59 -0700 (PDT)
X-Received: by 10.112.49.229 with SMTP id x5mr1589884lbn.14.1401885779738;
        Wed, 04 Jun 2014 05:42:59 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id se3si1144765wic.3.2014.06.04.05.42.59
        for <msysgit@googlegroups.com>;
        Wed, 04 Jun 2014 05:42:59 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 483631C00A8;
	Wed,  4 Jun 2014 14:42:58 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s54CgvC0022452;
	Wed, 4 Jun 2014 14:42:57 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s54CgvgL022451;
	Wed, 4 Jun 2014 14:42:57 +0200
In-Reply-To: <538F0D78.3020708@virtuell-zuhause.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250725>

Hello Thomas,

On Wed, Jun 04, 2014 at 02:13:44PM +0200, Thomas Braun wrote:
> Wouldn't a function like test_cmp_bin() be better suited for all?

I also considered it.  The advantage is that is shows that
this intentionally differs from test_cmp.

> The windows folks can then use cmp inside test_cmp_bin() and all others

... would use cmp as well because it is better suited for the task
than diff -u.  So test_cmp_bin would be just an alias for cmp, on all
platforms.  Doesn't that sound weird?

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
