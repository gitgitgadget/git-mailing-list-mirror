From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: renaming question
Date: Sun, 19 Aug 2007 20:16:02 +0200
Message-ID: <87vebbo0f1.fsf@mid.deneb.enyo.de>
References: <03a701c7e28a$87914fc0$0600a8c0@ze4427wm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 19 20:16:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMpKC-00086X-2M
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 20:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbXHSSQG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 14:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbXHSSQF
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 14:16:05 -0400
Received: from mail.enyo.de ([212.9.189.167]:4286 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527AbXHSSQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 14:16:05 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1IMpJj-0003WA-6H
	for git@vger.kernel.org; Sun, 19 Aug 2007 20:16:03 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1IMpJi-0003Ka-5v
	for git@vger.kernel.org; Sun, 19 Aug 2007 20:16:02 +0200
In-Reply-To: <03a701c7e28a$87914fc0$0600a8c0@ze4427wm> (Aaron Gray's message
	of "Sun, 19 Aug 2007 18:58:20 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56134>

* Aaron Gray:

> I have a very large C source project that I am converting from C to C++.
>
> Is it posssible to track changes with renamed files in GIT ?

You don't need to rename the files if you compile them using g++.  If
you still want to rename them, most history-related GIT commands
accept an -M switch which enables rename ("move") detection.
