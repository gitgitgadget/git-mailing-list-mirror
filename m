From: Wolfgang Denk <wd@denx.de>
Subject: git cvsimport?
Date: Wed, 28 Sep 2005 14:40:29 +0200
Message-ID: <20050928124029.1BF6D352B7B@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Sep 28 14:43:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKbFJ-0004Qx-Mi
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 14:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbVI1Mk5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 08:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVI1Mk5
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 08:40:57 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:46794 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750905AbVI1Mk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 08:40:57 -0400
Received: from fwd28.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1EKbEx-0007jR-03; Wed, 28 Sep 2005 14:40:51 +0200
Received: from denx.de (Tt4DxOZFreyfMXuZ5BVDYCZ36dh6tH5WRYObcdOtDdl+AivREpsncq@[84.150.99.17]) by fwd28.sul.t-online.de
	with esmtp id 1EKbEi-0zSQi00; Wed, 28 Sep 2005 14:40:36 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP id 431A642B5F
	for <git@vger.kernel.org>; Wed, 28 Sep 2005 14:40:35 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 1BF6D352B7B
	for <git@vger.kernel.org>; Wed, 28 Sep 2005 14:40:29 +0200 (MEST)
To: git@vger.kernel.org
X-ID: Tt4DxOZFreyfMXuZ5BVDYCZ36dh6tH5WRYObcdOtDdl+AivREpsncq@t-dialin.net
X-TOI-MSGID: e54fd114-6e3e-4490-9f78-bc334f24ee02
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9428>


I have problems importing a CVS repository:

-> git cvsimport -v -d :pserver:denx@cvs.semihalf.com:/cvs -C /home/git/duts duts
cvs_direct initialized to CVSROOT /cvs
cvs rlog: Logging duts
cvs rlog: Logging duts/core
NOTICE: used alternate strip path /home/cvs/duts/core/duts
DONE; creating master branch
cp: cannot stat `/home/git/duts/.git/refs/heads/origin': No such file or directory
usage: git-read-tree (<sha> | -m [-u | -i] <sha1> [<sha2> [<sha3>]])
checkout failed: 256
-> git --version
git version 0.99.7

Am I doing anything wrong here?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Mandrell: "You know what I think?"
Doctor:   "Ah, ah that's a catch question. With a brain your size you
          don't think, right?"
                - Dr. Who
