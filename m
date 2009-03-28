From: jamespetts <jamespetts@yahoo.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the
  SVN
Date: Sat, 28 Mar 2009 14:46:49 -0700 (PDT)
Message-ID: <1238276809892-2550565.post@n2.nabble.com>
References: <22756729.post@talk.nabble.com> <8c9a060903280922r6514de83mea4dea84c4116225@mail.gmail.com> <1238258794470-2549665.post@n2.nabble.com> <8c9a060903281102r3eae26edta34899485feb884b@mail.gmail.com> <1238263580197-2549943.post@n2.nabble.com> <8c9a060903281327j33056807j78a2cd03b8151979@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 22:48:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LngO8-0004ze-AY
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 22:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758554AbZC1Vqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 17:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757789AbZC1Vqx
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 17:46:53 -0400
Received: from kuber.nabble.com ([216.139.236.158]:33597 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbZC1Vqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 17:46:52 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LngMc-00033M-28
	for git@vger.kernel.org; Sat, 28 Mar 2009 14:46:50 -0700
In-Reply-To: <8c9a060903281327j33056807j78a2cd03b8151979@mail.gmail.com>
X-Nabble-From: jamespetts@yahoo.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114978>


Thank you for your reply. Unfortunately, I cannot for the life of me get git-svn to work. It refuses to recognise "git svn" as a valid command, and "svn" does not appear in the list of commands when I type, "svn --help" in Git Bash (I am using Git in Windows, if that makes any difference). I tried to look for svn2git, but the homepage linked from the link that you gave me produced a 404. 

Also, once I have managed to create a Git clone of the SVN repository myself, how do I synchronise that properly with the branch of the other mirror of the SVN repository that I have been using as the trunk so far, such that I can continue to download updates and have [i]just[/i] the changes since the previous versions applied?


On Sat, Mar 28, 2009 at 11:06, jamespetts <jamespetts@yahoo.com> wrote:
>
> Thank you very much for your reply :-) Ahh, I didn't realise that that sort of SVN URL should be avoided. Is there any way around that when the project itself uses that sort of URL? And I think that it does require a username and empty password. I haven't tried the Github IRC channel - I must confess - I did not know that there was one.
>
> Any suggestions about how to deal with the other problem?
>

It looks like GitHub won't keep the project in sync for you, so you're
probably best off doing the git-svn clone yourself, and maintaining it
that way.

http://github.com/guides/import-from-subversion
--
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
View this message in context: http://n2.nabble.com/Fork-of-abandoned-SVN-mirror---how-to-keep-up-to-date-with-the-SVN-tp2548952p2550565.html
Sent from the git mailing list archive at Nabble.com.
