From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH] make file merging respect permissions
Date: Sun, 24 Apr 2005 07:46:07 -0500
Message-ID: <1114346767.4997.2.camel@mulgrave>
References: <1114280570.5068.5.camel@mulgrave>
	 <Pine.LNX.4.58.0504231311300.2344@ppc970.osdl.org>
	 <1114292680.4799.4.camel@mulgrave>  <20050423230238.GD13222@pasky.ji.cz>
	 <1114298490.5264.10.camel@mulgrave>
	 <Pine.LNX.4.58.0504231759010.2344@ppc970.osdl.org>
	 <1114317771.4980.7.camel@mulgrave>
	 <Pine.LNX.4.58.0504232153500.15879@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 14:41:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPgQV-0006Aw-2g
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 14:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVDXMqV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 08:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVDXMqV
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 08:46:21 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:8933 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262321AbVDXMqS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 08:46:18 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3OCk9A27305;
	Sun, 24 Apr 2005 08:46:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504232153500.15879@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-23 at 21:55 -0700, Linus Torvalds wrote:
> Well, I actually ended up editing the line numbers manually and already 
> pushed out the previous one, so you might want to double-check that my 
> current tree matches yours.

Just to get closure on this, I went over all the parts of patch
generation, and the culprit turns out to be emacs.  Apparently its diff
mode (which I never thought to investigate how to use) does these re-
writes ... no idea why, but the problem goes away if I strip out the
extraneous pieces in fundamental-mode.  It's never given me this trouble
before ... I think the diff I'm producing must be confusing it somehow.

James


