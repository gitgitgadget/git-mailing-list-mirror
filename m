From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Pushing everything
Date: Sun, 31 Oct 2010 15:30:32 +0300
Message-ID: <20101031123031.GE18845@localhost.localdomain>
References: <loom.20101031T064406-734@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Sun Oct 31 13:44:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCXH2-0007Ag-Lp
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 13:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526Ab0JaMno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 08:43:44 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:56089 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755466Ab0JaMnn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 08:43:43 -0400
X-Greylist: delayed 775 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Oct 2010 08:43:42 EDT
Received: from proxysrv.domain007.com ([10.8.0.42])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o9VCUcja018277;
	Sun, 31 Oct 2010 15:30:40 +0300
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id C00D745A220; Sun, 31 Oct 2010 15:30:32 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <loom.20101031T064406-734@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang 2.51 (www.roaringpenguin.com/mimedefang) on 192.168.2.20
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160440>

On Sun, Oct 31, 2010 at 05:47:38AM +0000, Maaartin wrote:

> I'd like to push all my branches and tags to the server, but for whatever reason 
> "--all" ignores tags and is incompatible with "--tags". I could imagine there's 
> a reason I'm not experienced enough to see?
> 
> It seems to me that "--mirror" is quite unusable, since it force-overwrites the 
> remote repo and even deletes refs not locally present. Obviously, a mirror can't 
> be shared, and it doesn't seem to me to be the ideal backup solution for a 
> single person.
> 
> However, even if "git push -all -tags"  worked, I'm not sure it's a good idea 
> for project with more collaborators. There may be conflicts or other problems 
> and quite often the pushing occurs just before leaving so it's no good time to 
> start resolving conflicts. Can a shared repo be used as a sort of backup as 
> well? I'd like a possibility to backup all my work there anytime without needing 
> to care about anything. This could work by creating sort of private refs in case 
> of any problems, or whatever. Is there something like this, or am I thinking 
> astray? I'd suppose, something like this could be very useful for a company 
> where it'd provide a simple backup solution for everybody.
You can have any number of remotes configured for your local repo.
So you can easily have one "private" remote repo which you use solely
for "backup" pushes and one "shared" remote repo to which you do careful
selective pushes.

Note that I'm obsessed with the "backup" idea no less than you and when
I started using Git I learned about --mirror and did mirror push to my
private remote repo before leaving office, just as you explained.
But then I realized this was just a hangover from my Subversion
backgrounds, and that to really need --mirror doing regular programming,
you have to be fantastically, inhumanly productive. I mean, after a
typical one work day programming session you usually have a clear idea
about what branch(es) and what tags, if any, you have to push for backup
purposes. So it really might be a non-issue.
