From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] gitk: fix for "gitk <ambiguous-name> --"
Date: Wed, 4 Jul 2007 07:37:15 +0000
Message-ID: <20070704073715.31993.qmail@81358792d0c5f3.315fe32.mid.smarden.org>
References: <20070703202301.GA24071@informatik.uni-freiburg.de> <Pine.LNX.4.64.0707032248570.4071@racer.site> <alpine.LFD.0.98.0707031514160.9434@woody.linux-foundation.org> <Pine.LNX.4.64.0707032353330.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 09:37:02 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5zQ5-0005Pe-6b
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 09:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbXGDHg6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 03:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754334AbXGDHg6
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 03:36:58 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:57671 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754817AbXGDHg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 03:36:57 -0400
Received: (qmail 31994 invoked by uid 1000); 4 Jul 2007 07:37:15 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707032353330.4071@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51575>

On Tue, Jul 03, 2007 at 11:55:24PM +0100, Johannes Schindelin wrote:
> If you have an ambiguous ref, i.e. a file in the working directory bears
> the same name, you have to use "--" at the end to disambiguate ref from
> file. This works with "git rev-list". Make it work with gitk, too.
> 
> Noticed by Uwe Kleine-K??nig.

Not sure anymore why, but I patched differently
 http://article.gmane.org/gmane.comp.version-control.git/48102

Regards, Gerrit.
