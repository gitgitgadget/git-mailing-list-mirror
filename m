From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: git-changes-script to show inter tree changes
Date: Sun, 24 Apr 2005 07:48:12 -0500
Message-ID: <1114346892.4997.5.camel@mulgrave>
References: <1114281792.5068.10.camel@mulgrave>
	 <20050423230937.GF13222@pasky.ji.cz> <1114306762.4805.3.camel@mulgrave>
	 <20050424123621.GB1507@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 14:43:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPgSV-0006Lx-0M
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 14:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVDXMsZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 08:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVDXMsZ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 08:48:25 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:12005 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262322AbVDXMsW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 08:48:22 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3OCmCA27400;
	Sun, 24 Apr 2005 08:48:12 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050424123621.GB1507@pasky.ji.cz>
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-04-24 at 14:36 +0200, Petr Baudis wrote:
> Aha,  I thought this is based on the current gitlog.sh, sorry.

I think it is ... such a beast briefly appeared in the git tree, which
is where I got the skeleton from.

> For -R, you'd probably do
> 
> 	git log yourtree theothertree
> 
> (the range of changes between yourtree and theothertree, literally).

As long as that's a true what's in the other tree only, -L should appear
if you simply reverse the arguments.

James


