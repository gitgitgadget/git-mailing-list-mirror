From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: Annoated tag not found on git describe
Date: Wed, 27 Oct 2010 21:55:35 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1010272154210.23548@obet.zrqbmnf.qr>
References: <alpine.LNX.2.01.1010271957520.28381@obet.zrqbmnf.qr> <4CC86D42.20008@debugon.org> <4CC87C61.9060806@debugon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Wed Oct 27 21:55:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBC62-0000v8-5P
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 21:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126Ab0J0Tzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 15:55:37 -0400
Received: from borg.medozas.de ([188.40.89.202]:40878 "EHLO borg.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093Ab0J0Tzg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 15:55:36 -0400
Received: by borg.medozas.de (Postfix, from userid 25121)
	id 934A7F0C32A90; Wed, 27 Oct 2010 21:55:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by borg.medozas.de (Postfix) with ESMTP id 89EF064E3;
	Wed, 27 Oct 2010 21:55:35 +0200 (CEST)
In-Reply-To: <4CC87C61.9060806@debugon.org>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160119>


On Wednesday 2010-10-27 21:24, Mathias Lafeldt wrote:
>>> in the linux-manpages repository at 
>>> git://git.kernel.org/pub/scm/docs/man-pages/man-pages , running git 
>>> describe on the current HEAD (8482c7b836) produces
>>>
>>> fatal: No annotated tags can describe 
>>> '8482c7b836a66f874e7dfea9c35fee4a82ad817b'.
>>> However, there were unannotated tags: try --tags.
>
>Forget about my first answer.
>
>git-describe shows the most recent tag that is reachable from a commit, but
>80786722b116f5002c28e9e0200044f825b236f6 isn't reachable when your HEAD is
>at 8482c7b836a66f874e7dfea9c35fee4a82ad817b.

Ah damn, I jumped around with git checkout before, creating detached heads.
All right, false alarm, but thanks for the heads up.
