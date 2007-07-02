From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Mon, 02 Jul 2007 16:11:20 -0700
Message-ID: <7vwsxiwgdj.fsf@assigned-by-dhcp.cox.net>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz>
	<31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com>
	<20070629040328.GG29279@thunk.org> <20070702020401.GD28917@thunk.org>
	<7v1wfr1qn8.fsf@assigned-by-dhcp.cox.net>
	<20070702030521.GA4798@thunk.org>
	<7vr6nrz9yx.fsf@assigned-by-dhcp.cox.net>
	<20070702144800.GA4720@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Sewall <jasonsewall@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 03 01:11:41 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5V3O-00086c-0J
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 01:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756962AbXGBXLW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 19:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756517AbXGBXLW
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 19:11:22 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:60681 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002AbXGBXLV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 19:11:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070702231120.KDMH22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Jul 2007 19:11:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JnBL1X0021kojtg0000000; Mon, 02 Jul 2007 19:11:20 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51425>

Theodore Tso <tytso@mit.edu> writes:

> On Sun, Jul 01, 2007 at 09:49:10PM -0700, Junio C Hamano wrote:
>> The reason I personally use emacsclient is not about the
>> start-up delay, but with the access to existing buffers,
>> keyboard macros, Gnus buffers, ... IOW the access to the
>> "session" while editing.  I suspect people with long running
>> Emacs session use emacsclient for that reason.
>
> Sure, but do you need access to existing buffers, keyboard, macros,
> etc., if you're simply firing up an emacs to handle a merge conflict?
>
> If the goal is just to run a merge application, then firing up a
> separate process makes a lot more sense.

Existing buffers may help somewhat as I am likely to have that
already loaded, but other than that probably not.

> In my mind it's on the hairy edge. Alternatively we just never use
> ediff by default, and assume that either expert users can hack their
> .emacs.el file to have the right overrides will use ediff, or who are
> willing to put up with ediff's user-hostile approach to quitting an
> merge session.

I think that is sane.
