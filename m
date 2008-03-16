From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking repository
Date: Sun, 16 Mar 2008 15:30:27 -0700
Message-ID: <7vzlsyfgjg.fsf@gitster.siamese.dyndns.org>
References: <frh8dg$t9j$1@ger.gmane.org>
 <7vabkzmltc.fsf@gitster.siamese.dyndns.org> <1205697779.12760.20.camel@duo>
 <7vwso2ieuu.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803161716470.19665@iabervon.org>
 <7vwso2gwnf.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803161812340.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kenneth johansson <ken@kenjo.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 23:31:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb1Ns-0003rG-KW
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 23:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbYCPWah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 18:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbYCPWag
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 18:30:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbYCPWag (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 18:30:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D4FCC24A1;
	Sun, 16 Mar 2008 18:30:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B3ACF247B; Sun, 16 Mar 2008 18:30:30 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803161812340.19665@iabervon.org> (Daniel
 Barkalow's message of "Sun, 16 Mar 2008 18:18:58 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77395>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Is "refs/*:refs/*" (mirror everything, including weird stuff) supposed to 
> be prohibited?

No.  In fact "remote add --mirror" actively creates such.  See my other
message about design level issues.

>> Does your patch require * to be at the end?
>
> Looks like it just ignores anything after a *. Want checks for that as 
> well?

Surely.  Starting strict and making it looser later is much easier than
starting loose and incoherent and having to deal with the resulting mess
the code appears to allow people to make in their configuration.
