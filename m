From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 14:41:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060706055729.GA12512@admingilde.org> <87k66p8jee.fsf@mid.deneb.enyo.de>
 <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <87fyh1ncm0.fsf@mid.deneb.enyo.de> <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
 <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 14:42:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2SPv-0006Eg-Hj
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 14:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWGQMlh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 08:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWGQMlh
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 08:41:37 -0400
Received: from mail.gmx.de ([213.165.64.21]:18816 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750765AbWGQMlh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jul 2006 08:41:37 -0400
Received: (qmail invoked by alias); 17 Jul 2006 12:41:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp006) with SMTP; 17 Jul 2006 14:41:35 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Florian Weimer <fw@deneb.enyo.de>
In-Reply-To: <87d5c4ajlu.fsf@mid.deneb.enyo.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23969>

Hi,

On Mon, 17 Jul 2006, Florian Weimer wrote:

> * Alex Riesen:
> 
> > It is not Cygwin really. It's windows. You can't rename or delete an
> > open or mmapped file in that thing.
> 
> And GIT's workaround is to read the whole file into memory and close
> it after that?  Uh-oh.

If you have a better idea (which does not make git source code ugly), go 
ahead, write a patch.

But note that we usually use the whole contents of the mmap()ed file 
anyway.

Ciao,
Dscho
