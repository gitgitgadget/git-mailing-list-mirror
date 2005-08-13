From: Petr Baudis <pasky@suse.cz>
Subject: Re: Add an empty directory?
Date: Sat, 13 Aug 2005 20:00:08 +0200
Message-ID: <20050813180008.GJ5608@pasky.ji.cz>
References: <20050813173043.GA25013@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 20:01:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E40J3-0007S9-Lh
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 20:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVHMSAM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 14:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVHMSAM
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 14:00:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44813 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932144AbVHMSAL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 14:00:11 -0400
Received: (qmail 12952 invoked by uid 2001); 13 Aug 2005 18:00:08 -0000
To: Carl Baldwin <cnb@fc.hp.com>
Content-Disposition: inline
In-Reply-To: <20050813173043.GA25013@hpsvcnb.fc.hp.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Aug 13, 2005 at 07:30:43PM CEST, I got a letter
where Carl Baldwin <cnb@fc.hp.com> told me that...
> Greetings,

Hi,

> My appologies if this has already been discussed.  I've been through the
> archives but could easily have missed something.
> 
> I have found it useful in the past to have the ability to add an empty
> directory to the repository.  With what little I know about git it seems
> that this is entirely possible.  It would create an empty tree object
> for the new directory and insert a reference to that in the parent tree
> object.
> 
> If someone could get me started I think I could find the time to create
> and submit a patch to allow this.  Here is what I've tried (with
> 0.99.4).
> 
> % mkdir test
> % cd test
> % git-init-db
> % mkdir dir
> % git-add-script dir
> error: open("dir"): No such file or directory
> fatal: Unable to add dir to database

the object databases supports it, but the index file does not. But yes,
it should be supported, I think.

Some argue that this is useless, so some practical example of its
usefulness might be a good motivation to get us going. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
