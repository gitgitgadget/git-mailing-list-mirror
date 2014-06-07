From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: Re: [PATCH 3/5] Warn if the Windows console font
 doesn't support Unicode
Date: Sat, 7 Jun 2014 09:02:08 +0200
Organization: <)><
Message-ID: <20140607070208.GA8400@camelia.ucw.cz>
References: <1402062173-9602-1-git-send-email-kasal@ucw.cz> <1402062173-9602-4-git-send-email-kasal@ucw.cz> <alpine.DEB.2.00.1406062211360.17391@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>,
        Karsten Blees <blees@dcon.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: msysgit+bncBCU63DXMWULRB4XRZKOAKGQEP6KJOTY@googlegroups.com Sat Jun 07 09:02:13 2014
Return-path: <msysgit+bncBCU63DXMWULRB4XRZKOAKGQEP6KJOTY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f186.google.com ([74.125.82.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB4XRZKOAKGQEP6KJOTY@googlegroups.com>)
	id 1WtAdn-0001Iy-0y
	for gcvm-msysgit@m.gmane.org; Sat, 07 Jun 2014 09:02:11 +0200
Received: by mail-we0-f186.google.com with SMTP id u57sf432323wes.23
        for <gcvm-msysgit@m.gmane.org>; Sat, 07 Jun 2014 00:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=3I+0XSOApZfBtGUiVmZ4gofKUFtd3V2V9mnUCJ9j47w=;
        b=AJe22Fh6DHDugWTfmZe/f3kEHZVm8MN4iJAxoFKJComdGHmzfAPtPSFesJaiHZeInJ
         1oS60JyJsfKxF99HdfyTVYo+xzfAaIfzJfjIB6rAxZHkDl6mv3jyrj3vXJNJiYrAK2NZ
         i1rK8UMuymjxvllSau2IncXqUelHSMf0/whgmrwH6p0z6bODElbQjaAdSJ6N3ANySpLF
         ZIJsRg0GjVOembC59eeygCNEppBBPdb97mmS6BFaRUNiTp7PxSGvZZ5lRKHYgImUrxwp
         JkH7170X4irjlx3dNvVqs4vX3Q/MEaRsrkxzp64VGVSIjId8rT8+oCv+1mnci4oHee37
         PKhg==
X-Received: by 10.152.18.134 with SMTP id w6mr128479lad.1.1402124530618;
        Sat, 07 Jun 2014 00:02:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.170.133 with SMTP id am5ls179385lac.36.gmail; Sat, 07 Jun
 2014 00:02:09 -0700 (PDT)
X-Received: by 10.152.37.100 with SMTP id x4mr124863laj.6.1402124529538;
        Sat, 07 Jun 2014 00:02:09 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id e12si74289wiv.1.2014.06.07.00.02.09
        for <msysgit@googlegroups.com>;
        Sat, 07 Jun 2014 00:02:09 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 3EF901C00A0;
	Sat,  7 Jun 2014 09:02:09 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s577289R008441;
	Sat, 7 Jun 2014 09:02:08 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s57728u6008440;
	Sat, 7 Jun 2014 09:02:08 +0200
In-Reply-To: <alpine.DEB.2.00.1406062211360.17391@ds9.cixit.se>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251029>

Hi,

On Fri, Jun 06, 2014 at 10:18:43PM +0100, Peter Krefting wrote:
> Stepan Kasal:
>> +		"switching to a TrueType font such as Lucida Console!");
[...]
> modernizing the suggestion here to recomment "Consolas". It is available 

Indeed.

So, I'll keep this patch as it is, for the records, and apply your
suggestion to the subsequent
	[PATCH 5/5] Win32: Thread-safe windows console output

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
