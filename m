From: Mark Einon <mark.einon@gmail.com>
Subject: Re: [PATCH 4/8] staging: et131x: Remove ununsed statistics
Date: Sat, 13 Sep 2014 22:06:52 +0100
Message-ID: <20140913210652.GB12291@msilap.einon.net>
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
To: Dan Carpenter <dan.carpenter@oracle.com>
X-From: driverdev-devel-bounces@linuxdriverproject.org Sat Sep 13 23:07:01 2014
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Envelope-to: glddd-devel@m.gmane.org
Received: from fraxinus.osuosl.org ([140.211.166.137])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <driverdev-devel-bounces@linuxdriverproject.org>)
	id 1XSuX6-0006F6-Ld
	for glddd-devel@m.gmane.org; Sat, 13 Sep 2014 23:07:01 +0200
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A8C51A1DD5;
	Sat, 13 Sep 2014 21:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UMu8ukz-CpXi; Sat, 13 Sep 2014 21:06:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7409CA1DCC;
	Sat, 13 Sep 2014 21:06:57 +0000 (UTC)
X-Original-To: devel@linuxdriverproject.org
Delivered-To: driverdev-devel@osuosl.org
Received: from whitealder.osuosl.org (whitealder.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id BAFC91C266B
 for <devel@linuxdriverproject.org>; Sat, 13 Sep 2014 21:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B486292128
 for <devel@linuxdriverproject.org>; Sat, 13 Sep 2014 21:06:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rsu73Wf08KFd for <devel@linuxdriverproject.org>;
 Sat, 13 Sep 2014 21:06:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.einon.net (unknown [80.229.23.162])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B574B92127
 for <devel@driverdev.osuosl.org>; Sat, 13 Sep 2014 21:06:55 +0000 (UTC)
Received: from msilap.einon.net (unknown [192.168.2.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.einon.net (Postfix) with ESMTPSA id C317F34;
 Sat, 13 Sep 2014 22:06:53 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20140913205751.GA17875@mwanda>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256979>

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

Fair enough. The marc.info version doesn't though, so it's proably not my MUA:

http://marc.info/?l=linux-driver-devel&m=141047281318963&w=2

Cheers,

Mark
