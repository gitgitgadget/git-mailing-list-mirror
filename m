From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Tue, 02 Sep 2008 14:58:55 -0700
Message-ID: <7vr682i50g.fsf@gitster.siamese.dyndns.org>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
 <7vk5dujn9h.fsf@gitster.siamese.dyndns.org>
 <20080902210524.GB7757@leksak.fem-net> <200809022339.20123.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 00:01:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kadvl-0001Ze-TK
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 00:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbYIBV7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 17:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbYIBV7F
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 17:59:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbYIBV7D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 17:59:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 609655AFDE;
	Tue,  2 Sep 2008 17:59:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 996F95AFDD; Tue,  2 Sep 2008 17:58:57 -0400 (EDT)
In-Reply-To: <200809022339.20123.johan@herland.net> (Johan Herland's message
 of "Tue, 02 Sep 2008 23:39:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A77885E-793A-11DD-A8E6-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94724>

Johan Herland <johan@herland.net> writes:

> On Tuesday 02 September 2008, Stephan Beyer wrote:
>> Junio C Hamano wrote:
>> > Pieter de Bie <pdebie@ai.rug.nl> writes:
>> > > Vienna:git pieter$ ./git commit --allow-empty -m"test"
>> > > Created commit 6ce62c8b: test
>> > > You are on a detached head, so this commit has not been recorded in a
>> > > branch. If you don't want to lose this commit, checkout a branch and
>> > > then run: git merge 6ce62c8bfcfb341106f3587d1c141c3955c2544c
>> > >
>> > > Are there any comments to this / strong opinions against such a
>> > > change?
>> >
>> > Unconditionally doing this is too loud for my taste.  You probably can
>> > do this in your post-commit hook.
>>
>> Well, Pieter probably can do this in his post-commit hook. But I think
>> this is useful for usability... especially for beginners who might not
>> even know what a hook is. ;)
>
> I'm not sure I like this personally, but if we _really_ don't want newbies 
> to shoot themselves in the foot, we could make "git commit" fail on a 
> detached HEAD unless the user has indicated that s/he knows what's going 
> on; i.e. something like this:

If we _really_ don't want newbies to shoot themselves in the foot, we
probably can issue a loud warning when they detach there HEAD.

Oh, wait,... we already do that.
