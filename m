From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Filemode is a nuisance
Date: Wed, 04 May 2011 20:20:35 -0700
Message-ID: <86k4e5al4s.fsf@red.stonehenge.com>
References: <5B76586FBEB246BDA2F097E21C78E881@rowanlewis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rowan Lewis <me@rowanlewis.com>
X-From: git-owner@vger.kernel.org Thu May 05 05:20:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHp7a-0002Fe-7e
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 05:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848Ab1EEDUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 23:20:39 -0400
Received: from lax-gw02.mailroute.net ([199.89.0.102]:46595 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752755Ab1EEDUj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 23:20:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by lax-gw02.mroute.net (Postfix) with ESMTP id D1E571DEE0A;
	Thu,  5 May 2011 03:20:36 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw02.mroute.net (Postfix) with ESMTP id 377F11DEDD1;
	Thu,  5 May 2011 03:20:36 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 28E7E5869; Wed,  4 May 2011 20:20:36 -0700 (PDT)
x-mayan-date: Long count = 12.19.18.6.3; tzolkin = 5 Akbal; haab = 11 Uo
In-Reply-To: <5B76586FBEB246BDA2F097E21C78E881@rowanlewis.com> (Rowan Lewis's
	message of "Thu, 5 May 2011 09:38:03 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172790>

>>>>> "Rowan" == Rowan Lewis <me@rowanlewis.com> writes:

Rowan> However, one problem still remains. Our projects are often cloned
Rowan> onto a large variety of computer environments, from Linux servers
Rowan> to OSX and Windows desktops.

And then installed, how?

git-clone is *not* meant as a deployment tool.  It is meant to create
work dirs for editing and committing.

If you want to deploy, write the proper deploy tool that sets the permissions.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
