From: Joe Perches <joe@perches.com>
Subject: project wide: git config entry for [diff] renames=true
Date: Thu, 25 Sep 2014 08:48:31 -0700
Message-ID: <1411660111.4026.24.camel@joe-AO725>
References: <Pine.LNX.4.44L0.1409241106100.1580-100000@iolanthe.rowland.org>
	 <1411591401-5874-1-git-send-email-sojka@merica.cz>
	 <1411591401-5874-4-git-send-email-sojka@merica.cz>
	 <20140925150353.GA15325@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michal Sojka <sojka@merica.cz>, linux-usb@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Bryan Wu <cooloney@gmail.com>, Felipe Balbi <balbi@ti.com>,
	Linux LED Subsystem <linux-leds@vger.kernel.org>,
	linux-kernel@vger.kernel.org, michal.vokac@comap.cz,
	git <git@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-From: linux-kernel-owner@vger.kernel.org Thu Sep 25 17:48:50 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1XXBHl-0002G6-Ns
	for glk-linux-kernel-3@plane.gmane.org; Thu, 25 Sep 2014 17:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbaIYPsh (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 25 Sep 2014 11:48:37 -0400
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:36578 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752600AbaIYPsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2014 11:48:36 -0400
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0B13D12BCD9;
	Thu, 25 Sep 2014 15:48:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2911:3138:3139:3140:3141:3142:3350:3622:3865:3867:3868:3870:3871:3872:3873:3874:4321:4425:5007:7652:7903:10004:10400:10848:11232:11658:11914:12517:12519:12740:13019:13069:13149:13230:13311:13357:21080,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0
X-HE-Tag: paper21_1073af4a2a432
X-Filterd-Recvd-Size: 1675
Received: from [192.168.1.155] (pool-71-103-235-196.lsanca.fios.verizon.net [71.103.235.196])
	(Authenticated sender: joe@perches.com)
	by omf01.hostedemail.com (Postfix) with ESMTPA;
	Thu, 25 Sep 2014 15:48:32 +0000 (UTC)
In-Reply-To: <20140925150353.GA15325@kroah.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257478>

On Thu, 2014-09-25 at 17:03 +0200, Greg Kroah-Hartman wrote:

> In the future, please generate a git "move" diff, which makes it easier
> to review, and prove that nothing really changed.  It also helps if the
> file is a bit different from what you diffed against, which in my case,
> was true.

Maybe it'd be possible to add 

[diff]
	renames = true

to the .git/config file.

but I don't find a mechanism to add anything to the
.git/config and have it be pulled.
