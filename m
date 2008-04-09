From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is my repository broken?
Date: Tue, 08 Apr 2008 23:50:20 -0700
Message-ID: <7vbq4jcyj7.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0804082246160.8753@kaos.quantumfyre.co.uk>
 <20080408225522.GD10274@spearce.org>
 <Pine.LNX.4.64.0804090003480.10813@kaos.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 09 08:51:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjU9Y-0002PH-Ty
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 08:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbYDIGug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 02:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbYDIGug
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 02:50:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYDIGuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 02:50:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 616B8135F4;
	Wed,  9 Apr 2008 02:50:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C27CE135F1; Wed,  9 Apr 2008 02:50:29 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79078>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> On Tue, 8 Apr 2008, Shawn O. Pearce wrote:
>
>> The same holds true for the empty ident.
>
> Ok - but I can't even find a note in the manpage for this one ...

That's not a fair complaint.

It is often very hard to document that "we do not do X", because the line
to stop at becomes fuzzier as you try to do more thorough job.  We do not
warn on empty ident, we do not warn on typos in commit log messages, we do
not warn on empty blob, we do not warn on ...  You get the idea.
