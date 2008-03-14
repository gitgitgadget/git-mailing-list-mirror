From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add MIME information to outgoing email
Date: Fri, 14 Mar 2008 09:46:01 -0400
Message-ID: <20080314134600.GA3968@coredump.intra.peff.net>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <20080313170016.GA3439@sigill.intra.peff.net> <2008-03-13-18-14-36+trackit+sam@rfc1149.net> <20080314132949.GC2932@coredump.intra.peff.net> <2008-03-14-14-40-22+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 14:47:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaAFA-0005kO-Mq
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 14:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbYCNNqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 09:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbYCNNqE
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 09:46:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3833 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbYCNNqD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 09:46:03 -0400
Received: (qmail 1415 invoked by uid 111); 14 Mar 2008 13:46:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Mar 2008 09:46:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2008 09:46:01 -0400
Content-Disposition: inline
In-Reply-To: <2008-03-14-14-40-22+trackit+sam@rfc1149.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77224>

On Fri, Mar 14, 2008 at 02:40:22PM +0100, Samuel Tardieu wrote:

> | Sorry, I don't have that commit. What repo is it in?
> 
> Junio's "next" branch.

Ah, sorry, for some reason I couldn't find it before. I must have
typo'd it.

Yes, it works fine for me:

$ git-format-patch a1eebf~1..a1eebf
0001-git.el-find-the-git-status-buffer-whatever-its-name.patch
$ head 0001*
From a1eebfb3a90b6c240afd1a32cfebe6ee5dbd72c5 Mon Sep 17 00:00:00 2001
From: =?utf-8?q?R=C3=A9mi=20Vanicat?= <vanicat@debian.org>
Date: Fri, 29 Feb 2008 19:28:19 +0100
Subject: [PATCH] git.el: find the git-status buffer whatever its name is
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

git-status used the buffer name to find git-status buffers, and that
can fail if the buffer has another name, for example when multiple


-Peff
