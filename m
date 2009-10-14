From: Scott Wiersdorf <scott@perlcode.org>
Subject: Re: why no "ignore" command on git
Date: Wed, 14 Oct 2009 17:02:17 -0600
Message-ID: <20091014230217.GA87543@perlcode.org>
References: <42efdea40910141535g23a50b87p9b6c4a0fde7e842e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 01:04:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyCtG-0007kp-UV
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 01:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762081AbZJNXC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 19:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762078AbZJNXC6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 19:02:58 -0400
Received: from deep2.securesites.net ([198.65.247.173]:1710 "EHLO
	deep2.securesites.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761130AbZJNXC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 19:02:58 -0400
Received: from deep2.securesites.net (localhost [127.0.0.1])
	by deep2.securesites.net (8.13.6.20060614/8.13.6) with ESMTP id n9EN2J7J062400
	for <git@vger.kernel.org>; Wed, 14 Oct 2009 17:02:19 -0600 (MDT)
Received: (from scott@localhost)
	by deep2.securesites.net (8.13.6.20060614/8.13.6/Submit) id n9EN2Jhc062398
	for git@vger.kernel.org; Wed, 14 Oct 2009 17:02:19 -0600 (MDT)
Mail-Followup-To: Scott Wiersdorf <scott@perlcode.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <42efdea40910141535g23a50b87p9b6c4a0fde7e842e@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (deep2.securesites.net [127.0.0.1]); Wed, 14 Oct 2009 17:02:19 -0600 (MDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130348>

git does have a command to ignore files and directories: it's called
'emacs' (or 'vim' on some systems).

Seriously, the .gitignore file can contain a complex set of patterns
to ignore, and you can have .gitignore files at lower directories in a
hierarchy to override higher ones. This isn't something easily
contained in a simple command.

Scott


On Thu, Oct 15, 2009 at 12:35:23AM +0200, Ralf Thielow wrote:
> Hello,
> 
> why does git don't have an "ignore" command, to ignore some files or
> directories all the time.
> In many project file structures you have IDE specified project files
> or directories which
> should not be tracked on git. All the time git says that you can add
> these files, this is not
> usable if you want to add many files with the "git add ." command.
> I read on some pages by a google search that you can create
> a ".gitignore" directory or something like that. But you had to do
> this manually.
> 
> why there is no "ignore" command on git?
> 
> best regards
> 
> Ralf
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Scott Wiersdorf
<scott@perlcode.org>
