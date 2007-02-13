From: Yann Dirson <ydirson@altern.org>
Subject: Re: stgit "unknown user details" bug?
Date: Tue, 13 Feb 2007 08:35:51 +0100
Message-ID: <20070213073551.GT5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <200702130434.l1D4YmrA010122@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: "Adam J. Richter" <adam@yggdrasil.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 08:37:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGsEX-0003Hh-2o
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 08:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbXBMHhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 02:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbXBMHhP
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 02:37:15 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:56423 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbXBMHhO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 02:37:14 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id B56C127962;
	Tue, 13 Feb 2007 08:37:12 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id E6AF41F084; Tue, 13 Feb 2007 08:35:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200702130434.l1D4YmrA010122@freya.yggdrasil.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39502>

Hi Adam,

On Tue, Feb 13, 2007 at 12:34:48PM +0800, Adam J. Richter wrote:
> 	I also have an stgit tree of the kernel.  This one has the
> local modifications in stgit.  I just upgraded from stgit 0.11 to
> 0.12, upgraded the git kernel tree from 2.6.20 to 2.6.20-git7, and
> tried to pull from the updated git tree to the stgit tree, using the
> new stgit 0.12.  stgit refused to apply the first local patch,
> complaining "stg pull: unknown user details."

This is a known issue, which is reported in the StGit bugtracker as
https://gna.org/bugs/?8452
StGit should surely use the same info as git does.

Best regards,
-- 
Yann.
