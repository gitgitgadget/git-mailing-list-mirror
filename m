From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [REGRESSION] git-gui
Date: Fri, 4 Apr 2008 13:02:01 +0200
Message-ID: <20080404110201.GA8298@fiberbit.xs4all.nl>
References: <007901c89590$a827f7c0$93a7c10a@LGE.NET> <57518fd10804030700r6de977f5p6f0418e6eaea2583@mail.gmail.com> <200804032304.17054.barra_cuda@katamail.com> <57518fd10804031615m5c299df6hf31de3c689e16521@mail.gmail.com> <20080404012723.GL10274@spearce.org> <20080404013356.GM10274@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Michele Ballabio <barra_cuda@katamail.com>,
	git@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Goddard Rosa <andre_rosa@lge.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Apr 04 13:11:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhjpd-00039f-EM
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 13:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbYDDLKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 07:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbYDDLKv
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 07:10:51 -0400
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:2353 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbYDDLKu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 07:10:50 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Apr 2008 07:10:50 EDT
Received: from fiberbit.xs4all.nl (fiberbit.xs4all.nl [213.84.224.214])
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id m34B21l1083690;
	Fri, 4 Apr 2008 13:02:07 +0200 (CEST)
	(envelope-from marco.roeland@xs4all.nl)
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.69)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1JhjgH-0002AN-JF; Fri, 04 Apr 2008 13:02:01 +0200
Content-Disposition: inline
In-Reply-To: <20080404013356.GM10274@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78800>

On Thursday April 3rd 2008 at 21:33 Shawn O. Pearce wrote:

> Hmm, maybe I should offer the patch.  :-)
> 
> --8>--
> Subject: [PATCH] git-gui: Switch keybindings for [ and ] to bracketleft and bracketright
> 
> Thanks to Michele Ballabio for the quick fix.
> This resolves the error introduced by c91ee2bd61.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

This solves the problem on Debian GNU/Linux 'sid', with Tcl/Tk version
8.5.1. So somehow the Linux implementation seems to be the problem, not
the Tcl/Tk version as such. Man keysyms here does list "bracketleft" and
"bracketright" but no direct symbols for '[' or ']'. Thanks!
-- 
Marco Roeland
