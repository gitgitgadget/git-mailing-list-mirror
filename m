From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: chronologically listed tags?
Date: Tue, 24 Apr 2007 13:42:17 -0400
Message-ID: <20070424174217.GB5942@spearce.org>
References: <Pine.LNX.4.64.0704241924070.4438@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:42:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgP21-0007GQ-0z
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 19:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422838AbXDXRmW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 13:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422857AbXDXRmV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 13:42:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58082 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422838AbXDXRmV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 13:42:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HgP1b-0003rP-Tj; Tue, 24 Apr 2007 13:41:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D51B120FBAE; Tue, 24 Apr 2007 13:42:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704241924070.4438@castor.milkiway.cos>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45478>

Michael Dressel <MichaelTiloDressel@t-online.de> wrote:
> I would like to list tags chronologically. I failed to find out how to do 
> this using git or cogito directly. So I wrote the simplistic bash script 
> below. Is there a way more direct way?

for-each-ref is your friend:

	git for-each-ref --sort='taggerdate' refs/tags

-- 
Shawn.
