From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-am: Clean up the asciidoc documentation
Date: Mon, 14 May 2007 17:01:38 -0700
Message-ID: <7vd513lztp.fsf@assigned-by-dhcp.cox.net>
References: <1179153893715-git-send-email-frank@lichtenheld.de>
	<11791538941022-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue May 15 02:02:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnkUN-0001yF-0W
	for gcvg-git@gmane.org; Tue, 15 May 2007 02:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755222AbXEOAB5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 20:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755289AbXEOAB5
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 20:01:57 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36942 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222AbXEOAB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 20:01:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070515000153.GYXK14313.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 14 May 2007 20:01:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zC1f1W00X1kojtg0000000; Mon, 14 May 2007 20:01:51 -0400
In-Reply-To: <11791538941022-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Mon, 14 May 2007 16:44:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47301>

Frank Lichtenheld <frank@lichtenheld.de> writes:

>  -i, --interactive::
> -	Run interactively, just like git-applymbox.
> +	Run interactively, just like `git-applymbox` (see gitlink:git-applymbox[1]).

This is an unclear description from the original, but I think we
should say just like `git-applybox -i`, or drop this altogether.

> @@ -99,7 +102,7 @@ message, and commit author time is taken from the "Date: " line
>  of the message.  The "Subject: " line is used as the title of
>  the commit, after stripping common prefix "[PATCH <anything>]".
>  It is supposed to describe what the commit is about concisely as
> -a one line text.
> +an one line text.

I think 'one' does not begin with a vowel.

Other than that, I would agree everything in your update is a
clear improvement.
