From: Chris Wedgwood <cw@f00f.org>
Subject: Re: Building git on Fedora
Date: Sun, 17 Apr 2005 16:35:01 -0700
Message-ID: <20050417233501.GA12950@taniwha.stupidest.org>
References: <4262F07D.4050007@adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 01:31:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJEV-00068q-LP
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVDQXfH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVDQXfH
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:35:07 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:22409 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261554AbVDQXfE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 19:35:04 -0400
Received: from pimout3-ext.prodigy.net (pimout3-ext.prodigy.net [207.115.63.102])
	by ylpvm29.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j3HNYSO2028025
	for <git@vger.kernel.org>; Sun, 17 Apr 2005 19:34:28 -0400
X-ORBL: [67.124.119.21]
Received: from taniwha.stupidest.org (adsl-67-124-119-21.dsl.snfc21.pacbell.net [67.124.119.21])
	by pimout3-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j3HNZ1xG096704;
	Sun, 17 Apr 2005 19:35:01 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 1A3D0115C859; Sun, 17 Apr 2005 16:35:01 -0700 (PDT)
To: jeff millar <wa1hco@adelphia.net>
Content-Disposition: inline
In-Reply-To: <4262F07D.4050007@adelphia.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 17, 2005 at 07:25:49PM -0400, jeff millar wrote:

> Here's a tidbit to enable git to compile on Fedora.  Add the
> following line to /etc/rc.d/rc.local...
>
>    ln -sf /lib/modules/`uname -r`/build/include/linux /usr/local/include/linux

I can't see why this should be needed.  What breaks without this?
