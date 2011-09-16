From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: zealous git convert determined to set up git server
Date: Sat, 17 Sep 2011 01:22:36 +0300
Message-ID: <20110916222236.GA9038@LK-Perkele-VI.localdomain>
References: <CAOZxsTqtW=DD7zFwQLjknJR8g0nnh0WPUPna6_np4bVoGnSntQ@mail.gmail.com>
 <CAMK1S_jK2w8v4ushsZztQ0QY-eZq8axso-DpmCCvA=Gp7iXkBg@mail.gmail.com>
 <20110916204032.GA13922@inner.h.iocl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 17 00:32:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4gx8-0000m1-Is
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 00:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794Ab1IPWcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 18:32:05 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:32875 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161Ab1IPWcE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 18:32:04 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Sep 2011 18:32:03 EDT
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 0C45218D142;
	Sat, 17 Sep 2011 01:22:39 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0611507710; Sat, 17 Sep 2011 01:22:39 +0300
Received: from LK-Perkele-VI (a88-112-55-20.elisa-laajakaista.fi [88.112.55.20])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id E067CE51A4;
	Sat, 17 Sep 2011 01:22:35 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20110916204032.GA13922@inner.h.iocl.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181562>

On Fri, Sep 16, 2011 at 10:40:32PM +0200, Andreas Krey wrote:
> 
> It well looks so, but I have a question: It seems that it assumes a
> flat set of *.git repos. Unfortunately my current setup has the repos
> in a hierarchy, like area/sub/repo.git, and I don't want everyone to
> change their local repo configs. Is it possible to keep it like that
> (and consequently have 'repo area/sub/repo' lines) when putting it
> under gitolite control?

It is possible to have '/' in repository name in Gitolite. Heck,
most repos I have in Gitolite have '/' in their names...

-Ilari
