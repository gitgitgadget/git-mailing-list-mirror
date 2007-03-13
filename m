From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git support for subprojects?
Date: Tue, 13 Mar 2007 11:51:27 -0400
Message-ID: <20070313155127.GB18890@spearce.org>
References: <OFD596829F.8C32CA61-ON8625729D.004F66DC-8625729D.00501D41@BJSERVICES.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke.Powell@bjservices.com
X-From: git-owner@vger.kernel.org Tue Mar 13 16:51:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR9Hi-0000Ob-Dk
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 16:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbXCMPvb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 11:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbXCMPvb
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 11:51:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55065 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbXCMPva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 11:51:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HR9HW-0007wH-Jt; Tue, 13 Mar 2007 11:51:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4F55220FBAE; Tue, 13 Mar 2007 11:51:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <OFD596829F.8C32CA61-ON8625729D.004F66DC-8625729D.00501D41@BJSERVICES.COM>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42125>

Luke.Powell@bjservices.com wrote:
> Say that I have projects A and B which both depend on another project Z. 
> Whenever I update one of those projects, I'd like to also update to the 
> latest version of Z in a subdirectory. Is there that kind of support for 
> these subprojects? If I'm not being clear, I'm talking about the kind of 
> support that is available in Subversion through svn:externals or something 
> analogous.

In the Git community the concept of a subproject is more powerful
than what you just described.  But we haven't implemented those
concepts yet in a released version (however there are prototypes
floating around for discussion).  ;-)

If all you want is an svn:externals type of hack, you can easily
write a wrapper script to cd into the subproject Z and run
`git pull`, merging in any recent changes from the upstream.

But we haven't automated that, as our concept of a subproject is
much more sophisticated and doesn't always mean update the subproject
to the latest version.

-- 
Shawn.
