From: roylee17 <roylee17@gmail.com>
Subject: Does cloning a shallow repo require special setting in the cloned
 one?
Date: Wed, 25 Feb 2009 19:49:06 -0800 (PST)
Message-ID: <1235620146513-2387799.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 04:50:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcXGd-0004SF-Tm
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 04:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbZBZDtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 22:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbZBZDtJ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 22:49:09 -0500
Received: from kuber.nabble.com ([216.139.236.158]:52572 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbZBZDtI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 22:49:08 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LcXFC-0002v1-Gq
	for git@vger.kernel.org; Wed, 25 Feb 2009 19:49:06 -0800
X-Nabble-From: roylee17@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111521>


Hi,

I have a question about cloning shallow repo.

$ git clone --depth 1 git://git2.kernel.org/pub/scm/git/git.git git-shallow
ok, 'git log' gives a 2-revision history.

$ git clone git://git2.kernel.org/pub/scm/git/git.git git-full
'git log' gives a full history

$ git clone --depth 1 git-full git-shallow2
'git log' still gives a full history

Why can't I clone a shallow repo from the git-full?
Does it requires some settings in the git-full repo?

Regards,
Roy
Roy
-- 
View this message in context: http://n2.nabble.com/Does-cloning-a-shallow-repo-require-special-setting-in-the-cloned-one--tp2387799p2387799.html
Sent from the git mailing list archive at Nabble.com.
