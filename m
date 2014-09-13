From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 4/8] staging: et131x: Remove ununsed statistics
Date: Sun, 14 Sep 2014 00:09:08 +0300
Message-ID: <20140913210908.GG6549@mwanda>
References: <1410472786-14552-1-git-send-email-mark.einon@gmail.com>
 <1410472786-14552-5-git-send-email-mark.einon@gmail.com>
 <20140913093746.GD6600@mwanda> <20140913154556.GA12361@kroah.com>
 <20140913203645.GB24854@peff.net>
 <20140913204745.GA12291@msilap.einon.net>
 <20140913205751.GA17875@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, devel@driverdev.osuosl.org, git@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>
To: Mark Einon <mark.einon@gmail.com>
X-From: driverdev-devel-bounces@linuxdriverproject.org Sat Sep 13 23:09:25 2014
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Envelope-to: glddd-devel@m.gmane.org
Received: from fraxinus.osuosl.org ([140.211.166.137])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <driverdev-devel-bounces@linuxdriverproject.org>)
	id 1XSuZR-0006pp-HF
	for glddd-devel@m.gmane.org; Sat, 13 Sep 2014 23:09:25 +0200
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CA545A1DCD;
	Sat, 13 Sep 2014 21:09:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q1R2yhLwjlcw; Sat, 13 Sep 2014 21:09:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E56D2A1DA4;
	Sat, 13 Sep 2014 21:09:22 +0000 (UTC)
X-Original-To: devel@linuxdriverproject.org
Delivered-To: driverdev-devel@osuosl.org
Received: from silver.osuosl.org (silver.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id F3B941C266B
 for <devel@linuxdriverproject.org>; Sat, 13 Sep 2014 21:09:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EDA693346D
 for <devel@linuxdriverproject.org>; Sat, 13 Sep 2014 21:09:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XfKCctCCrgWw for <devel@linuxdriverproject.org>;
 Sat, 13 Sep 2014 21:09:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id 0D3C831684
 for <devel@driverdev.osuosl.org>; Sat, 13 Sep 2014 21:09:20 +0000 (UTC)
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
 by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 s8DL9IgM016787
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
 Sat, 13 Sep 2014 21:09:19 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
 by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s8DL9IWh010800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Sat, 13 Sep 2014 21:09:18 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s8DL9IDS010794;
 Sat, 13 Sep 2014 21:09:18 GMT
Received: from mwanda (/41.202.233.190)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 13 Sep 2014 14:09:17 -0700
Content-Disposition: inline
In-Reply-To: <20140913205751.GA17875@mwanda>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: acsinet22.oracle.com [141.146.126.238]
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Linux Driver Project Developer List
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>, 
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>, 
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256980>

On Sat, Sep 13, 2014 at 11:57:51PM +0300, Dan Carpenter wrote:
> On Sat, Sep 13, 2014 at 09:47:45PM +0100, Mark Einon wrote:
> > On Sat, Sep 13, 2014 at 04:36:45PM -0400, Jeff King wrote:
> > > I don't think we can make this 100% foolproof without knowing which mbox
> > > variant the writer used. But dropping the line is probably the worst
> > > possible thing, as it does not match _any_ variants. :)
> > 
> > Hi,
> > 
> > FYI it was 'git send-email' v2.1.0 that sent the mail, and I don't have
> > the offending character in any versions of the mail I can see.
> > 
> 
> The mailing list version has it.
> 
> http://www.spinics.net/lists/linux-driver-devel/msg54372.html

Or based on Peff's email it might be a bug in the spinics list software.
Here are some other examples:

Piper mail has '>From'.
http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2014-September/058299.html

but gmane gets it right.
http://comments.gmane.org/gmane.linux.drivers.driver-project.devel/57684

regards,
dan carpenter
