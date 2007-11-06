From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: git pull opinion
Date: Tue, 6 Nov 2007 08:34:55 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071106073455.GA19106@ins.uni-bonn.de>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com> <20071105234049.GA31277@genesis.frugalware.org> <3abd05a90711052016s615cd66cy5a5f932900d89143@mail.gmail.com> <176851C5-D735-4DDC-B799-A5106CD03989@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aghiles <aghilesk@gmail.com>, git list <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Nov 06 08:35:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpIxv-0001zn-R5
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 08:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbXKFHfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 02:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbXKFHfB
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 02:35:01 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:47838 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbXKFHfA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 02:35:00 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 8B122400013E0;
	Tue,  6 Nov 2007 08:34:56 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Benoit Sigoure <tsuna@lrde.epita.fr>, Aghiles <aghilesk@gmail.com>,
	git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <176851C5-D735-4DDC-B799-A5106CD03989@lrde.epita.fr>
User-Agent: Mutt/1.5.17 (2007-11-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63632>

Hello,

* Benoit Sigoure wrote on Tue, Nov 06, 2007 at 06:29:58AM CET:
> On Nov 6, 2007, at 5:16 AM, Aghiles wrote:
>
>>> who will run git stash clear? :)
>>
>> Yes you are right. By the way, in the context of merging into a
>> dirty tree, "git stash clear" seems to be a dangerous command:
>> there is a risk of loosing all your changes without a question
>> asked!

I would love it if for once in the git world, there were a pair of
commands that would do the exact opposite of each other and where the
naive newbie (me) would immediately recognize that from their names:
  git stash push
  git stash pop

Both applied in this order should be a no-op on both the working tree,
the index, and also the stash.  There's room for extensions (pop
--keep-stash to not remove the stashed information), explicit naming of
stashes, doing multiple pops at once, and so on.  Please don't add more
of the git-push/git-pull, git-add/git-rm unsymmetrical interfaces.
Even if they're perfectly clear to git intimates, each one of them
takes precious extra time to learn due to this lack of symmetry.

Since I simply don't have the time resources to just implement that,
I'll thank you for your attention and go back to lurking mode now.

Thanks,
Ralf
