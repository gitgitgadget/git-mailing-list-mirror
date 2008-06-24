From: Matthias Kestenholz <mk@spinlock.ch>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 16:02:33 +0200
Message-ID: <1214316153.6441.24.camel@localhost>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>
	 <1214306517.6441.10.camel@localhost>
	 <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>
	 <alpine.DEB.1.00.0806241246500.9925@racer>
	 <ce513bcc0806240507q58c2a3y5fe8f0e8033353ad@mail.gmail.com>
	 <m3abhbkoe2.fsf@localhost.localdomain>
	 <ce513bcc0806240642g56ca5450t4edd24fd88ce79c7@mail.gmail.com>
	 <20080624135429.GA6905@atn.sw.ru>  <20080624135911.GB6905@atn.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Erez Zilber <erezzi.list@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Anton Gladkov <agladkov@parallels.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 16:04:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB97p-0001HC-08
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 16:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041AbYFXOCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 10:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754344AbYFXOCg
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 10:02:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:58038 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbYFXOCf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 10:02:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1178998fgg.17
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 07:02:34 -0700 (PDT)
Received: by 10.86.92.7 with SMTP id p7mr8970064fgb.72.1214316154054;
        Tue, 24 Jun 2008 07:02:34 -0700 (PDT)
Received: from ?192.168.11.104? ( [129.132.78.250])
        by mx.google.com with ESMTPS id l19sm12160890fgb.7.2008.06.24.07.02.33
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 07:02:33 -0700 (PDT)
In-Reply-To: <20080624135911.GB6905@atn.sw.ru>
X-Mailer: Evolution 2.22.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86059>

On Tue, 2008-06-24 at 17:59 +0400, Anton Gladkov wrote:
> On Tue, Jun 24, 2008 at 05:54:29PM +0400, Anton Gladkov wrote:
> > On Tue, Jun 24, 2008 at 05:42:14PM +0400, Erez Zilber wrote:
> > > I guess that the problem is that no proper mapping exists. That's why
> > > I see the following in /var/log/httpd/error_log:
> > >
> > > [Tue Jun 24 16:31:52 2008] [error] [client 172.16.0.7] File does not
> > > exist: /var/www/html/pub
> > >
> > > What do I need to add in /etc/httpd/conf.d/ in order to set the
> > > mapping to /pub/git instead of /var/www/html/pub ? Is there an example
> > > that shows how to map?
> > 
> > IMO the simplest way is to create a symlink 'pub' in /var/www/html directory
> > pointing to /pub and to add 'Options FollowSymLinks' to <Directory /> in httpd.conf.
> 
> But, I think it will not help you.
> AFAIK you need a gitweb.
> 

To be able to use the HTTP git transport? No. If you use the HTTP
transport to clone a repository, gitweb is not used in any way.


-- 
http://spinlock.ch/blog/
