From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 4/8] staging: et131x: Remove ununsed statistics
Date: Sat, 13 Sep 2014 23:57:51 +0300
Message-ID: <20140913205751.GA17875@mwanda>
References: <1410472786-14552-1-git-send-email-mark.einon@gmail.com>
 <1410472786-14552-5-git-send-email-mark.einon@gmail.com>
 <20140913093746.GD6600@mwanda> <20140913154556.GA12361@kroah.com>
 <20140913203645.GB24854@peff.net>
 <20140913204745.GA12291@msilap.einon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, devel@driverdev.osuosl.org, git@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>
To: Mark Einon <mark.einon@gmail.com>
X-From: driverdev-devel-bounces@linuxdriverproject.org Sat Sep 13 22:58:14 2014
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Envelope-to: glddd-devel@m.gmane.org
Received: from hemlock.osuosl.org ([140.211.166.133])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <driverdev-devel-bounces@linuxdriverproject.org>)
	id 1XSuOZ-0004AL-Ds
	for glddd-devel@m.gmane.org; Sat, 13 Sep 2014 22:58:11 +0200
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BD3B7952BE;
	Sat, 13 Sep 2014 20:58:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A6lCHuKbRbSS; Sat, 13 Sep 2014 20:58:08 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by hemlock.osuosl.org (Postfix) with ESMTP id 44C7F951F8;
	Sat, 13 Sep 2014 20:58:08 +0000 (UTC)
X-Original-To: devel@linuxdriverproject.org
Delivered-To: driverdev-devel@osuosl.org
Received: from whitealder.osuosl.org (whitealder.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id C4BB51C28B1
 for <devel@linuxdriverproject.org>; Sat, 13 Sep 2014 20:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BA82D91534
 for <devel@linuxdriverproject.org>; Sat, 13 Sep 2014 20:58:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HGU3vpxj3YQy for <devel@linuxdriverproject.org>;
 Sat, 13 Sep 2014 20:58:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 21CE390F4F
 for <devel@driverdev.osuosl.org>; Sat, 13 Sep 2014 20:58:06 +0000 (UTC)
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
 by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 s8DKw45O028051
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
 Sat, 13 Sep 2014 20:58:04 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
 by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s8DKw2eO029743
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Sat, 13 Sep 2014 20:58:03 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id s8DKw0j4027267;
 Sat, 13 Sep 2014 20:58:01 GMT
Received: from mwanda (/41.202.233.190)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 13 Sep 2014 13:58:00 -0700
Content-Disposition: inline
In-Reply-To: <20140913204745.GA12291@msilap.einon.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256978>

On Sat, Sep 13, 2014 at 09:47:45PM +0100, Mark Einon wrote:
> On Sat, Sep 13, 2014 at 04:36:45PM -0400, Jeff King wrote:
> > I don't think we can make this 100% foolproof without knowing which mbox
> > variant the writer used. But dropping the line is probably the worst
> > possible thing, as it does not match _any_ variants. :)
> 
> Hi,
> 
> FYI it was 'git send-email' v2.1.0 that sent the mail, and I don't have
> the offending character in any versions of the mail I can see.
> 

The mailing list version has it.

http://www.spinics.net/lists/linux-driver-devel/msg54372.html

regards,
dan carpenter
