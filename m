From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Proper Publishing of a Repository
Date: Wed, 22 Mar 2006 14:26:21 -0600
Message-ID: <1143059181.4527.162.camel@cashmere.sps.mot.com>
References: <1143055072.4527.142.camel@cashmere.sps.mot.com>
	 <20060322221630.e65baca0.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 22 21:29:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM9vM-0000YA-Tr
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 21:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWCVU1P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 15:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbWCVU1P
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 15:27:15 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:12030 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S932699AbWCVU1O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 15:27:14 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k2MKfJ5E023011;
	Wed, 22 Mar 2006 13:41:19 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k2MKbDgW006572;
	Wed, 22 Mar 2006 14:37:13 -0600 (CST)
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060322221630.e65baca0.tihirvon@gmail.com>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17827>

On Wed, 2006-03-22 at 14:16, Timo Hirvonen wrote:
> On Wed, 22 Mar 2006 13:17:52 -0600
> Jon Loeliger <jdl@freescale.com> wrote:
> 
> > Folks,
> > 
> > So, I feel like I missed a step in the grand
> > "How To Publish A Repository" scheme of things.
> > 
> > I made a repo visible over on jdl.com.  No problem.
> > But cloning it took forever.  So I ran "git-repack"
> > on it.  Now cloning only takes hours, not forever.
> > 
> > All this on the linux kernel over HTTP.
> 
> Use git:// protocol (git-daemon) if possible.  It is much faster.

Trust me, if it were an option, I would.  It isn't.

So, I think git-prune-packed was the answer here...
jdl
