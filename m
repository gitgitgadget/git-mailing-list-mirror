From: Sam Vilain <sam@vilain.net>
Subject: Re: Git / Subversion Interoperability
Date: Mon, 26 Mar 2007 15:04:13 +1200
Message-ID: <4607382D.9050200@vilain.net>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org> <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk> <20070323233036.77325e5a@athlon> <46044DF6.6070902@midwinter.com> <20070324065632.GE25863@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Steven Grimm <koreth@midwinter.com>,
	Christian Wiese <morfoh@opensde.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 05:04:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVfVe-0001gO-KX
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 05:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbXCZDEX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 23:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbXCZDEX
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 23:04:23 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:41337 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbXCZDEW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 23:04:22 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id D29FD13A381; Mon, 26 Mar 2007 15:04:19 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 36CD213A302;
	Mon, 26 Mar 2007 15:04:16 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <20070324065632.GE25863@spearce.org>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43108>

Shawn O. Pearce wrote:
> But its also hard for Git to export soup back.  That is, even once
> we've successfully decoded the soup we don't really have good
> submodule support, so we cannot (easily) take two different Git
> repositories (one per "slightly related" module) and export them
> under a single SVN name/revision-space.
>   

Sure you can: subprojects

Sam.
