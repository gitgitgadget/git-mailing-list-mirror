From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Use _type constants instead of literal constants
Date: Sun, 02 Apr 2006 15:41:20 +0200
Organization: At home
Message-ID: <e0ok9m$oua$1@sea.gmane.org>
References: <20060402130051.GA2933@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Apr 02 15:41:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ2pd-0001nO-6j
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 15:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWDBNlR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 09:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWDBNlR
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 09:41:17 -0400
Received: from main.gmane.org ([80.91.229.2]:42726 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932338AbWDBNlQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 09:41:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FQ2pP-0001l6-6s
	for git@vger.kernel.org; Sun, 02 Apr 2006 15:41:15 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Apr 2006 15:41:15 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Apr 2006 15:41:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18268>

Peter Eriksen wrote:

> From: Peter Eriksen <s022018@student.dtu.dk>
> Date: Sun Apr 2 14:44:09 2006 +0200
> Subject: [PATCH] Use blob_, commit_, tag_, and tree_type throughout.
> 
> This replaces occurences of "blob", "commit", "tag", and "tree",
> where they're really used as type specifiers, which we already
> have defined global constants for.

Shouldn't the name of constant rather be e.g. instead of blob_type be
type_blob, and similarly for the rest of type constants?

-- 
Jakub Narebski
Warsaw, Poland
