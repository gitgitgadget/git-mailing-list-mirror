From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: wrap cover-letter's shortlog sensibly
Date: Sun, 02 Mar 2008 09:05:59 -0800
Message-ID: <7vejatoy2w.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site>
 <7vwsoofrue.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802282104500.19665@iabervon.org>
 <alpine.LSU.1.00.0802291118540.22527@racer.site>
 <alpine.LSU.1.00.0803021511420.22527@racer.site>
 <alpine.LSU.1.00.0803021531230.22527@racer.site>
 <alpine.LSU.1.00.0803021552210.22527@racer.site>
 <alpine.LSU.1.00.0803021553090.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 18:07:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVreJ-0004pP-8G
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 18:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbYCBRGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 12:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754370AbYCBRGQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 12:06:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754246AbYCBRGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 12:06:16 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2746214EF;
	Sun,  2 Mar 2008 12:06:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 76E7614EE; Sun,  2 Mar 2008 12:06:08 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0803021553090.22527@racer.site> (Johannes
 Schindelin's message of "Sun, 2 Mar 2008 15:53:39 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75810>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Earlier, overly-long onelines would not be wrapped at all, and indented
> with 6 spaces.
>
> Instead, we now wrap around at 72 characters, with a first-line indent
> of 2 spaces, and the rest with 4 spaces (like the "What's in" messages
> of Junio).

Heh, I seem to personally use 76,2,4 but otherwise I think this makes it
easier to read.  Thanks.
