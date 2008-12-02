From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn rebase "problems"
Date: Tue, 02 Dec 2008 16:32:56 +0100
Message-ID: <49355528.80503@drmicha.warpmail.net>
References: <73fd69b50811301917j6535f289uf177976707914e46@mail.gmail.com> <73fd69b50812020656u3fd17015n267f694236982e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joe Fiorini <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 16:34:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7XGV-0004Vm-8B
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 16:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbYLBPdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 10:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbYLBPdA
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 10:33:00 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52417 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750748AbYLBPdA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2008 10:33:00 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 83BC11C9BA7;
	Tue,  2 Dec 2008 10:32:59 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 02 Dec 2008 10:32:59 -0500
X-Sasl-enc: xFm/CarLNTxVBRvMJKhrnglgr5M0Qmld/tOC0DU9A9R4 1228231979
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F272D2CDF2;
	Tue,  2 Dec 2008 10:32:58 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <73fd69b50812020656u3fd17015n267f694236982e5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102145>

Joe Fiorini venit, vidit, dixit 02.12.2008 15:56:
> Are there any other details I can provide to get an answer on this?
> 
> Thanks!
> Joe
> 
> On Sun, Nov 30, 2008 at 10:17 PM, Joe Fiorini <joe@faithfulgeek.org> wrote:
>> I'm having some problems with git svn rebase. I'm pretty sure this is
>> just the way git works, not a problem per se. But it's causing trouble
>> for me and my team.
>> My team is currently on Subversion. I'm trying to convince some people
>> that git is a good way to go.
>>
>> So I'm using git-svn. My team tends to commit to the svn server fairly
>> often. It has happened more than once that, because git svn rebase
>> applies each svn commit sequentially, some of the commits will
>> conflict with each other - whether or not I have ever touched the

git svn rebase fetches all svn commits and then rebases your current
branch onto FETCH_HEAD (the last svn commit). In doing so, it applies
the commits you have on your branch (since merge base) one by one.
What do you mean by "applies each svn commit sequentially"?

>> file. Obviously, this is a big problem because if I've never touched
>> the file, then I probably won't know exactly how to resolve the merge
>> (the merge markers haven't been solely reliable).

If you develop on a local branch and get conflicts with others' commits
someone has to resolve them, whether you use git or svn. But I'm
surprised there are conflicts in files you didn't touch. Can you share
more details on the files or the workflow/repo?

Michael
