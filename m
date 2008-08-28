From: Yann Dirson <ydirson@altern.org>
Subject: [stgit] understanding why --diff-opts was dropped from stg status
Date: Thu, 28 Aug 2008 23:43:38 +0200
Message-ID: <20080828214338.GJ4985@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:44:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYpIH-000835-6g
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244AbYH1Vnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 17:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbYH1Vnf
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:43:35 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:35137 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753911AbYH1Vne (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:43:34 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id E3E22196F5;
	Thu, 28 Aug 2008 23:43:33 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id C930C1975A;
	Thu, 28 Aug 2008 23:43:33 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id F378F1F0C2; Thu, 28 Aug 2008 23:43:38 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94185>

Hi Karl,

It's been quite some time I have been away from stgit developement, so
I have missed many things.  I just noticed that the post-0.14.3 stable
branch contains a change that adds tests for "stg status --diff-opts",
then one that removes that flag claiming it did not work.

Quite puzzled (since it is a feature I heavily used), I tried "git co
15ad449" expecting the tests added there would break... but it does
pass on my box.  What problems did you see ?

Best regards,
-- 
Yann
