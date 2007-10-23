From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: git-annotate - leaking hundrets of megabytes
Date: Tue, 23 Oct 2007 22:12:18 +0200
Message-ID: <87k5pdvbdp.fsf@mid.deneb.enyo.de>
References: <471E28B2.7020508@imendio.com>
	<alpine.LFD.0.999.0710231108150.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 22:12:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkQ77-0005ap-3g
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 22:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbXJWUMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 16:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbXJWUMU
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 16:12:20 -0400
Received: from mail.enyo.de ([212.9.189.167]:2515 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbXJWUMT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 16:12:19 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1IkQ6r-0007dr-BJ
	for git@vger.kernel.org; Tue, 23 Oct 2007 22:12:17 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.68)
	(envelope-from <fw@deneb.enyo.de>)
	id 1IkQ6s-0004AU-94
	for git@vger.kernel.org; Tue, 23 Oct 2007 22:12:18 +0200
In-Reply-To: <alpine.LFD.0.999.0710231108150.30120@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 23 Oct 2007 11:14:41 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62156>

* Linus Torvalds:

> What git version do you have, or did you perhaps mean some other file or 
> other config that causes this?

I see it with Debian's 1:1.5.3.4-1 version, but also with dd8175f83c725.
In my case, it's a git-svn mirror of:

  svn://svn.debian.org/secure-testing/data/CVE/list

This is a very difficult file for git-annotate (and "svn blame") because
of its history and size.
