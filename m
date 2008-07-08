From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008
	projects?
Date: Tue, 08 Jul 2008 00:20:38 -0700
Message-ID: <1215501638.1998.21.camel@localhost.localdomain>
References: <200807080227.43515.jnareb@gmail.com>
	 <4872E858.4080607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 09:22:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG7X3-0006cS-3c
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 09:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbYGHHVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 03:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbYGHHVb
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 03:21:31 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:49813 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbYGHHVa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 03:21:30 -0400
Received: from [172.19.0.93] (c-67-188-226-86.hsd1.ca.comcast.net [67.188.226.86])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id m687KjmC013783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 8 Jul 2008 00:20:46 -0700
In-Reply-To: <4872E858.4080607@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-4.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/7661/Mon Jul  7 21:08:55 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Tue, 08 Jul 2008 00:20:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87726>

>From a quick an cursory glance I think we are well on track with the
Gitweb stuff (though I'll let Lea do a full status update).  It looks
like most of the code is in place, and there is a test site up and
running on one of the kernel.org machines (though not anywhere near
production yet - I still need to port some of my other changes to Lea's
change set so we can try this out for real on Kernel.org)

- John 'Warthog9' Hawley

On Tue, 2008-07-08 at 06:08 +0200, Lea Wiemann wrote:
> Jakub Narebski wrote:
> > 3. Gitweb caching
> 
> I'll post a complete status update in the next few days.  And three
> large patches (including the mechanize test). ;-)
> 
> > Lea has chosen caching data and memcached as primary caching engine,
> > and is working on object layer on top of Git.pm, namely Git::Repo and 
> > friends, which will be used by gitweb.  If I understand correctly 
> > caching is to be done, or at least helped by this layer.
> 
> That's correct, except that I'm not using Git.pm anywhere; Git::Repo is
> independent of Git.pm.  More about that later...
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
