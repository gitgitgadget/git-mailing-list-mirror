From: Kacper <kacper.gazda@gmail.com>
Subject: Two versions of a project in one GIT repository
Date: Thu, 7 Jan 2010 17:06:34 -0800 (PST)
Message-ID: <1262912794001-4269785.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 02:06:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT3JJ-00023F-6E
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 02:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566Ab0AHBGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 20:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754556Ab0AHBGf
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 20:06:35 -0500
Received: from kuber.nabble.com ([216.139.236.158]:55543 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab0AHBGe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 20:06:34 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1NT3JC-0001XA-0G
	for git@vger.kernel.org; Thu, 07 Jan 2010 17:06:34 -0800
X-Nabble-From: Kacper <kacper.gazda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136404>


Hi all,

I have two versions of one project in one local git repository. I have to
commit this repository into 2 remote repositories, one for each version;

LOCAL GIT(V1/V2) -> REMOTE GIT(V1), REMOTE GIT(V2)

I have some files in the LOCAL GIT repository which should only go to REMOTE
GIT(V1) and other should only go to REMOTE GIT(V2). Now I commit full local
repository to both remotes. Can I only commit some files to REMOTE1?

I need to have both version of the project in one repository, but would like
to have an options to divide history a bit. I do not think that any
branching can help as then I would have to make the same changes to both
branches mostly. Most of the code, 90% of the code is the same for VER 1 and
VER 2. New code is usually the same for both versions.

THANK YOU,

Kacper

-- 
View this message in context: http://n2.nabble.com/Two-versions-of-a-project-in-one-GIT-repository-tp4269785p4269785.html
Sent from the git mailing list archive at Nabble.com.
