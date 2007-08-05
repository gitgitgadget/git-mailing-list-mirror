From: Pavel Roskin <proski@gnu.org>
Subject: Re: Some ideas for StGIT
Date: Sat, 04 Aug 2007 20:08:23 -0400
Message-ID: <1186272503.1948.21.camel@dv>
References: <1186163410.26110.55.camel@dv>
	 <200708031914.04344.andyparkins@gmail.com> <1186206085.28481.33.camel@dv>
	 <20070804055110.GP20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 02:08:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHTfb-0004vt-AT
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 02:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757686AbXHEAI2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 20:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759101AbXHEAI2
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 20:08:28 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:32936 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264AbXHEAI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 20:08:27 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1IHTi4-0000Mo-RX
	for git@vger.kernel.org; Sat, 04 Aug 2007 20:11:04 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1IHTfU-0000lr-0f; Sat, 04 Aug 2007 20:08:24 -0400
In-Reply-To: <20070804055110.GP20052@spearce.org>
X-Mailer: Evolution 2.10.3 (2.10.3-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54920>

On Sat, 2007-08-04 at 01:51 -0400, Shawn O. Pearce wrote:

> I agree with Andy.  Aside from the performance issues that I
> am currently having with a 55 patch series, "rebase -i" (and its
> predecessor script from Dscho) have been a major part of my toolkit,
> to the point that I really don't need something like StGIT on
> my system.
> 
> (Regarding the performance, cherry-picking 55 patches is
> slow, especially when many of them would apply trivially with
> git-diff|git-apply --index.  Be nice to improve that in 1.5.4.)

I understand that "git-rebase -i" is good for keeping local changes
up-to-date, but the real issue is managing the local patches so that
they can be enhanced to the point that they are ready for submission.

That includes such things as moving chunks between patches, editing
descriptions, joining patches together, sorting patches into groups by
their urgency and so on.  Keeping the patches up-to-date is just one
aspect.

Anyway, I'm going to give "git-rebase -i" a try.

-- 
Regards,
Pavel Roskin
