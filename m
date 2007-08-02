From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: core.gitproxy and non-git protocols
Date: Thu, 2 Aug 2007 01:31:51 -0400
Message-ID: <20070802053151.GH20052@spearce.org>
References: <ee77f5c20708012221j4d75ff0dl8fbf16cdaf1401bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 07:32:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGTHz-0000hA-8c
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 07:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbXHBFb4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 01:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbXHBFb4
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 01:31:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42830 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbXHBFb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 01:31:56 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IGTHs-0002rT-Vr; Thu, 02 Aug 2007 01:31:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 83DB020FBAE; Thu,  2 Aug 2007 01:31:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <ee77f5c20708012221j4d75ff0dl8fbf16cdaf1401bd@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54515>

David Symonds <dsymonds@gmail.com> wrote:
> It'd be great if (a) the documentation could be fixed, or (b) the
> proxy-picking code could be at least extended to ssh:// protocols, and
> preferrably extended to defining custom protocols.

Did you try setting GIT_SSH envvar to point to a script that does
what you need?  I do this in one particular case...

-- 
Shawn.
