From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Wed, 11 Jun 2008 13:32:21 -0500
Message-ID: <XZoDb2arIiMts-bX6jjK15wC9cOn5lPGgCOQYbY9YIyNm_nfcDf5gQ@cipher.nrlssc.navy.mil>
References: <484F2174.9020508@keyaccess.nl> <alpine.LNX.1.00.0806111340570.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Rene Herman <rene.herman@keyaccess.nl>, git <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 20:33:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6V8g-0007Vt-5h
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 20:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbYFKScr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 14:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbYFKScr
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 14:32:47 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41671 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbYFKScq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 14:32:46 -0400
Received: by mail.nrlssc.navy.mil id m5BIWLhC010860; Wed, 11 Jun 2008 13:32:22 -0500
In-Reply-To: <alpine.LNX.1.00.0806111340570.19665@iabervon.org>
X-OriginalArrivalTime: 11 Jun 2008 18:32:21.0773 (UTC) FILETIME=[7C949BD0:01C8CBF1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84633>

Daniel Barkalow wrote:
> On Wed, 11 Jun 2008, Rene Herman wrote:
> 
>> Good day.
>>
>> The manpages seem to be making somewhat of a point of mentioning "git pull .
>> <branch>" as the way to merge a local branch into the current one but a simple
>> "git merge <branch>" seems to work well. Is there a difference?
> 
> Those manpage sections predate the existance of "git merge <branch>". If 
> you're not planning to use git before November 2006, there's no reason to 
> use the "git pull ." form. They should probably be replaced with more 
> helpful examples at this point.

Was there some past discussion of the ui merits of a separate 'merge' command
for dealing with local merges and a 'pull' command for remote merges? I
understand merge is the backend. The question has to do with the high-level
user interface: one command or two? Why wasn't git-pull enough?

I ask because elsewhere in this thread Miklos suggests that git-merge should
be preferred over git-pull when dealing with a local repostory and you suggest
here that the documentation should be updated to use the 'git merge' method
instead of 'git pull'. I had the impression that git-merge was only used by
those who had not yet gotten their mind around the pull methodology. So it
was more of an 'ease the transition from other SCMs' rather than the recommended
way of doing things.

-brandon
