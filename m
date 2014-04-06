From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [RFC] git submodule split
Date: Sun, 06 Apr 2014 23:18:24 +0200
Message-ID: <87d2gukvhb.fsf@steelpick.2x.cz>
References: <87sipviel4.fsf@steelpick.2x.cz> <53417C00.3090805@web.de>
Mime-Version: 1.0
Content-Type: text/plain
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 23:26:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWuaC-0005DC-CQ
	for gcvg-git-2@plane.gmane.org; Sun, 06 Apr 2014 23:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbaDFV0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 17:26:24 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:52706 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568AbaDFV0W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2014 17:26:22 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Apr 2014 17:26:22 EDT
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 4EBE63CFE99;
	Sun,  6 Apr 2014 23:18:35 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id 3ikfbA4Rpgkp; Sun,  6 Apr 2014 23:18:30 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 1194C3CFE80;
	Sun,  6 Apr 2014 23:18:29 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.82)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1WWuSO-00013L-3D; Sun, 06 Apr 2014 23:18:24 +0200
In-Reply-To: <53417C00.3090805@web.de>
User-Agent: Notmuch/0.17 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245791>

On Sun, Apr 06 2014, Jens Lehmann wrote:
> Am 02.04.2014 23:52, schrieb Michal Sojka:
>> Hello,
>> 
>> I needed to convert a subdirectory of a repo to a submodule and have the
>> histories of both repos linked together. I found that this was discussed
>> few years back [1], but the code seemed quite complicated and was not
>> merged.
>> 
>> [1]: http://git.661346.n2.nabble.com/RFC-What-s-the-best-UI-for-git-submodule-split-tp2318127.html
>> 
>> Now, the situation is better, because git subtree can already do most of
>> the work. Below is a script that I used to split a submodule from my
>> repo. It basically consist of a call to 'git subtree split' followed by
>> 'git filter-branch' to link the histories together.
>> 
>> I'd like to get some initial feedback on it before attempting to
>> integrate it with git sources (i.e. writing tests and doc). What do you
>> think?
>
> Why do want to rewrite the whole history of the superproject,
> wouldn't it suffice to turn a directory into a submodule with
> the same content in a simple commit? 

I wanted to publish a project including its history but a part of that
project could not be made public due to legal reasons. Putting that part
into submodule seemed like best idea.

-Michal
