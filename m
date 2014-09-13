From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 4/8] staging: et131x: Remove ununsed statistics
Date: Sat, 13 Sep 2014 12:37:46 +0300
Message-ID: <20140913093746.GD6600@mwanda>
References: <1410472786-14552-1-git-send-email-mark.einon@gmail.com>
 <1410472786-14552-5-git-send-email-mark.einon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org, git@vger.kernel.org
To: Mark Einon <mark.einon@gmail.com>
X-From: driverdev-devel-bounces@linuxdriverproject.org Sat Sep 13 11:37:53 2014
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Envelope-to: glddd-devel@m.gmane.org
Received: from whitealder.osuosl.org ([140.211.166.138])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <driverdev-devel-bounces@linuxdriverproject.org>)
	id 1XSjmB-0000ur-VQ
	for glddd-devel@m.gmane.org; Sat, 13 Sep 2014 11:37:52 +0200
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 15A4091FFA;
	Sat, 13 Sep 2014 09:37:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VpSh4SaJPTbG; Sat, 13 Sep 2014 09:37:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3F83C91FF2;
	Sat, 13 Sep 2014 09:37:50 +0000 (UTC)
X-Original-To: devel@linuxdriverproject.org
Delivered-To: driverdev-devel@osuosl.org
Received: from fraxinus.osuosl.org (fraxinus.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 235271C2460
 for <devel@linuxdriverproject.org>; Sat, 13 Sep 2014 09:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1F345A1D44
 for <devel@linuxdriverproject.org>; Sat, 13 Sep 2014 09:37:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a5krxmD8-kG5 for <devel@linuxdriverproject.org>;
 Sat, 13 Sep 2014 09:37:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B4073A1D3D
 for <devel@driverdev.osuosl.org>; Sat, 13 Sep 2014 09:37:48 +0000 (UTC)
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
 by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 s8D9bkvA016808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
 Sat, 13 Sep 2014 09:37:47 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
 by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s8D9bjHB003379
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Sat, 13 Sep 2014 09:37:46 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id s8D9bj0E008534;
 Sat, 13 Sep 2014 09:37:45 GMT
Received: from mwanda (/41.202.233.190)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 13 Sep 2014 02:37:44 -0700
Content-Disposition: inline
In-Reply-To: <1410472786-14552-5-git-send-email-mark.einon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: ucsinet21.oracle.com [156.151.31.93]
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256959>

On Thu, Sep 11, 2014 at 10:59:42PM +0100, Mark Einon wrote:
> >From struct ce_stats; unicast_pkts_rcvd, unicast_pkts_xmtd,
> multicast_pkts_xmtd, broadcast_pkts_rcvd and broadcast_pkts_xmtd

For some reason something adds a '>' to the start of lines which start
with 'From'.  I don't know what it is...

When I apply this patch with 'git am' then it just removes the From
line.

I have seen these '>From' lines before but I haven't seen anyone discuss
this problem.

regards,
dan carpenter
