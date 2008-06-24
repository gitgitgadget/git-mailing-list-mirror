From: Anton Gladkov <agladkov@parallels.com>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 17:54:29 +0400
Message-ID: <20080624135429.GA6905@atn.sw.ru>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com> <1214306517.6441.10.camel@localhost> <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com> <alpine.DEB.1.00.0806241246500.9925@racer> <ce513bcc0806240507q58c2a3y5fe8f0e8033353ad@mail.gmail.com> <m3abhbkoe2.fsf@localhost.localdomain> <ce513bcc0806240642g56ca5450t4edd24fd88ce79c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthias Kestenholz <mk@spinlock.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 15:55:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB8zI-0005Wy-N9
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 15:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbYFXNyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 09:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbYFXNyP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 09:54:15 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:41778 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbYFXNyP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 09:54:15 -0400
Received: from localhost.localdomain ([10.30.3.212])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id m5ODs1rL019888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jun 2008 17:54:02 +0400 (MSD)
Received: from atn.sw.ru (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.1) with ESMTP id m5ODsTx6006983;
	Tue, 24 Jun 2008 17:54:29 +0400
Received: (from anton@localhost)
	by atn.sw.ru (8.14.2/8.14.2/Submit) id m5ODsT3I006982;
	Tue, 24 Jun 2008 17:54:29 +0400
X-Authentication-Warning: atn.sw.ru: anton set sender to agladkov@parallels.com using -f
Content-Disposition: inline
In-Reply-To: <ce513bcc0806240642g56ca5450t4edd24fd88ce79c7@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86056>

On Tue, Jun 24, 2008 at 05:42:14PM +0400, Erez Zilber wrote:
> I guess that the problem is that no proper mapping exists. That's why
> I see the following in /var/log/httpd/error_log:
> 
> [Tue Jun 24 16:31:52 2008] [error] [client 172.16.0.7] File does not
> exist: /var/www/html/pub
> 
> What do I need to add in /etc/httpd/conf.d/ in order to set the
> mapping to /pub/git instead of /var/www/html/pub ? Is there an example
> that shows how to map?

IMO the simplest way is to create a symlink 'pub' in /var/www/html directory
pointing to /pub and to add 'Options FollowSymLinks' to <Directory /> in httpd.conf.

-- 
Best regards,
		Anton
mailto:agladkov@parallels.com
