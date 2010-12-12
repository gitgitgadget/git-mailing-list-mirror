From: "Albert Krawczyk" <pro-logic@optusnet.com.au>
Subject: Git SVN non-standard branch/tag/trunk layout
Date: Mon, 13 Dec 2010 08:35:34 +1100
Message-ID: <006c01cb9a44$8407d2f0$8c1778d0$@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 12 22:43:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRtht-0002l3-FW
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 22:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab0LLVno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 16:43:44 -0500
Received: from fallbackmx09.syd.optusnet.com.au ([211.29.132.242]:39866 "EHLO
	fallbackmx09.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750993Ab0LLVno (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Dec 2010 16:43:44 -0500
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Dec 2010 16:43:43 EST
Received: from mail08.syd.optusnet.com.au (mail08.syd.optusnet.com.au [211.29.132.189])
	by fallbackmx09.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id oBCLamcG018355
	for <git@vger.kernel.org>; Mon, 13 Dec 2010 08:36:48 +1100
Received: from AlbertDesktop (60-241-64-178.static.tpgi.com.au [60.241.64.178])
	(authenticated sender pro-logic)
	by mail08.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id oBCLZYjr024108
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Mon, 13 Dec 2010 08:35:36 +1100
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AcuaQggw1YZLFNpBTpSg1AUAG/k2Zg==
Content-Language: en-au
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163491>

Hi all,

One of the SVN repositories that I work with (and have a Git version of) has
recently implemented a tag/trunk/branch layout, and I'd like to update my
repository to correctly work with this layout. 

As far as I understand the standard layout for a SVN repo that supports
branching is 

SVR Root ----Trunk - folders/files
 \
  --Branch - folders/files
  \
   -Tag - folders/files

With each of those having the project contents

The SVN repo I am now faced with has the trunk/branch/tag folders on
selected folders in the tree.

Essentially instead of having one project per repo, there are multiple
projects in the repo. So the repo looks like this

---SVN Root --- Folder(Proj1) ---- Files
	\
	 ---- Folder(Proj2) --- Trunk - Files
	|	       \
	|		- Branch - Files
	|		|
	|		- Tag - ...
	|
	|- Proj3 - Files
	|- Proj4 - Trunk
		 |-Branch
		 | - Tag

The question is, is there a way I can get Git SVN to understand and
replicate this layout in a git repo? I don't mind if I have to import the
entire repo again into git. 

Thanks,
Albert
