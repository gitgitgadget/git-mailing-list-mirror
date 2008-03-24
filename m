From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What I miss from Cogito...
Date: Sun, 23 Mar 2008 19:53:37 -0700
Message-ID: <7vtziw3k9a.fsf@gitster.siamese.dyndns.org>
References: <47E69044.3000207@zytor.com> <20080323173841.GA24943@mit.edu>
 <20080323182102.GA22551@bit.office.eurotux.com>
 <87r6e1b6c8.fsf@mid.deneb.enyo.de> <20080324001617.GB24943@mit.edu>
 <20080324014030.GA24695@atjola.homenet> <20080324021411.GE24943@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Mar 24 03:54:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdcpf-0006xi-2g
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 03:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbYCXCxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 22:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbYCXCxy
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 22:53:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbYCXCxx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 22:53:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5FDDB1F9D;
	Sun, 23 Mar 2008 22:53:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C26BE1F9B; Sun, 23 Mar 2008 22:53:44 -0400 (EDT)
In-Reply-To: <20080324021411.GE24943@mit.edu> (Theodore Tso's message of
 "Sun, 23 Mar 2008 22:14:11 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77996>

Theodore Tso <tytso@MIT.EDU> writes:

>        git-checkout - Checkout and switch to a branch
>
> At the very least, will you admit that the summary in the man page is
> perhaps just a wee bit misleading?

It's not "wee bit misleading" but it just is outright stale.

Back then, before people realized the operation "to check out the path out
of index or tree-ish" belongs naturally to a command whose name is
"checkout", "to check out the named branch or a commit" was the only thing
that you could do with the command.  The one-line description you quoted
above reflects that history.

Patches very much welcome; I did not notice it was kept stale.
