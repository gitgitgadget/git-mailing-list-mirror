From: Gabor Gombas <gombasg@digikabel.hu>
Subject: git svn clone failure
Date: Tue, 23 Mar 2010 23:28:40 +0100
Message-ID: <20100323222839.GA9567@twister.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 23:28:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuCad-0003eM-Uv
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 23:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab0CWW2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 18:28:42 -0400
Received: from relay02.digicable.hu ([92.249.128.188]:38076 "EHLO
	relay02.digicable.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab0CWW2m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 18:28:42 -0400
Received: from [94.21.201.208] (helo=twister.home)
	by relay02.digicable.hu with esmtpa
	id 1NuCaW-00033a-HJ for <git@vger.kernel.org>; Tue, 23 Mar 2010 23:28:40 +0100
Received: by twister.home (Postfix, from userid 1000)
	id 6030C6CE9; Tue, 23 Mar 2010 23:28:40 +0100 (CET)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Original: 94.21.201.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143055>

Hi,

Trying to clone an SVN repository I get:

fatal: ambiguous argument '907deda1c3ca2b42352e1ac2ce9f0dc57c177818^..db1341887792beec3ca68dc3196b40b231fdb545': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
rev-list 907deda1c3ca2b42352e1ac2ce9f0dc57c177818^..db1341887792beec3ca68dc3196b40b231fdb545: command returned error: 128

907deda1c is the very first commit on the SVN trunk, and it does not
have a parent:

$ git cat-file -p 907deda1c
tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
author loomis <loomis@60caac41-0bef-0310-ae6f-f8fb43407fe4> 1107528823 +0000
committer loomis <loomis@60caac41-0bef-0310-ae6f-f8fb43407fe4> 1107528823 +0000

add initial web pages and structure

git-svn-id: https://svn.lal.in2p3.fr/LCG/QWG/templates/trunk@3 60caac41-0bef-0310-ae6f-f8fb43407fe4

Gabor
