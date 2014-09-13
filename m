From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 4/8] staging: et131x: Remove ununsed statistics
Date: Sat, 13 Sep 2014 22:41:34 +0300
Message-ID: <20140913194134.GF6549@mwanda>
References: <1410472786-14552-1-git-send-email-mark.einon@gmail.com>
 <1410472786-14552-5-git-send-email-mark.einon@gmail.com>
 <20140913093746.GD6600@mwanda> <20140913154556.GA12361@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devel@driverdev.osuosl.org, Mark Einon <mark.einon@gmail.com>,
 git@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
X-From: driverdev-devel-bounces@linuxdriverproject.org Sat Sep 13 21:41:57 2014
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Envelope-to: glddd-devel@m.gmane.org
Received: from hemlock.osuosl.org ([140.211.166.133])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <driverdev-devel-bounces@linuxdriverproject.org>)
	id 1XStCk-0002xW-4Q
	for glddd-devel@m.gmane.org; Sat, 13 Sep 2014 21:41:54 +0200
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 922EA955A7;
	Sat, 13 Sep 2014 19:41:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x8+IO5y0Q5eW; Sat, 13 Sep 2014 19:41:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by hemlock.osuosl.org (Postfix) with ESMTP id B5FE9955A4;
	Sat, 13 Sep 2014 19:41:51 +0000 (UTC)
X-Original-To: devel@linuxdriverproject.org
Delivered-To: driverdev-devel@osuosl.org
Received: from whitealder.osuosl.org (whitealder.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id AEB8D1C2C7F
 for <devel@linuxdriverproject.org>; Sat, 13 Sep 2014 19:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A891F92112
 for <devel@linuxdriverproject.org>; Sat, 13 Sep 2014 19:41:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GVtWI8pO1qYn for <devel@linuxdriverproject.org>;
 Sat, 13 Sep 2014 19:41:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2F0F19210F
 for <devel@driverdev.osuosl.org>; Sat, 13 Sep 2014 19:41:50 +0000 (UTC)
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
 by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 s8DJfmrm013817
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
 Sat, 13 Sep 2014 19:41:49 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
 by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s8DJflm5020028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Sat, 13 Sep 2014 19:41:48 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s8DJflie020022;
 Sat, 13 Sep 2014 19:41:47 GMT
Received: from mwanda (/41.202.233.190)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 13 Sep 2014 12:41:47 -0700
Content-Disposition: inline
In-Reply-To: <20140913154556.GA12361@kroah.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256971>

On Sat, Sep 13, 2014 at 08:45:56AM -0700, Greg KH wrote:
> On Sat, Sep 13, 2014 at 12:37:46PM +0300, Dan Carpenter wrote:
> > On Thu, Sep 11, 2014 at 10:59:42PM +0100, Mark Einon wrote:
> > > >From struct ce_stats; unicast_pkts_rcvd, unicast_pkts_xmtd,
> > > multicast_pkts_xmtd, broadcast_pkts_rcvd and broadcast_pkts_xmtd
> > 
> > For some reason something adds a '>' to the start of lines which start
> > with 'From'.  I don't know what it is...
> 
> It's an email protocol requirement, some RFC dictates it as "From" at
> the start of the line is an email "start" flag.
> 
> > When I apply this patch with 'git am' then it just removes the From
> > line.
> 
> As it should :)
> 

But now the changelog is corrupt.  I have tested with the git version
2.1.0.238.gce1d3a9.  The first line of the changelog gets chopped off
because of the ">From".

It's a little annoying.  Do we just tell Mark to resend with a different
changelog or is there a way to fix the tools?

regards,
dan carpenter
