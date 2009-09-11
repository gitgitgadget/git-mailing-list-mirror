From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] reset: add option "--merge-dirty" to "git reset"
Date: Fri, 11 Sep 2009 07:29:32 +0200
Message-ID: <200909110729.32581.chriscool@tuxfamily.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org> <20090910202333.3722.37592.chriscool@tuxfamily.org> <alpine.LFD.2.01.0909101617280.3654@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 07:30:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlyic-0007vs-4Q
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 07:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbZIKF2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 01:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbZIKF2N
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 01:28:13 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:38516 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184AbZIKF2M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 01:28:12 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 505878180CC;
	Fri, 11 Sep 2009 07:28:06 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5D65B818100;
	Fri, 11 Sep 2009 07:28:04 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.2.01.0909101617280.3654@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128173>

On Friday 11 September 2009, Linus Torvalds wrote:
> On Thu, 10 Sep 2009, Christian Couder wrote:
> > In fact with "--merge-dirty", changes that are both in
> > the work tree and the index are kept in the work tree
> > after the reset (but discarded in the index). As with
> > "--merge", changes that are in both the work tree and
> > the index are discarded after the reset.
>
> Can you explain that again?

Yeah, I tried to explain it better in my reply to Daniel.

> That paragraph makes no sense, because it 
> boils down to saying two different thing for "changes that are in both
> the work tree and the index". First it says such changes are kept in the
> work tree (but discarded in the index), and then it says that the changes
> are discarded.
>
> Which seems very odd.
>
> Or are my reading comprehension skills lacking?

No, I realize it was my writing skills that were lacking again. I will 
rework the commit message using some tables like in Daniel's message.

> The patch also seems to imply that it's always about HEAD. True?

Yes.

Best regards,
Christian.
