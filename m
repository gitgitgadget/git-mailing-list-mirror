From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking repository
Date: Sun, 16 Mar 2008 14:57:08 -0700
Message-ID: <7vwso2gwnf.fsf@gitster.siamese.dyndns.org>
References: <frh8dg$t9j$1@ger.gmane.org>
 <7vabkzmltc.fsf@gitster.siamese.dyndns.org> <1205697779.12760.20.camel@duo>
 <7vwso2ieuu.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803161716470.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kenneth johansson <ken@kenjo.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 22:58:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb0rt-0002Y7-V1
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 22:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbYCPV50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 17:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbYCPV50
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 17:57:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46522 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbYCPV5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 17:57:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 79D7B1A81;
	Sun, 16 Mar 2008 17:57:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 938D71A80; Sun, 16 Mar 2008 17:57:17 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803161716470.19665@iabervon.org> (Daniel
 Barkalow's message of "Sun, 16 Mar 2008 17:28:36 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77390>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I'm not sure any older code actually enforced this, either

I am fairly sure the old code was written with the intention in mind (I
wrote it, in other words).  It meant to accept refs/<anything>/* and no
other wildcard.

Does your patch require * to be at the end?
