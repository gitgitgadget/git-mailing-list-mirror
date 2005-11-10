From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: CVSps fixed; git-cvsimport works, too
Date: Wed, 9 Nov 2005 20:41:06 -0500
Message-ID: <20051110014106.GA19835@pe.Belkin>
References: <20051101035148.GA11807@pe.Belkin> <20051109222634.GA19209@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cvsps@dm.cobite.com, David Mansfield <david@cobite.com>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Nov 10 02:43:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea1RN-00005v-Hn
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 02:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbVKJBlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 20:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVKJBlJ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 20:41:09 -0500
Received: from eastrmmtao05.cox.net ([68.230.240.34]:3060 "EHLO
	eastrmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751378AbVKJBlI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 20:41:08 -0500
Received: from localhost ([24.250.31.7]) by eastrmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051110014103.WHLY28234.eastrmmtao05.cox.net@localhost>;
          Wed, 9 Nov 2005 20:41:03 -0500
Received: from chris by localhost with local (Exim 4.43)
	id 1Ea1R4-0005AA-I1; Wed, 09 Nov 2005 20:41:06 -0500
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051109222634.GA19209@pe.Belkin>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11458>

On Wed, Nov 09, 2005 at 05:26:34PM -0500, Chris Shoemaker wrote:
> I could cut git-cvsimport some slack for failing to infer that file
> 'b' is also on the 'dev' branch, since I learned how hard that is when
> I taught CVSps to make that inference.  But completely missing a
> branch and all files added to it is not good.

Ok.  Whew, I'm glad to report that I was mistaken.  git-cvsimport
performs beautifully when given the new CVSps output.  Sorry for the
noise.

I'll change this then to an announcement that with that CVSps patch,
CVSps produces more accurate branch ancestry, and git-cvsimport can
correctly reproduce branch-of-a-branch histories.

On a related note, the new '-P' option doesn't behave exactly as I
expected.  You must provide the _full_ pathname to the input file
CVSps file.  If that's not a bug, it should at least be documented.

-chris
