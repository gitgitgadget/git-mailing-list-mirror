From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] mingw: redefine the wrapper macro after the
 corresponding function
Date: Fri, 6 Jun 2014 10:32:33 +0200
Organization: <)><
Message-ID: <20140606083233.GB1303@camelia.ucw.cz>
References: <20140605080519.GB28029@camelia.ucw.cz> <5390A139.2090406@kdbg.org> <5390E893.9060600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, GIT Mailing-list <git@vger.kernel.org>,
        msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBI7ZYWOAKGQE7LX35VI@googlegroups.com Fri Jun 06 10:32:36 2014
Return-path: <msysgit+bncBCU63DXMWULRBI7ZYWOAKGQE7LX35VI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f190.google.com ([209.85.212.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBI7ZYWOAKGQE7LX35VI@googlegroups.com>)
	id 1WspZk-0005B6-Gt
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 10:32:36 +0200
Received: by mail-wi0-f190.google.com with SMTP id q5sf53166wiv.7
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 01:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=u6dl/Px/RxHlPSV3RE2ROaFTZarLXYmhlrtsQ47bpJk=;
        b=HiGfgrNMpdfq5fTKS02zuN8QtDMB98QP/YrPa4E3eiKzVR1lNcx5+O5rlJ/OfwSE4n
         IJ/UTeV8mAJVm2QiiAAYZ3T96Gf+VUknRMo49LicRoX+ad642gAuwxZqm7/b76tIPRpX
         my2dIbdIPhMjvP8qD874KpaT0tqhKSypLwnIppWuFQY5+pGDUe2kWXXu4RCqkZ0I3hGe
         ZaYONBA8A92HgX0Mg7NL8itRszIv5wwWYh+Np21rogCDb8bMwNZEb2ya7p5vn8P5IBaR
         qfIqkE0uxeAcFwhc+cArojoyWCoDir91t+pJ3Gw9pmLSmXyqbJJwsxDuJ2WfX2JMZCJ2
         IBww==
X-Received: by 10.180.20.43 with SMTP id k11mr8510wie.12.1402043556287;
        Fri, 06 Jun 2014 01:32:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.93.162 with SMTP id cv2ls45040wib.25.gmail; Fri, 06 Jun
 2014 01:32:35 -0700 (PDT)
X-Received: by 10.180.82.98 with SMTP id h2mr591376wiy.0.1402043555293;
        Fri, 06 Jun 2014 01:32:35 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id e12si1594117wiv.1.2014.06.06.01.32.35
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 01:32:35 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 06E481C009B;
	Fri,  6 Jun 2014 10:32:35 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s568WYv4001465;
	Fri, 6 Jun 2014 10:32:34 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s568WXrd001464;
	Fri, 6 Jun 2014 10:32:33 +0200
In-Reply-To: <5390E893.9060600@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250893>

Hello,

On Fri, Jun 06, 2014 at 12:00:51AM +0200, Karsten Blees wrote:
> Am 05.06.2014 18:56, schrieb Johannes Sixt:
> > Within mingw.c, if some other function inside mingw.c wants to use
> > mingw_unlink, then it should be written as 'mingw_unlink(foo)', not
> > 'unlink(foo)'.
> I very much like this approach. In fact, we already do this for e.g. mingw_raise.

Hannes, this is consistent with your commit 06bc4b7.  Settled.

> Other callers would typically want the wrapped version (i.e.
> mingw_*).

If this assumption were true, then we have to keep the wrapper macros
defined, both above and below the wrapper function definition.
You are in fact advocating my patch.

Updated version follows.

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
