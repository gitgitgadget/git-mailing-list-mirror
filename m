From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Addition of "xmlto" to install documentation
Date: Sun, 14 Oct 2007 00:29:52 +0200
Message-ID: <20071013222952.GD2875@steel.home>
References: <47112DAA.5080701@web.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 00:30:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgpUj-0003Cn-P9
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 00:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbXJMW34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 18:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbXJMW34
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 18:29:56 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:60627 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbXJMW3z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 18:29:55 -0400
Received: from tigra.home (Fc8ce.f.strato-dslnet.de [195.4.200.206])
	by post.webmailer.de (fruni mo24) (RZmta 13.4)
	with ESMTP id v02d8cj9DKeUmN ; Sun, 14 Oct 2007 00:29:53 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 03D42277AE;
	Sun, 14 Oct 2007 00:29:52 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D331C56D22; Sun, 14 Oct 2007 00:29:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <47112DAA.5080701@web.de>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0sy8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60783>

Markus Elfring, Sat, Oct 13, 2007 22:42:18 +0200:
> 
> I have cloned the current Git release to my computer. I resolved all
> dependencies that were mentioned in the file "INSTALL". But when I've
> tried "make install install-doc" I got the message that "xmlto" was not
> found on my openSUSE 10.3 system. (I have installed it now.)
> Would you like to add this tool to the system requirements in the
> documentation?
> 

It is already there, in the same INSTALL file:

 - To build and install documentation suite, you need to have
   the asciidoc/xmlto toolchain.  Because not many people are
   inclined to install the tools, the default build target
   ("make all") does _not_ build them.
