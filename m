From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git log and utf-u in filenames
Date: Fri, 26 Sep 2008 08:33:11 +0200
Message-ID: <20080926063311.GA4939@blimp.localhost>
References: <20080925215002.GA30810@kodama.kitenet.net> <20080925224354.GA6072@kodama.kitenet.net> <m3fxnn3ji6.fsf@localhost.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 08:34:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj6uX-0002m3-UM
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 08:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbYIZGda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 02:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbYIZGda
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 02:33:30 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:60285 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbYIZGd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 02:33:29 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8BE81ooUf
Received: from tigra.home (Fafb0.f.strato-dslnet.de [195.4.175.176])
	by post.webmailer.de (mrclete mo4) (RZmta 17.4)
	with ESMTP id h045a6k8Q4AHy8 ; Fri, 26 Sep 2008 08:33:25 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id D106C277AE;
	Fri, 26 Sep 2008 08:33:24 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id AE6B136D1E; Fri, 26 Sep 2008 08:33:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3fxnn3ji6.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96832>

Jakub Narebski, Fri, Sep 26, 2008 01:15:58 +0200:
> 
> Well, in gitweb we could use '-z' option for git-diff-tree and git-ls-tree,
> but it has its disadvantages, like having to do actual parsing record after
> record instead of simplys splitting outout on end of line ("\n") characters.
> 

How about simply splitting output on end of line ("\0" NUL) characters?
The "\n" NL you refer to is just as EOR as NUL.
