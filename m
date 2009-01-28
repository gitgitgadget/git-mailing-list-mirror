From: Zabre <427@free.fr>
Subject: Re: (beginner) git rm
Date: Wed, 28 Jan 2009 03:05:51 -0800 (PST)
Message-ID: <1233140751523-2231622.post@n2.nabble.com>
References: <1233137498146-2231416.post@n2.nabble.com> <Pine.LNX.4.64.0901281133380.645@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 12:07:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS8Gb-0007jz-OK
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 12:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbZA1LFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 06:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbZA1LFw
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 06:05:52 -0500
Received: from kuber.nabble.com ([216.139.236.158]:45871 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbZA1LFw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 06:05:52 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LS8Ex-0008Qz-H1
	for git@vger.kernel.org; Wed, 28 Jan 2009 03:05:51 -0800
In-Reply-To: <Pine.LNX.4.64.0901281133380.645@ds9.cixit.se>
X-Nabble-From: 427@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107527>



Peter Krefting wrote:
> 
> Here you have not yet committed the change, so the change is only in
> the staging area. You need to
> 
>   git commit
> 
> to create a commit on your branch.
> 

Thank you Peter.
I've just done a hard reset and redid it the right way. It worked as
expected.

$ git checkout new
$ rm d.txt
$ git rm d.txt
$ git commit

I am a little bit confused regarding rm : first I did a simple "rm" but git
would not commit, so I had to "git rm" for the index to be modified and have
something to commit. Is this the right way to do things?

Another question would be : instead of doing a hard reset (I might have
other changes in the index that I don't want to loose) is it possible to
remove only one "delete action" from the index?
-- 
View this message in context: http://n2.nabble.com/%28beginner%29-git-rm-tp2231416p2231622.html
Sent from the git mailing list archive at Nabble.com.
