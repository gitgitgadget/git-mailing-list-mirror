From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/8] staging: et131x: Remove ununsed statistics
Date: Sat, 13 Sep 2014 08:45:56 -0700
Message-ID: <20140913154556.GA12361@kroah.com>
References: <1410472786-14552-1-git-send-email-mark.einon@gmail.com>
 <1410472786-14552-5-git-send-email-mark.einon@gmail.com>
 <20140913093746.GD6600@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devel@driverdev.osuosl.org, Mark Einon <mark.einon@gmail.com>,
 git@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
X-From: driverdev-devel-bounces@linuxdriverproject.org Sat Sep 13 17:46:48 2014
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Envelope-to: glddd-devel@m.gmane.org
Received: from silver.osuosl.org ([140.211.166.136])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <driverdev-devel-bounces@linuxdriverproject.org>)
	id 1XSpXD-000187-TF
	for glddd-devel@m.gmane.org; Sat, 13 Sep 2014 17:46:48 +0200
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CA70933298;
	Sat, 13 Sep 2014 15:46:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NXznmD0qxdGw; Sat, 13 Sep 2014 15:46:45 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by silver.osuosl.org (Postfix) with ESMTP id 1FB1532E7F;
	Sat, 13 Sep 2014 15:46:45 +0000 (UTC)
X-Original-To: devel@linuxdriverproject.org
Delivered-To: driverdev-devel@osuosl.org
Received: from whitealder.osuosl.org (whitealder.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id C04791BF9A7
 for <devel@linuxdriverproject.org>; Sat, 13 Sep 2014 15:46:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BC4F1920B2
 for <devel@linuxdriverproject.org>; Sat, 13 Sep 2014 15:46:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3nICRZnWj9eR for <devel@linuxdriverproject.org>;
 Sat, 13 Sep 2014 15:46:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 38E4A920B1
 for <devel@driverdev.osuosl.org>; Sat, 13 Sep 2014 15:46:44 +0000 (UTC)
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
 by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0B40C990;
 Sat, 13 Sep 2014 15:46:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20140913093746.GD6600@mwanda>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256968>

On Sat, Sep 13, 2014 at 12:37:46PM +0300, Dan Carpenter wrote:
> On Thu, Sep 11, 2014 at 10:59:42PM +0100, Mark Einon wrote:
> > >From struct ce_stats; unicast_pkts_rcvd, unicast_pkts_xmtd,
> > multicast_pkts_xmtd, broadcast_pkts_rcvd and broadcast_pkts_xmtd
> 
> For some reason something adds a '>' to the start of lines which start
> with 'From'.  I don't know what it is...

It's an email protocol requirement, some RFC dictates it as "From" at
the start of the line is an email "start" flag.

> When I apply this patch with 'git am' then it just removes the From
> line.

As it should :)

thanks,

greg k-h
