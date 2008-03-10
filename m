From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Remotes order in "git remote update"
Date: Mon, 10 Mar 2008 12:11:51 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803101211000.3975@racer.site>
References: <2008-03-09-11-22-34+trackit+sam@rfc1149.net> <7vbq5op4gt.fsf@gitster.siamese.dyndns.org> <2008-03-09-12-21-35+trackit+sam@rfc1149.net> <alpine.LSU.1.00.0803092148480.3975@racer.site> <7vbq5nm8k1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 12:12:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYfvf-0004Ti-2q
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 12:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbYCJLLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 07:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbYCJLLs
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 07:11:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:46681 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750906AbYCJLLr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 07:11:47 -0400
Received: (qmail invoked by alias); 10 Mar 2008 11:11:46 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp049) with SMTP; 10 Mar 2008 12:11:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+PBLJweXOPYNBj1qzGpzHVeJkhP/nfxoxZEFWMeo
	Ju765IhPT7QTU4
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbq5nm8k1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76718>

Hi,

On Sun, 9 Mar 2008, Junio C Hamano wrote:

> We _might_ want to start guaranteeing some orders by documenting, but I 
> do not think it is necessary.  Does "git config" and "git remote" code 
> even guarantee the order the newly added ones are stored in the 
> $GIT_DIR/config file, and is it by design and specified in the 
> documentation, or it is by accident and happens to be the way the code 
> is written?

git_config_set() appends to the end of the config if the section it tries 
to edit did not exist yet.  However, this is just an implementation 
detail, no design decision.

Ciao,
Dscho
