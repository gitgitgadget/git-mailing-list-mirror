From: Anton Gladkov <agladkov@parallels.com>
Subject: Re: cant get git to work over http
Date: Wed, 20 Feb 2008 16:46:33 +0300
Message-ID: <20080220134633.GA4220@atn.sw.ru>
References: <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com> <alpine.LSU.1.00.0802191916020.7797@racer.site> <e26d18e40802191127v7cc9f051l7002b56b41dc9f86@mail.gmail.com> <alpine.LSU.1.00.0802191940260.7826@racer.site> <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com> <47BB3691.9040809@freescale.com> <e26d18e40802191305y5f7b8fdfr3113c84612c53189@mail.gmail.com> <47BB5037.5090302@freescale.com> <e26d18e40802191359r4c435818n4ae7b357d452d51e@mail.gmail.com> <e26d18e40802191413w48fe4a71hd7895b09d15cb44e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Jon Loeliger <jdl@freescale.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 14:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRpCY-0001nQ-HN
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 14:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbYBTNky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 08:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754813AbYBTNkx
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 08:40:53 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:41737 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214AbYBTNkx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 08:40:53 -0500
Received: from atn.sw.ru ([10.30.3.212])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id m1KDePXp011812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 20 Feb 2008 16:40:26 +0300 (MSK)
Received: from atn.sw.ru (localhost.localdomain [127.0.0.1])
	by atn.sw.ru (8.14.2/8.14.1) with ESMTP id m1KDkX6k004439;
	Wed, 20 Feb 2008 16:46:33 +0300
Received: (from anton@localhost)
	by atn.sw.ru (8.14.2/8.14.2/Submit) id m1KDkXk1004438;
	Wed, 20 Feb 2008 16:46:33 +0300
X-Authentication-Warning: atn.sw.ru: anton set sender to agladkov@parallels.com using -f
Content-Disposition: inline
In-Reply-To: <e26d18e40802191413w48fe4a71hd7895b09d15cb44e@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74513>

On Tue, Feb 19, 2008 at 02:13:30PM -0800, Anatoly Yakovenko wrote:
> On Feb 19, 2008 1:59 PM, Anatoly Yakovenko <aeyakovenko@gmail.com> wrote:
> > > Something is fishy here.  Is your repository bare or not?
> >
> > no, why does it need to be bare?
> >
> so bare or not ssh works but http doesnt:
> 
> $ git-clone ssh://aeyakovenko@localhost/var/www/localhost/htdocs/git/bare
> bare-ssh
> Initialized empty Git repository in /home/aeyakovenko/projects/bare-ssh/.git/
> Receiving objects: 100% (3/3), done.
> remote: Counting objects: 3, done.
> remote: Total 3 (delta 0), reused 0 (delta 0)
> 
> 
> 
> and running over a bare directory doesn't work:
> 
> 
> $ git-clone http://aeyakovenko@localhost/git/bare bare

'Bare' means cloning with '--bare' option.

> Initialized empty Git repository in /home/aeyakovenko/projects/bare/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?
> 
> apache acess log:
> 
> 127.0.0.1 - - [19/Feb/2008:14:10:19 -0800] "GET /git/bare/info/refs
> HTTP/1.1" 401 460
> 
> i feel like i am taking crazy pills, why is apache looking for
> /git/bare/info/refs, and no the directory from the doc root?
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best regards,
		anton
mailto:agladkov@sw.ru
