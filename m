From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] built-in tar-tree and remote tar-tree
Date: Fri, 19 May 2006 23:56:03 +0200
Organization: At home
Message-ID: <e4let3$17u$1@sea.gmane.org>
References: <7v7j4ik1fr.fsf@assigned-by-dhcp.cox.net> <20060519214318.38240.qmail@web25910.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri May 19 23:56:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhCxC-0007DG-Qc
	for gcvg-git@gmane.org; Fri, 19 May 2006 23:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWESV4G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 17:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWESV4G
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 17:56:06 -0400
Received: from main.gmane.org ([80.91.229.2]:36003 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964855AbWESV4F (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 17:56:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FhCww-0007AR-JZ
	for git@vger.kernel.org; Fri, 19 May 2006 23:55:58 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 May 2006 23:55:58 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 May 2006 23:55:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20358>

Sven Ekman wrote:

> Is there a simple way to retrieve a single object or a
> list of objects _without_ any of their parents? If so
> one could retrieve the wanted commit and the
> corresponding tree and parse it on the client side to
> retrieve its descendents and commits.  If so, the
> number of roundtrips would be roughly proportional to
> the depth of the trees, which would probably still be
> acceptable.

Perhaps alternates file which points to _remote_ git repository, 
leaving all unused objects at remote directory, and needing constant
net access to said remote repository for almost all operations?

-- 
Jakub Narebski
Warsaw, Poland
