From: Eric Raymond <esr@snark.thyrsus.com>
Subject: Recent documentation patches, and an RFC on terminology
Date: Fri, 23 Apr 2010 17:54:48 -0400 (EDT)
Message-ID: <20100423215448.1EF5B479E92@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 23 23:55:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Qq7-00029A-Hj
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 23:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757547Ab0DWVyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 17:54:49 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:57829
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757425Ab0DWVyt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 17:54:49 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 1EF5B479E92; Fri, 23 Apr 2010 17:54:48 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145642>

I just sent two documentation patches to the list in quick succession.
In case they arrive out of order: the first, smaller one - modifying
only the git-status documentation - should be applied before the 
second one (distinguishing between "staging area" and "index"
throughout the documentation).

We may have an opportunity to improve on the term "staging area".  As
I reflect on it, I think replacing that with the term "depot" might
not be a bad idea.  In English this word has the general sense of
"warehouse", and the more specialized connotation of a place where
freight is temporarily held for transshipment, or where military
supplies and recruits are mustered before field deployment.  That is,
a depot is a particular kind of staging area.

Since these terms are so similar, why change?

One reason is that --depot would be a shorter and more graceful choice 
than --staging-area as a long-form option.  It has the same letter
count as "index", so changing command and option names to use it 
wouldn't add more typing.

Another reason is that "depot" is slightly more distant from normal
English vocabulary than "staging area" is.  When you need a word to 
co-opt as a technical term of art, thast's an advantage; it reduces 
the chances of collisions between term-of-art and normal usages.

If this proposal is accepted, I can very easly generate a patch to
implement it.  Teasing apart "index" from "staging area" was actual 
work, but now that the distinction has been made replacing the latter
would be trivial.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

The politician attempts to remedy the evil by increasing the very thing
that caused the evil in the first place: legal plunder.
	-- Frederick Bastiat
