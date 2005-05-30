From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More gitweb queries..
Date: Mon, 30 May 2005 11:21:40 +0200
Message-ID: <20050530092140.GQ12290@cip.informatik.uni-erlangen.de>
References: <20050527203227.GA11139@cip.informatik.uni-erlangen.de> <20050529230240.GB12290@cip.informatik.uni-erlangen.de> <20050529231053.GD12290@cip.informatik.uni-erlangen.de> <20050529231621.GE12290@cip.informatik.uni-erlangen.de> <20050529234606.GF12290@cip.informatik.uni-erlangen.de> <20050529235630.GG12290@cip.informatik.uni-erlangen.de> <7vsm05bkps.fsf@assigned-by-dhcp.cox.net> <20050530013056.GH12290@cip.informatik.uni-erlangen.de> <7vmzqd4041.fsf@assigned-by-dhcp.cox.net> <20050530083653.GL12290@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 11:20:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcgQt-0007C4-Ci
	for gcvg-git@gmane.org; Mon, 30 May 2005 11:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVE3JV6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 05:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVE3JV6
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 05:21:58 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:34693 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261570AbVE3JVv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 05:21:51 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4U9LeS8011878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 May 2005 09:21:40 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4U9LekC011877;
	Mon, 30 May 2005 11:21:40 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20050530083653.GL12290@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
I also have to strip duplicate HEADs out. So we do the following:

run 0: kill dups

run 1: kill HEADs which are referenced in the history of other HEADs

run 2: do the merging (still don't know to what I should set the local
       HEAD to the 'left' or 'right' part. Maybe we should create temporary
       commit object so that 'merge-base' can better work on them?

	Thomas
