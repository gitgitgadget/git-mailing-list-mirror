From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: What happens if someone modifies repository without me knowing?
Date: Sun, 26 Sep 2010 23:23:22 +0300
Message-ID: <20100926202322.GA2995@LK-Perkele-V2.elisa-laajakaista.fi>
References: <i7o5rc$t3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
X-From: git-owner@vger.kernel.org Sun Sep 26 22:19:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzxhE-00035K-Fn
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 22:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453Ab0IZUSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 16:18:41 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:47680 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab0IZUSl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 16:18:41 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id D13B8EBDCA;
	Sun, 26 Sep 2010 23:18:38 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A03683CE99F; Sun, 26 Sep 2010 23:18:38 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id B2D8BE51A8;
	Sun, 26 Sep 2010 23:18:36 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <i7o5rc$t3$1@dough.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157257>

On Sun, Sep 26, 2010 at 09:07:29PM +0200, Manuel Reimer wrote:
> Hello,
> 
> let's assume someone got access to the GIT server of my hoster and
> tries to hide a change within an old commit, done by me.

Commits can not be modified once created. So the attacker would have to
recreate that commit with nasty modifications and then recreate every commit
since. 
 
> How will GIT tell me about this hidden change? Will a "git pull"
> just bring this change into my working copy, whithout telling me
> about the change?

At least after git pull, the history will look very odd if displayed
graphically...

-Ilari
