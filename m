From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: What I miss from Cogito...
Date: Sun, 23 Mar 2008 20:14:47 +0100
Message-ID: <87r6e1b6c8.fsf@mid.deneb.enyo.de>
References: <47E69044.3000207@zytor.com> <20080323173841.GA24943@mit.edu>
	<20080323182102.GA22551@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 20:15:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdVfP-0006ZH-QE
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 20:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681AbYCWTOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 15:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755684AbYCWTOu
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 15:14:50 -0400
Received: from mail.enyo.de ([212.9.189.167]:53436 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755602AbYCWTOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 15:14:50 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1JdVea-0007yg-DF
	for git@vger.kernel.org; Sun, 23 Mar 2008 20:14:48 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1JdVeZ-000566-Vv
	for git@vger.kernel.org; Sun, 23 Mar 2008 20:14:47 +0100
In-Reply-To: <20080323182102.GA22551@bit.office.eurotux.com> (Luciano Rocha's
	message of "Sun, 23 Mar 2008 18:21:02 +0000")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77947>

* Luciano Rocha:

>>         git show HEAD:$prefix$i > $i

> I use git checkout path ...
>
> Isn't that the same thing?

No, it restores the file version in the index.  "git checkout HEAD --
$path" should be the same.

Personally, I'm not all that happy with the multiple different meanings
of "git reset" and "git checkout", either.  Depending on the parameters,
the two comments manipulate both the contents of the working copy, or
the location at which the working copy is hooked in the history.  If we
need to have two separate commands for this, it would make more sense to
draw distinction between the two aspects, and not the mess we have now.
OTOH, it's probably too late for that.
