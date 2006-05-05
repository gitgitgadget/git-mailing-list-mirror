From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 5 May 2006 11:23:32 +0200
Message-ID: <20060505092332.GY27689@pasky.or.cz>
References: <20060505005659.9092.qmail@science.horizon.com> <20060505062236.GA4544@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 11:22:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbwW5-00017Y-Ob
	for gcvg-git@gmane.org; Fri, 05 May 2006 11:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWEEJWY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 05:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWEEJWY
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 05:22:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7903 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030343AbWEEJWY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 05:22:24 -0400
Received: (qmail 2949 invoked by uid 2001); 5 May 2006 11:23:32 +0200
To: Fredrik Kuivinen <freku045@student.liu.se>
Content-Disposition: inline
In-Reply-To: <20060505062236.GA4544@c165.ib.student.liu.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19605>

Dear diary, on Fri, May 05, 2006 at 08:22:36AM CEST, I got a letter
where Fredrik Kuivinen <freku045@student.liu.se> said that...
> On Thu, May 04, 2006 at 08:56:59PM -0400, linux@horizon.com wrote:
> > What people who are asking for explicit rename tracking actually want
> > is automatic rename merging.  If branch A renames a file, and branch B
> > corrects a typo on a comment somewhere, they'd like the merge to
> > both patch and rename the file.  If you can do that, you have met the
> > need, even if your solution isn't the one the feature requester
> > imagined.
> 
> I don't know if you already know this, if you do it might be valuable
> for other readers.
> 
> If the rename is detected by the current rename detection code
> (git-diff-tree -M) then the merge case described above is handled
> perfectly fine by the current git. That is, the rename is followed and
> the patch fixing the typo is applied to the renamed file. This assumes
> that the default merge strategy (recursive) is used.

But the non-obviously important part here to note is that the branch B
merely "corrects a typo on a comment somewhere" - the latest versions in
branch A and branch B are always compared for renames, therefore if
branch A renamed the file and branch B sums up to some larger-scale
changes in the file, it still won't be merged properly.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
