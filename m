From: dwitch@nan92-1-81-57-214-146.fbx.proxad.net (Yann Dirson)
Subject: Re: [PATCH 2/2] Look for a commit's parents in the standard way.
Date: Sun, 3 Sep 2006 21:36:50 +0200
Message-ID: <20060903193650.GA4914@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20060814165307.20350.63286.stgit@gandelf.nowhere.earth> <20060814165544.20350.41590.stgit@gandelf.nowhere.earth> <b0943d9e0608200343t517ec29dw2b6b49d9d69dbad5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 21:37:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJxmU-00009r-VO
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 21:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWICThA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 15:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWICThA
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 15:37:00 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:52448 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S932145AbWICTg7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Sep 2006 15:36:59 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id D876327642;
	Sun,  3 Sep 2006 21:36:57 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 0C7551F07D; Sun,  3 Sep 2006 21:36:50 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0608200343t517ec29dw2b6b49d9d69dbad5@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26374>

On Sun, Aug 20, 2006 at 11:43:22AM +0100, Catalin Marinas wrote:
> On 14/08/06, Yann Dirson <ydirson@altern.org> wrote:
> >This has the direct effect of taking info/grafts into account, since
> >ignoring it only causes confusion.
> 
> I don't know the difference but is there any between parsing the
> commit file and using git-rev-list --parents?

Yes, git-rev-list at least takes info/grafts into account.

> >+        self.__parents = split(_output_lines('git-rev-list --parents 
> >--max-count=1 %s' % id_hash)[0])[1:]
> 
> Instead of using the split() method, you could call
> _output_lines('git-rev-list --parents --max-count=1 %s' %
> id_hash)[0].split()[1:]. Maybe that's why they might deprecate the
> global split method.

Ah, OK.

Best regards,
-- 
Yann.

-- 
VGER BF report: U 0.500235
