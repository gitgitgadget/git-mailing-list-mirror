From: Yann Dirson <ydirson@altern.org>
Subject: Re: stgit "unknown user details" bug?
Date: Tue, 13 Feb 2007 19:32:14 +0100
Message-ID: <20070213183214.GU5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <200702130434.l1D4YmrA010122@freya.yggdrasil.com> <b0943d9e0702130240x1822f882t4f0d1780647d98ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Adam J. Richter" <adam@yggdrasil.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 19:33:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH2TE-0004s6-Or
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbXBMSdh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbXBMSdh
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:33:37 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:38090 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbXBMSdh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:33:37 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 0AAF569B3;
	Tue, 13 Feb 2007 19:33:36 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 523471F084; Tue, 13 Feb 2007 19:32:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b0943d9e0702130240x1822f882t4f0d1780647d98ad@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39575>

BTW, I wondered why we need to store author and committer info in the
patch dir.  Shouldn't the info from the Git commit be authoritative ?

Also, a quick glance at the code lets me think those information are
only changed in a patch when explicit flags are given to various
commands.  Shouldn't we, in addition set committer to current user
during refresh, and possibly non-forwarding push ?

Best regards,
-- 
Yann.
