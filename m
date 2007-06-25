From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Darcs
Date: Mon, 25 Jun 2007 13:36:00 +0200
Message-ID: <87vedcqna7.fsf@mid.deneb.enyo.de>
References: <cecbdd220706232232w77a609faxf0e6b2dc37f0d1f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 13:36:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2mra-00047M-5l
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 13:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbXFYLgH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 07:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbXFYLgG
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 07:36:06 -0400
Received: from mail.enyo.de ([212.9.189.167]:1747 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbXFYLgF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 07:36:05 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1I2mrS-00078y-6H
	for git@vger.kernel.org; Mon, 25 Jun 2007 13:36:02 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1I2mrQ-0002ov-T0
	for git@vger.kernel.org; Mon, 25 Jun 2007 13:36:00 +0200
In-Reply-To: <cecbdd220706232232w77a609faxf0e6b2dc37f0d1f4@mail.gmail.com> (Bu
	Bacoo's message of "Sun, 24 Jun 2007 07:32:52 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50891>

* Bu Bacoo:

> What do you think about darcs?

The UI is nice, but darcs is quite slow (even if you don't hit the
exponentional corner case in the merge algorithm).

My main gripe with darcs, and the prime reason why I'm moving away
from it, is its lack of support for software archaeology.  If you
haven't tagged a tree at some point, you'll face lots of trouble when
you try to restore something that resembles the tree you had back
then.  This is a direct consequence of the "heap of patches" approach,
but it's a real nuisance, and the benefits of the increased
flexibility don't make up for it, IMHO.
