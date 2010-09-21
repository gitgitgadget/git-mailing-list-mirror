From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Update Webservers from a remote repository
Date: Tue, 21 Sep 2010 12:41:28 +0300
Message-ID: <20100921094128.GA13619@LK-Perkele-V2.elisa-laajakaista.fi>
References: <4C9874BB.5060908@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthias Fechner <idefix@fechner.net>
X-From: git-owner@vger.kernel.org Tue Sep 21 11:37:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxzIG-0000Kx-Ec
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 11:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211Ab0IUJh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 05:37:26 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:43055 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757137Ab0IUJhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 05:37:25 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 57DA9EF91A;
	Tue, 21 Sep 2010 12:37:24 +0300 (EEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A07EC14F403; Tue, 21 Sep 2010 12:37:24 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 05E5F41BF0;
	Tue, 21 Sep 2010 12:37:22 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <4C9874BB.5060908@fechner.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156704>

On Tue, Sep 21, 2010 at 11:02:51AM +0200, Matthias Fechner wrote:
> 
> If I understood everything correctly I execute the following
> commands on each server:
> git checkout master (to be sure we are on branch master)
> git fetch (to fetch changes from the central repository)
> git merge origin (to update the repo to the changes on the central repo)
> 
> Is that correct or did I missed something?

I would do it the following way:

git checkout -f master
git fetch origin
git reset --hard orgin/master


You definitely do not want to run merge non-interactively (conflict risk!)

-Ilari
