From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RESEND PATCH 1/2] Fix builtin-fetch memory corruption by not overstepping array
Date: Fri, 14 Sep 2007 16:43:15 -0700
Message-ID: <7vr6l095kc.fsf@gitster.siamese.dyndns.org>
References: <20070914225953.GC16512@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 15 01:43:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWKoo-0007se-8O
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 01:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758670AbXINXnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 19:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758677AbXINXnV
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 19:43:21 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758512AbXINXnU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 19:43:20 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 49D4E1350D5;
	Fri, 14 Sep 2007 19:43:39 -0400 (EDT)
In-Reply-To: <20070914225953.GC16512@spearce.org> (Shawn O. Pearce's message
	of "Fri, 14 Sep 2007 18:59:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58212>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>  *** RESEND TO CORRECT FROM+SBO ***
>
>  Sorry Junio.  I realized too late that the headers were wrong.
>  That's what I get for not configuring ~/.gitconfig on my amd64
>  Linux box.  ;-)

Actually this might have been a good thing, according to Linus.
It is an evidence that you built and tested that change on the
"blink" box not your usual box.
