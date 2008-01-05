From: William Morgan <wmorgan-git@masanjin.net>
Subject: Re: git-walkthrough-add script
Date: Fri, 04 Jan 2008 18:37:34 -0800
Message-ID: <1199500441-sup-4067@south>
References: <1199426431-sup-6092@south> <20080104072650.GA24685@coredump.intra.peff.net> <1199471454-sup-4786@south> <20080104210751.GB26248@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 03:44:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAz1X-0000vN-Ek
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 03:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738AbYAECn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 21:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754730AbYAECn7
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 21:43:59 -0500
Received: from nlpi015.sbcis.sbc.com ([207.115.36.44]:18218 "EHLO
	nlpi015.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678AbYAECn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 21:43:59 -0500
X-ORBL: [68.127.149.88]
Received: from south (adsl-68-127-149-88.dsl.pltn13.pacbell.net [68.127.149.88])
	by nlpi015.prodigy.net (8.13.8 out.dk.spool/8.13.8) with ESMTP id m052hvoD020128
	for <git@vger.kernel.org>; Fri, 4 Jan 2008 20:43:57 -0600
Received: from rubyist by south with local (Exim 4.63)
	(envelope-from <rubyist@masanjin.net>)
	id 1JAyuk-0006Yc-LD
	for git@vger.kernel.org; Fri, 04 Jan 2008 18:37:34 -0800
In-Reply-To: <20080104210751.GB26248@coredump.intra.peff.net>
User-Agent: Sup/0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69631>

Excerpts from Jeff King's message of Fri Jan 04 13:07:51 -0800 2008:
> But if you have interface improvement suggestions for "git-add -i" or
> "git-add -p", I'm sure they would be well-received (post-1.5.4
> release, of course).

Not to show off my git newbness any more than necessary, but when I run
both git-add -i and git-add -p, I see exactly the same output and
interface. Are they meant to be different? This is with both master and
next branches of the git repo.

  ~/devel/sup$ ~/devel/git/installed/bin/git-add -i
             staged     unstaged path
    1:    unchanged        +1/-0 doc/TODO
    2:    unchanged        +1/-1 lib/sup/message.rb
    3:    unchanged      +28/-43 lib/sup/thread.rb
  
  *** Commands ***
    1: status       2: update       3: revert       4: add untracked
    5: patch        6: diff         7: quit         8: help
  What now> 
  Bye.
  ~/devel/sup$ ~/devel/git/installed/bin/git-add -p
             staged     unstaged path
    1:    unchanged        +1/-0 doc/TODO
    2:    unchanged        +1/-1 lib/sup/message.rb
    3:    unchanged      +28/-43 lib/sup/thread.rb
  
  *** Commands ***
    1: status       2: update       3: revert       4: add untracked
    5: patch        6: diff         7: quit         8: help
  What now> 
  Bye.

-- 
William <wmorgan-git@masanjin.net>
