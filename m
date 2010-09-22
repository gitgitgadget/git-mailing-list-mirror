From: Maaartin <grajcar1@seznam.cz>
Subject: Re: Folding commits together
Date: Wed, 22 Sep 2010 11:33:21 +0000 (UTC)
Message-ID: <loom.20100922T132318-104@post.gmane.org>
References: <loom.20100922T123419-101@post.gmane.org> <vpqsk12rpz4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 13:33:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyNa6-0007t3-12
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 13:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab0IVLdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 07:33:39 -0400
Received: from lo.gmane.org ([80.91.229.12]:37957 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417Ab0IVLdj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 07:33:39 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OyNZx-0007pe-65
	for git@vger.kernel.org; Wed, 22 Sep 2010 13:33:37 +0200
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 13:33:37 +0200
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 13:33:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.61)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156798>

Matthieu Moy <Matthieu.Moy <at> grenoble-inp.fr> writes:

> Which exact command did you type? Something like this should do it:
> 
> git rebase -i HEAD~3

I've tried nearly everything, starting with

git rebase -i d8e3842

which should be the just the same as HEAD~3. I retract the question, my editor 
keeps opening a wrong file, which I've just spotted by accident. The problem was 
caused by a git-cygwin-emacsclient-emacs interaction, rebase works nicely.
