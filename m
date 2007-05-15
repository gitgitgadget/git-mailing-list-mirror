From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Tue, 15 May 2007 23:49:52 +0200
Message-ID: <20070515214952.GQ19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070506150852.8985.98091.stgit@yoghurt> <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com> <20070515210801.GO19253@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0705151436g64e24a32r23c45c19f750082@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 23:51:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho4vM-0003QQ-Uf
	for gcvg-git@gmane.org; Tue, 15 May 2007 23:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbXEOVvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 17:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754857AbXEOVvL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 17:51:11 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:36963 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754401AbXEOVvL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 17:51:11 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E11435F004;
	Tue, 15 May 2007 23:51:09 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id A73351F161; Tue, 15 May 2007 23:49:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0705151436g64e24a32r23c45c19f750082@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47378>

On Tue, May 15, 2007 at 10:36:05PM +0100, Catalin Marinas wrote:
> I think it would be useful to have a version file (probably per
> branch) and just upgrade when a mismatch is detected (in the __init__
> function).

Sounds reasonable, but I'd rather keep that in the config file
(eg. branch.<name>.stgit.formatversion).

Best regards,
-- 
Yann.
