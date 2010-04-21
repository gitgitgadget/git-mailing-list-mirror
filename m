From: maximilian attems <max@stro.at>
Subject: bug in name-rev on linux-2.6 repo?
Date: Wed, 21 Apr 2010 21:58:22 +0200
Message-ID: <20100421195822.GX10984@baikonur.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 21 22:07:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4gCI-0005ck-FQ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 22:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770Ab0DUUGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 16:06:53 -0400
Received: from baikonur.stro.at ([213.239.196.228]:40676 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990Ab0DUUGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 16:06:52 -0400
Received: by baikonur.stro.at (Postfix, from userid 1001)
	id EC07F5C00A; Wed, 21 Apr 2010 21:58:22 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145449>

~/src/linux-2.6$ git name-rev a1de02dccf906faba2ee2d99cac56799bda3b96a
 a1de02dccf906faba2ee2d99cac56799bda3b96a undefined


 git --version
 git version 1.7.0.4


~/src/linux-2.6$ git branch | grep ^*
* master

never happened to me before but don't seem to get ancestry of
that ext4 merge, can you check what is wrong there?
bug verified also on older git 1.6.5

thanks

-- 
maks
