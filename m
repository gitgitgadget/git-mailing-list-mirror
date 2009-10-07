From: Michael Harbeck <michael_harbeck@arcor.de>
Subject: Question: Odd merging behaviour with copied/moved files
Date: Wed, 7 Oct 2009 08:52:43 +0000 (UTC)
Message-ID: <loom.20091007T104139-315@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 07 11:27:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvSnz-0004pM-K4
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 11:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197AbZJGJZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 05:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757101AbZJGJZy
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 05:25:54 -0400
Received: from lo.gmane.org ([80.91.229.12]:56829 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756694AbZJGJZx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 05:25:53 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MvSlc-0003Zz-LK
	for git@vger.kernel.org; Wed, 07 Oct 2009 11:25:04 +0200
Received: from dslb-088-064-253-218.pools.arcor-ip.net ([88.64.253.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 11:25:04 +0200
Received: from michael_harbeck by dslb-088-064-253-218.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 11:25:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 88.64.253.218 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3) Gecko/20090910 Ubuntu/9.04 (jaunty) Shiretoko/3.5.3 GTB5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129642>

Hello,

I'd just had the following situation:
A repository with a file: File1

A clone of this repository.
I made some changes to File1 in this repository and checked them in

Now someone decide to to rename and copy the File1 in the first repository and
checked those changes in. Now there is no File1 any more in the first repository.

After a while I pulled from this first repository. My changes are only merged in
one file! I think this behavior is strange.

In the second case its also strange, that if there is a copy in the first
repository, after a pull my changes in the copied file are also missing.

Is there a possibility to get warned about these situations, or better is there
an automatic way to merge my changes to both pulled files?

Thanks,

Michael
