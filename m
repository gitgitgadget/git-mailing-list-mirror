From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [RFH] plumber's puzzle
Date: Sun, 22 Apr 2007 22:30:08 +0200
Message-ID: <87mz10duen.fsf@mid.deneb.enyo.de>
References: <7v647ombi6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 22:30:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfihi-0007Op-WC
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 22:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030882AbXDVUaN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 16:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030908AbXDVUaN
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 16:30:13 -0400
Received: from mail.enyo.de ([212.9.189.167]:2784 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030882AbXDVUaL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 16:30:11 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1HfihF-0002Bn-QP
	for git@vger.kernel.org; Sun, 22 Apr 2007 22:30:09 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.63)
	(envelope-from <fw@deneb.enyo.de>)
	id 1HfihE-0001RX-NQ
	for git@vger.kernel.org; Sun, 22 Apr 2007 22:30:08 +0200
In-Reply-To: <7v647ombi6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 22 Apr 2007 12:53:37 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45272>

* Junio C. Hamano:

> Insights?

5520  write(1, "diff --git a/test.t b/test.t\n", 29) = -1 EBADF (Bad file descriptor)

It's not a fix, you just discard the output because you've closed
standard output.
