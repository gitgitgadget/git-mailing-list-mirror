From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Confusion using git on svn server
Date: Sun, 21 Jun 2009 09:49:04 +0200
Message-ID: <87zlc258nj.fsf@mid.deneb.enyo.de>
References: <4A3D4665.9040003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 10:22:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIIK3-0001S3-4g
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 10:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbZFUIWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 04:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbZFUIWb
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 04:22:31 -0400
Received: from mail.enyo.de ([212.9.189.167]:49128 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbZFUIW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 04:22:29 -0400
X-Greylist: delayed 2005 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jun 2009 04:22:29 EDT
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1MIHnW-0005yV-5Z
	for git@vger.kernel.org; Sun, 21 Jun 2009 09:49:06 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1MIHnV-0004Ni-U4
	for git@vger.kernel.org; Sun, 21 Jun 2009 09:49:05 +0200
In-Reply-To: <4A3D4665.9040003@gmail.com> (Matthieu Stigler's message of "Sat,
	20 Jun 2009 22:28:21 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121972>

* Matthieu Stigler:

> My main concern is that in my git log, I have a commit and its
> "revert", will it be sent as two different commits to svn? I would
> love they are not sent at all as they represent a "neutral" operation.

They will be sent as a separate commits by default.

You can use "git rebase -i git-svn" to edit your local history before
submitting it, though.
