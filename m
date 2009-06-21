From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Confusion using git on svn server
Date: Sun, 21 Jun 2009 11:32:54 +0200
Message-ID: <87ws763pa1.fsf@mid.deneb.enyo.de>
References: <4A3D4665.9040003@gmail.com> <87zlc258nj.fsf@mid.deneb.enyo.de>
	<4A3DF8BE.2050504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Stigler <matthieu.stigler@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 11:33:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIJQo-0003lH-PW
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 11:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbZFUJcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 05:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbZFUJcy
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 05:32:54 -0400
Received: from mail.enyo.de ([212.9.189.167]:47433 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbZFUJcx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 05:32:53 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1MIJPz-0008AZ-6X; Sun, 21 Jun 2009 11:32:55 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1MIJPy-0002tn-RS; Sun, 21 Jun 2009 11:32:54 +0200
In-Reply-To: <4A3DF8BE.2050504@gmail.com> (Matthieu Stigler's message of "Sun,
	21 Jun 2009 11:09:18 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121977>

* Matthieu Stigler:

> So I just added a minor third commit in order to remove the two
> first. Is there a better way to do than this workaround? Something
> with git rebase --onto (two last?)

If you want to remove the last two commits, you can use "git reset
HEAD^^".  This moves your working copy (and the associated master
branch) back in time.
