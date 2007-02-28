From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Memory overrun in http-push.c
Date: Wed, 28 Feb 2007 17:36:43 +0100
Message-ID: <87tzx6i6hw.fsf@mid.deneb.enyo.de>
References: <20070228151516.GC57456@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 17:59:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMS95-0002Sn-JT
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 17:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933140AbXB1Q7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 11:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933142AbXB1Q7N
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 11:59:13 -0500
Received: from mail.enyo.de ([212.9.189.167]:4716 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933140AbXB1Q7M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 11:59:12 -0500
X-Greylist: delayed 1308 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Feb 2007 11:59:12 EST
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1HMRnv-00062e-5Q
	for git@vger.kernel.org; Wed, 28 Feb 2007 17:37:23 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.63)
	(envelope-from <fw@deneb.enyo.de>)
	id 1HMRnH-0004SP-MB
	for git@vger.kernel.org; Wed, 28 Feb 2007 17:36:43 +0100
In-Reply-To: <20070228151516.GC57456@codelabs.ru> (Eygene Ryabinkin's message
	of "Wed, 28 Feb 2007 18:15:17 +0300")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40967>

* Eygene Ryabinkin:

> Spotted the memory overrun in the http-push.c. Exists at least in
> 1.5.0.x, not sure about latest development branch. The patch is
> attached.

Is this issue security-relevant?  After all, the misplaced pointer is
dereferenced and written to.
