From: Sam Vilain <sam@vilain.net>
Subject: Re: Git / Subversion Interoperability
Date: Mon, 26 Mar 2007 15:06:51 +1200
Message-ID: <460738CB.2050707@vilain.net>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org> <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk> <20070323012422.GC17773@spearce.org> <Pine.LNX.4.64.0703230128330.4001@beast.quantumfyre.co.uk> <20070323103426.GA15923@diana.vm.bytemark.co.uk> <20070324064130.GC25863@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 05:07:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVfXv-0002iP-H0
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 05:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbXCZDG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 23:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933465AbXCZDG4
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 23:06:56 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:45061 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbXCZDGz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 23:06:55 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id BFED213A384; Mon, 26 Mar 2007 15:06:54 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 6750A13A342;
	Mon, 26 Mar 2007 15:06:51 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <20070324064130.GC25863@spearce.org>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43109>

Shawn O. Pearce wrote:
> That is not a bad idea at all.  We could easily do
>
>   svn:executable -> (mode & 0111);
>   svn:ignore -> .gitignore;
>
> I'm sure there are others, but they are the only two Karl mentioned,
> and that I know of off the top of my head.  ;-)
>
> Additional random properties could just be written out to .gitsvnprop
> in the parent directory.
>   

There are also the important properties "svk:merge" and "svnmerge",
which allow you to notate when a revision has an extra parent.  SVK
and/or svnmerge should then be able to use the extra merge information
without any extra work.  Additionally, people might want to push back
with these properties.

Sam.
