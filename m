From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Make generated MSVC solution file open from
	Windows Explorer
Date: Fri, 25 Sep 2009 15:05:10 -0700
Message-ID: <20090925220510.GY14660@spearce.org>
References: <4ABB84F4.7080403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mstormo@gmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 00:05:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrIum-0006Vl-78
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 00:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbZIYWFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 18:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbZIYWFI
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 18:05:08 -0400
Received: from george.spearce.org ([209.20.77.23]:53608 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbZIYWFH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 18:05:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DDEBB38151; Fri, 25 Sep 2009 22:05:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4ABB84F4.7080403@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129125>

Sebastian Schuberth <sschuberth@gmail.com> wrote:
> From c6d29a2d243647bb2877eb2114938ae20c8e56e5 Mon Sep 17 00:00:00 2001
> From: Sebastian Schuberth <sschuberth@gmail.com>
> Date: Thu, 24 Sep 2009 15:52:25 +0200
> Subject: [PATCH 1/2] Make generated MSVC solution file open from Windows Explorer
>
> In order to be able to open the generated solution file by double-clicking it
> in Windows Explorer, all project files need to use DOS line-endings and a
> comment about the Visual Studio version needs to be added to the header of the
> solution file. This also fixes the icon that is displayed for the solution file
> in Windows Explorer.
> Note that opening the solution file from a running instance of Visual Studio
> already worked before.

Something is wrong with both patches; neither applies.  It looks
to be an issue with whitespace, like context lines are gaining an
extra space at the start of the line.

-- 
Shawn.
