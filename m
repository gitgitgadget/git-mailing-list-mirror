From: Chunlin Zhang <zhangchunlin@gmail.com>
Subject: When I merge, a binary file conflict,how can I select between 2 versions?
Date: Wed, 15 Dec 2010 08:00:08 +0000 (UTC)
Message-ID: <loom.20101215T084919-573@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 15 09:00:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSmHj-00011P-6z
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 09:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606Ab0LOIAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 03:00:21 -0500
Received: from lo.gmane.org ([80.91.229.12]:43475 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232Ab0LOIAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 03:00:20 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PSmHc-0000zt-1F
	for git@vger.kernel.org; Wed, 15 Dec 2010 09:00:20 +0100
Received: from 119.233.251.15 ([119.233.251.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 09:00:20 +0100
Received: from zhangchunlin by 119.233.251.15 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 09:00:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 119.233.251.15 (Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.04 (lucid) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163740>

The only way now I know is to replace the file with the version file I want in
working copy,and then git add and git commit.I think it is inconvenient.

When I use "git mergetool",it output:
'''
Merging the files: binary_example.png

Normal merge conflict for 'binary_example.png':
  {local}: modified
  {remote}: modified
Hit return to start merge resolution tool (meld): 
'''

Then I think if there is some command to select local or remote version file to
add more easier,because it is obviously git keep 2 version file.

Does anyone know it?

Thanks!
