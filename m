From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: Updating a branch.
Date: Wed, 28 Oct 2009 05:03:34 -0700 (PDT)
Message-ID: <26093449.post@talk.nabble.com>
References: <26015707.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 13:03:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N37Fd-00027v-6h
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 13:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbZJ1MDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 08:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbZJ1MDa
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 08:03:30 -0400
Received: from kuber.nabble.com ([216.139.236.158]:40896 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbZJ1MDa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 08:03:30 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1N37FW-0003kT-Fg
	for git@vger.kernel.org; Wed, 28 Oct 2009 05:03:34 -0700
In-Reply-To: <26015707.post@talk.nabble.com>
X-Nabble-From: timmazid@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131450>



elyod72 wrote:
> 
> I am a newbie to git, so please bear with me.
> Here is the scenario that I am struggling with:
> 
> I have my Master branch.
> I then create a new branch named Test.
> I then make changes and additions to the test branch. 
> At the same time I make changes to the Master branch.
> Now I want to update the Test branch with the latest information from the
> Master branch. 
> 
> How do I go about doing that?
> 
> Thanks for you time and help.
> 


I'm a newbie too, don't worry. :P

And what you're describing is pretty simple.
Just do

git checkout Test
git merge Master

Voila. :P
Obviously, if there are any conflicts, you'll have to resolve them with 'git
mergetool'.

Good luck,
Tim.
-- 
View this message in context: http://www.nabble.com/Updating-a-branch.-tp26015707p26093449.html
Sent from the git mailing list archive at Nabble.com.
