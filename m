From: Jens Axboe <axboe@suse.de>
Subject: killing a branch
Date: Tue, 10 Jan 2006 11:22:07 +0100
Message-ID: <20060110102207.GP3389@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 10 11:20:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwGbu-0002hp-4O
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 11:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWAJKUK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 05:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWAJKUK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 05:20:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27251 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750959AbWAJKUJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 05:20:09 -0500
Received: from [62.242.22.158] (helo=router.home.kernel.dk)
	by virtualhost.dk with esmtp (Exim 3.36 #1)
	id 1EwGbq-00041b-00
	for git@vger.kernel.org; Tue, 10 Jan 2006 11:20:10 +0100
Received: from nelson.home.kernel.dk ([192.168.0.33] helo=kernel.dk)
	by router.home.kernel.dk with esmtp (Exim 4.51)
	id 1EwGbo-0008QA-JQ
	for git@vger.kernel.org; Tue, 10 Jan 2006 11:20:08 +0100
Received: by kernel.dk (Postfix, from userid 1000)
	id 04B5B1D95AE; Tue, 10 Jan 2006 11:22:07 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14414>

Hi,

When I need to delete a branch from my git tree, I'm currently using
this (slooow) approach:

$ rm .git/refs/heads/branch-name
$ git prune

to rid myself of the branch and associated objects. Is there a faster
approach?

(please cc me, not on the list)

-- 
Jens Axboe
