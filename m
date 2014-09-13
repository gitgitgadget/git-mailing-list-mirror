From: Mark Einon <mark.einon@gmail.com>
Subject: Re: [PATCH 4/8] staging: et131x: Remove ununsed statistics
Date: Sat, 13 Sep 2014 21:47:45 +0100
Message-ID: <20140913204745.GA12291@msilap.einon.net>
References: <1410472786-14552-1-git-send-email-mark.einon@gmail.com>
 <1410472786-14552-5-git-send-email-mark.einon@gmail.com>
 <20140913093746.GD6600@mwanda> <20140913154556.GA12361@kroah.com>
 <20140913203645.GB24854@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>,
 git@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
To: Jeff King <peff@peff.net>
X-From: driverdev-devel-bounces@linuxdriverproject.org Sat Sep 13 22:47:55 2014
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Envelope-to: glddd-devel@m.gmane.org
Received: from silver.osuosl.org ([140.211.166.136])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <driverdev-devel-bounces@linuxdriverproject.org>)
	id 1XSuEd-0001io-0r
	for glddd-devel@m.gmane.org; Sat, 13 Sep 2014 22:47:55 +0200
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7992132CE0;
	Sat, 13 Sep 2014 20:47:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QKRivGEzDYnl; Sat, 13 Sep 2014 20:47:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by silver.osuosl.org (Postfix) with ESMTP id A650632CD7;
	Sat, 13 Sep 2014 20:47:51 +0000 (UTC)
X-Original-To: devel@linuxdriverproject.org
Delivered-To: driverdev-devel@osuosl.org
Received: from whitealder.osuosl.org (whitealder.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 852CD1C28B1
 for <devel@linuxdriverproject.org>; Sat, 13 Sep 2014 20:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7F84292122
 for <devel@linuxdriverproject.org>; Sat, 13 Sep 2014 20:47:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BtmO9I-u92pg for <devel@linuxdriverproject.org>;
 Sat, 13 Sep 2014 20:47:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.einon.net (unknown [80.229.23.162])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3616292120
 for <devel@driverdev.osuosl.org>; Sat, 13 Sep 2014 20:47:49 +0000 (UTC)
Received: from msilap.einon.net (unknown [192.168.2.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.einon.net (Postfix) with ESMTPSA id 833EF9E;
 Sat, 13 Sep 2014 21:47:47 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20140913203645.GB24854@peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256977>

On Sat, Sep 13, 2014 at 04:36:45PM -0400, Jeff King wrote:
> I don't think we can make this 100% foolproof without knowing which mbox
> variant the writer used. But dropping the line is probably the worst
> possible thing, as it does not match _any_ variants. :)

Hi,

FYI it was 'git send-email' v2.1.0 that sent the mail, and I don't have
the offending character in any versions of the mail I can see.

Cheers,

Mark
