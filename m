From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Feature request: git-svn dcommit should send deltas upstream
Date: Sun, 31 Aug 2008 19:13:04 +0200
Message-ID: <871w05kt0f.fsf@mid.deneb.enyo.de>
References: <87myj0f3mb.fsf@mid.deneb.enyo.de>
	<20080829082311.GA7128@yp-box.dyndns.org>
	<87tzd4p1lt.fsf@mid.deneb.enyo.de> <87y72dkvq4.fsf@mid.deneb.enyo.de>
	<7vsksl2k1y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 19:14:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZqVD-0003QV-Q6
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 19:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYHaRNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 13:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbYHaRNJ
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 13:13:09 -0400
Received: from mail.enyo.de ([212.9.189.167]:50829 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752560AbYHaRNI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 13:13:08 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1KZqU4-0003tw-Sh; Sun, 31 Aug 2008 19:13:04 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1KZqU4-0003n6-Dr; Sun, 31 Aug 2008 19:13:04 +0200
In-Reply-To: <7vsksl2k1y.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 31 Aug 2008 10:03:53 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94496>

* Junio C. Hamano:

>> Sorry for the format.  Has anybody got some Emacs code to submit diffs
>> using Gnus?
>
> What's wrong with using "C-x C-i" in the message mode to read format-patch
> output in (alternatively "C-u M-! git format-patch --stdout -1 $commit"
> in the message mode), move "Subject: " up and remove the remainder of the
> fake headers?

For single patches, it's okay.  Using this approach, proper threading of
a series of patches is rather error-prone, though.
