From: Sam Vilain <sam@vilain.net>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Sun, 25 Jul 2010 18:44:04 +0800
Message-ID: <1280054644.2196.38.camel@arcturus>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
	 <1279868098.2846.45.camel@dreddbeard>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: wmpalmer@gmail.com
X-From: git-owner@vger.kernel.org Sun Jul 25 18:11:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od3n0-0005ms-8W
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 18:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105Ab0GYQKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 12:10:53 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57311 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919Ab0GYQKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 12:10:53 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id B4DF621C993; Mon, 26 Jul 2010 04:10:51 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	DATE_IN_PAST_03_06 autolearn=no version=3.2.5
Received: from [192.168.43.144] (unknown [121.90.142.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 22B3721C992;
	Mon, 26 Jul 2010 04:10:45 +1200 (NZST)
In-Reply-To: <1279868098.2846.45.camel@dreddbeard>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151756>

On Fri, 2010-07-23 at 07:54 +0100, Will Palmer wrote:
> The problem is that, unlike so much of git, submodules make themselves
> known. They're loud, they're in the way, they require management to
> work. Case in point:
> "Switching from 1.7.2 to this tree will of course give you a tree
> without gitk and git-gui (nothing a simple "git submodule init/update"
> cannot fix)"
> 
> So already in order to build a working git again, someone needs to
> manually run some extra commands, which could potentially (but not
  [...]

There's a relatively comprehensive list of TODO items on the git wiki
along with the summer of code ideas page.  They have been known for some
time, but up till now most people have just worked around them.  I think
using it for git-core would possibly assist in creating the anger that
some of these changes will need to be performed in to be of greater
benefit to the community as a whole ;-)

submodules are nice; it's good for instance to be able to keep unrelated
parts of the project out of the history view, squashed in the main
project yet still fine-grained and bisectable in the sub-project.  While
I haven't gone through the other people who have described their use
cases/requirements in detail, it strikes me that many of the existing
ideas would help these requirements be met too.

Sam
