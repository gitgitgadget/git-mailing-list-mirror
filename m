From: Jan Engelhardt <jengelh@medozas.de>
Subject: Fetch by SHA missing
Date: Tue, 5 Oct 2010 21:37:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1010052136280.21719@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 21:37:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3DKS-0005Tk-PO
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 21:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238Ab0JEThZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 15:37:25 -0400
Received: from borg.medozas.de ([188.40.89.202]:39242 "EHLO borg.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755881Ab0JEThV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 15:37:21 -0400
Received: by borg.medozas.de (Postfix, from userid 25121)
	id D4910F0C32921; Tue,  5 Oct 2010 21:37:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by borg.medozas.de (Postfix) with ESMTP id BA7E464E2
	for <git@vger.kernel.org>; Tue,  5 Oct 2010 21:37:19 +0200 (CEST)
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158228>

Hi,


it is possible to select single heads/tags for download, but this does 
not work with SHA IDs as of 1.7.1.

$ git fetch linus 3c06806e690885ce978ef180c8f8b6f8c17fb4b4:x
fatal: Couldn't find remote ref 3c06806e690885ce978ef180c8f8b6f8c17fb4b4
$ git fetch linus refs/heads/master
remote: Counting objects: 1254, done.
remote: Compressing objects: 100% (234/234), done.
remote: Total 709 (delta 562), reused 602 (delta 475)
Receiving objects: 100% (709/709), 112.41 KiB, done.
Resolving deltas: 100% (562/562), completed with 212 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
 * branch            master     -> FETCH_HEAD
