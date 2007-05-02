From: Jan Holesovsky <kendy@suse.cz>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 16:41:52 +0200
Message-ID: <200705021641.53199.kendy@suse.cz>
References: <200705012346.14997.jnareb@gmail.com> <Pine.LNX.4.64.0705020143460.4010@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	releases@openoffice.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 02 16:41:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjG1m-0006BN-Jz
	for gcvg-git@gmane.org; Wed, 02 May 2007 16:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993245AbXEBOlz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 10:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993267AbXEBOlz
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 10:41:55 -0400
Received: from styx.suse.cz ([82.119.242.94]:55271 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S2993245AbXEBOlz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 10:41:55 -0400
Received: from one.suse.cz (one.suse.cz [10.20.1.79])
	by mail.suse.cz (SUSE LINUX ESMTP Mailer) with ESMTP id C37D462811A;
	Wed,  2 May 2007 16:41:53 +0200 (CEST)
User-Agent: KMail/1.9.1
In-Reply-To: <Pine.LNX.4.64.0705020143460.4010@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46025>

Hi Johannes,

On Wednesday 02 May 2007 12:24, Johannes Schindelin wrote:

> On Tue, 1 May 2007, Jakub Narebski wrote:
> > 'Checkout time' (which should be renamed to 'Initial checkout time'),
> > in which git also loses with 130 minutes (Linux, 2MBit DSL) [from
> > go-oo.org], 100min (Linux, 2MBit DSL, Wireless, no proxy) [from
> > go-oo.org] versus 117 minutes (Linux, 2MBit DSL), 26 minutes (Linux,
> > 2MBit DSL, with compression (-z 6)) for CVS, and  60 Minutes (Windows,
> > 34Mbit Line) for Subversion, would also be helped by the above.
>
> FWIW I can confirm the number "100min".
>
> Something I realized with pain is that the refs/ directory is 24MB big.
> Yep. Really. They have 3464 heads and 2639 tags. I suspect that this is
> the reason why.

I should probably produce even a tree where would be the merged branches 
deleted, right...

Regards,
Jan
