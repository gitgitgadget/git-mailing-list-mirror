From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: comparing file contents in is_exact_match?
Date: Sun, 16 Jul 2006 11:05:43 +0200
Message-ID: <87fyh1ncm0.fsf@mid.deneb.enyo.de>
References: <20060706055729.GA12512@admingilde.org>
	<87k66p8jee.fsf@mid.deneb.enyo.de>
	<Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 16 11:05:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G22ZR-0000x2-1u
	for gcvg-git@gmane.org; Sun, 16 Jul 2006 11:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWGPJFq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 05:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWGPJFq
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 05:05:46 -0400
Received: from mail.enyo.de ([212.9.189.167]:30652 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1750710AbWGPJFp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Jul 2006 05:05:45 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1G22ZM-0005l5-Gn
	for git@vger.kernel.org; Sun, 16 Jul 2006 11:05:44 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.62)
	(envelope-from <fw@deneb.enyo.de>)
	id 1G22ZL-0006mi-QR
	for git@vger.kernel.org; Sun, 16 Jul 2006 11:05:43 +0200
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 8 Jul 2006 04:50:59 +0200
	(CEST)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23948>

* Johannes Schindelin:

> Hi,
>
> On Fri, 7 Jul 2006, Florian Weimer wrote:
>
>> -               s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
>> +               s->data = mmap(NULL, s->size, PROT_READ, MAP_SHARED, fd, 0);
>
> Be advised that this breaks setups with NO_MMAP, in particular most (all) 
> cygwin setups I know of.

Are these Cygwin setups running on top of the Windows 95 code base by
chance?
