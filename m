From: Stephen Kelly <steveire@gmail.com>
Subject: Re: git interactive rebase 'consume' command
Date: Sun, 20 Jan 2013 20:13:12 +0100
Message-ID: <kdhfk6$von$1@ger.gmane.org>
References: <kdgtir$apt$1@ger.gmane.org> <7vk3r7llod.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 20 20:19:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx0Qo-0002Kx-2T
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 20:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343Ab3ATTNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 14:13:24 -0500
Received: from plane.gmane.org ([80.91.229.3]:45865 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221Ab3ATTNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 14:13:23 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Tx0Ko-00011d-76
	for git@vger.kernel.org; Sun, 20 Jan 2013 20:13:38 +0100
Received: from g231115249.adsl.alicedsl.de ([92.231.115.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 20:13:38 +0100
Received: from steveire by g231115249.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 20:13:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: g231115249.adsl.alicedsl.de
User-Agent: KNode/4.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214036>

Junio C Hamano wrote:
> Sorry, but I do not understand what you are trying to solve.
> 
> How can 1313a5e, which fixes misakes made in c2f62a3, come before
> that commit in the first place?

One scenario is something like this:

 Start with a clean HEAD (always a good idea :) )
 hack hack hack
 make multiple commits
 realize that a hunk you committed in an early patch belongs in a later one.
 use git rebase -i to fix it.


Is that more clear?

Thanks,

Steve.
