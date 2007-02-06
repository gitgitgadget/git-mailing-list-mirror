From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: add KMail in SubmittingPatches
Date: Mon, 05 Feb 2007 19:07:40 -0800
Message-ID: <7vveigkmpv.fsf@assigned-by-dhcp.cox.net>
References: <7v1wl7bv66.fsf@assigned-by-dhcp.cox.net>
	<200702041716.39999.robin.rosenberg.lists@dewire.com>
	<7vlkjdr8hj.fsf@assigned-by-dhcp.cox.net>
	<200702051427.32532.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Tue Feb 06 04:07:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEGgM-0003jH-C2
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 04:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbXBFDHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 22:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbXBFDHm
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 22:07:42 -0500
Received: from fed1rmmtai16.cox.net ([68.230.241.43]:58842 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965165AbXBFDHl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 22:07:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070206030740.UYYC1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Feb 2007 22:07:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L37g1W00V1kojtg0000000; Mon, 05 Feb 2007 22:07:40 -0500
In-Reply-To: <200702051427.32532.barra_cuda@katamail.com>
	(barra_cuda@katamail.com's message of "Mon, 5 Feb 2007 14:27:32
	+0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38805>

Michael <barra_cuda@katamail.com> writes:

> @@ -331,3 +330,21 @@ whitespaces (fatal in patches).  Running 'C-u g' to 
> display the
>  message in raw form before using '|' to run the pipe can work
>  this problem around.
>  
> +
> +KMail
> +-----
> +
> +This should help you to submit patches inline using KMail.
> +
> +1) Prepare the patch as a text file.
> +
> +2) Click on New Mail.
> +
> +3) Go under "Options" in the Composer window and be sure that
> +"Word wrap" is not set.
> +
> +4) Use Message -> Insert file... and insert the patch.
> +
> +5) Back in the compose window: add whatever other text you wish to the
> +message, complete the addressing and subject fields, and press send.
> +

This is quite interesting -- notice your own hunk header @@ ... @@ line?

I do not use KMail myself, so I cannot comment on the procedure,
but from the cursory look it *should* do the right thing.  Only
that it makes me a bit nervous to see your hunk header being
line wrapped.

Doubly interesting is that somebody appears to have added two
message IDs.

   Subject: [PATCH] Documentation: add KMail in SubmittingPatches
   Date:	Mon, 5 Feb 2007 14:27:32 +0100
   User-Agent: KMail/1.9.4
   Message-Id: <200702051427.32532.barra_cuda@katamail.com>
   Message-ID: <20070205132150.123659@dial-up-mi-449.lombardiacom.it>
