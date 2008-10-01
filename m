From: Raphael Zimmerer <killekulla@rdrz.de>
Subject: Re: [PATCH] git grep: Add "-Z/--null" option as in GNU's grep.
Date: Wed, 1 Oct 2008 17:11:14 +0200
Message-ID: <20081001151114.GB20659@rdrz.de>
References: <1222816390-9141-1-git-send-email-killekulla@rdrz.de> <20080930231619.GR21310@spearce.org> <20080930234157.GA1453@rdrz.de> <alpine.DEB.1.00.0810011514530.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081001145207.GW21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:12:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl3NO-0003sQ-C3
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 17:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbYJAPLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 11:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752835AbYJAPLR
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 11:11:17 -0400
Received: from rdrz.de ([217.160.107.209]:39833 "HELO rdrz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752173AbYJAPLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 11:11:16 -0400
Received: (qmail 20504 invoked by uid 1009); 1 Oct 2008 15:11:14 -0000
Content-Disposition: inline
In-Reply-To: <20081001145207.GW21310@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97232>

On Wed, Oct 01, 2008 at 07:52:07AM -0700, Shawn O. Pearce wrote:
> Its not like tools outside of Git are all that consistent.  GNU
> grep uses --null/-Z.  xargs and perl use -0.  find uses -print0.
> The human at the keyboard already has to navigate this rats nest
> between different tools, but within a tool (git) we should be as
> consistent as we can.

... and git-config uses --null/-z.

I will send an updated patch with --null/-z.

- Raphael
