From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: format-patch has no --mbox option
Date: Mon, 14 May 2007 17:20:47 -0700
Message-ID: <7vveevkkdc.fsf@assigned-by-dhcp.cox.net>
References: <1179153893715-git-send-email-frank@lichtenheld.de>
	<11791538941530-git-send-email-frank@lichtenheld.de>
	<7v8xbrlzqk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue May 15 02:20:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnkmb-0004m2-SV
	for gcvg-git@gmane.org; Tue, 15 May 2007 02:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199AbXEOAUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 20:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756691AbXEOAUs
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 20:20:48 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:46163 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbXEOAUs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 20:20:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070515002047.HJHY14313.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 14 May 2007 20:20:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zCLn1W00L1kojtg0000000; Mon, 14 May 2007 20:20:47 -0400
In-Reply-To: <7v8xbrlzqk.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 14 May 2007 17:03:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47305>

Junio C Hamano <junkio@cox.net> writes:

> Frank Lichtenheld <frank@lichtenheld.de> writes:
>
>> git-applymbox and git-mailinfo refer to a --mbox
>> option of git-format-patch. But there is no such
>> option AFAICT. mbox output can produced with
>> format-patch --stdout.
>>
>> This patch only replaces --mbox with --stdout.
>> Some further explanation and/or format-patch
>> arguments (e.g. -k) might be needed.
>
> I would agree.  "Reads single mbox with one or more patches in
> it, without munging the subject line" is what it really does, so
> we obviously mean "--stdout -k >mbox" here.

Come to think of it, "no munging of Subject lines" is orthogonal
to the number of patches in a file, so it should say that the
option corresponds to -k in format-patch, I think.

So, I think we can just do s/--mbox/-k/, instead of s/--mbox/--stdout/
which is what you did.
