From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Confusion using git on svn server
Date: Mon, 22 Jun 2009 08:16:14 +0200
Message-ID: <877hz4ssi9.fsf@mid.deneb.enyo.de>
References: <4A3D4665.9040003@gmail.com> <87zlc258nj.fsf@mid.deneb.enyo.de>
	<4A3DF8BE.2050504@gmail.com> <87ws763pa1.fsf@mid.deneb.enyo.de>
	<fabb9a1e0906212304o2b61d081i4cf72300be8bd775@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Stigler <matthieu.stigler@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 08:16:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIcpM-0007m6-QN
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 08:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbZFVGQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 02:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZFVGQO
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 02:16:14 -0400
Received: from mail.enyo.de ([212.9.189.167]:59970 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbZFVGQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 02:16:13 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1MIcpD-0003ov-1v; Mon, 22 Jun 2009 08:16:15 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1MIcpC-0001oj-Gk; Mon, 22 Jun 2009 08:16:14 +0200
In-Reply-To: <fabb9a1e0906212304o2b61d081i4cf72300be8bd775@mail.gmail.com>
	(Sverre Rabbelier's message of "Mon, 22 Jun 2009 08:04:55 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122010>

* Sverre Rabbelier:

> It moves your tree only if you add --hard, although in case of a reverted
> revert it doesn't matter.

Well, this is part of the checkout/reset confusion.  Even without
--hard, reset changes where the working tree is located in the
history.  But it doesn't perform a checkout.

As you said, with a rever, this shouldn't matter.
