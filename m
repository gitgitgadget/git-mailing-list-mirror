From: walt <wa1ter@myrealbox.com>
Subject: Re: [ANNOUNCE] GIT 0.99.9i aka 1.0rc2
Date: Tue, 15 Nov 2005 15:48:58 -0800
Organization: none
Message-ID: <Pine.NEB.4.63.0511151539360.12158@x9.ybpnyarg>
References: <7vr79isfy9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511150715390.17817@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 00:54:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcAbo-0001t6-9f
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 00:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbVKOXxA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 18:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbVKOXxA
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 18:53:00 -0500
Received: from main.gmane.org ([80.91.229.2]:53640 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965088AbVKOXxA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 18:53:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EcAZx-0001Hi-4T
	for git@vger.kernel.org; Wed, 16 Nov 2005 00:51:09 +0100
Received: from adsl-69-234-227-15.dsl.irvnca.pacbell.net ([69.234.227.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Nov 2005 00:51:09 +0100
Received: from wa1ter by adsl-69-234-227-15.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Nov 2005 00:51:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-227-15.dsl.irvnca.pacbell.net
In-Reply-To: <Pine.LNX.4.64.0511150715390.17817@x2.ybpnyarg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11973>

On Tue, 15 Nov 2005, walt wrote:

> On Mon, 14 Nov 2005, Junio C Hamano wrote:
>
> > I think the source-tree-wise almost everything is done except:
> >  - http-fetch file descriptor leak fix...

> So, you're saying that you have *not* fixed it?...

I just confirmed the good news on NetBSD.  Out of curiosity I did
this test:  I cg-updated and reinstalled cogito, which did *not*
fix the too-many-open-files error.  Then I cg-updated and rebuilt
git which *did* fix the error.  Clearly, something you committed
in the last two days has fixed this problem.  Dunno what you did,
but thanks :o)
