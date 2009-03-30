From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: [PATCH] Add diffuse as merge and diff tool
Date: Mon, 30 Mar 2009 18:41:33 +0200
Message-ID: <49D0F63D.2050205@hartwork.org>
References: <49CEA3E2.9020805@hartwork.org> <20090330045522.GA8308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 18:44:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoKae-0007m3-3k
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 18:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbZC3Qli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 12:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbZC3Qlh
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 12:41:37 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:46278 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbZC3Qlg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 12:41:36 -0400
Received: from [85.179.15.151] (helo=[192.168.0.3])
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1LoKYH-0003OW-Pr; Mon, 30 Mar 2009 18:41:33 +0200
User-Agent: Thunderbird 2.0.0.19 (X11/20090216)
In-Reply-To: <20090330045522.GA8308@gmail.com>
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115174>

David Aguilar wrote:
>>  Documentation/git-mergetool.txt        |    3 ++-
>>  Documentation/merge-config.txt         |    7 ++++---
>>  contrib/completion/git-completion.bash |    3 ++-
>>  contrib/difftool/git-difftool-helper   |   12 ++++++++----
>>  contrib/difftool/git-difftool.txt      |    4 ++--
>>  git-gui/lib/mergetool.tcl              |    7 +++++++
>>  git-mergetool.sh                       |   15 ++++++++++++---
>>  7 files changed, 37 insertions(+), 14 deletions(-)
> 
> 
> Hey, thanks for the patch.
> Ouch.. too many places with duplicated information, huh?

Yes.


> I'm in the middle of refactoring git-(diff|merge)tool so that
> there is less duplication of code.
> 
> Junio also has a number of difftool-related patches in his
> proposed-updates "pu" branch.
> 
> Sebastian, would you mind if I rebased your patch on top of my
> work (once I send it out) so that it makes things easier on
> our kind maintainer?  I have a big patch series coming down that
> does away with the redundancies so I think it'd be best if we
> transfered your changes on top of it.  Would you mind if I
> rebased your patch and sent it out to the list?
> 
> It wouldn't be until much later tonight (or tomorrow) at the
> earliest since I have some unpacking to take care of but if
> that's cool with you just let me know.
> 
> You should see the refactoring patches from me shortly...

My patch is your patch, do as you please.

Just take care to keep the order of the files passed
to Diffuse intact, especially with $MERGED second,
as Diffuse sets focus on the second document after startup.



Sebastian
