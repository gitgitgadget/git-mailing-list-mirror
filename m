From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Could this be done simpler?
Date: Fri, 26 Jun 2009 00:55:23 +0200
Message-ID: <200906260055.23929.chriscool@tuxfamily.org>
References: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain> <200906260023.03169.chriscool@tuxfamily.org> <7vprcsymjd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 00:55:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJxqh-00062S-02
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 00:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189AbZFYWzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 18:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754951AbZFYWzI
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 18:55:08 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:51077 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753416AbZFYWzH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 18:55:07 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 76B51818057;
	Fri, 26 Jun 2009 00:55:02 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 96721818052;
	Fri, 26 Jun 2009 00:55:00 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vprcsymjd.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122255>

On Friday 26 June 2009, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> >> If someone creates a "git decompose-octopus <commit>" command then ...
>
> I am afraid that misses the entire point of my discussion.
>
> Such a decomposed octopus would _only_ be necessary during bisection,
> only when the user chooses to test two tips at once (instead of testing
> one by one), _and_ only its tree is needed for that purpose.  In other
> words, we should be able to do this _without_ creating an extra commit,
> let alone replace mechanism.

But suppose the result from the bisection tells that M1 is the first bad 
commit, then the user will need to look at M1, and perhaps check it out or 
use it in other ways after the bisection is finished. So why shouldn't it 
be a real commit?

It's not like a few more commits are a big problem as they will be reclaimed 
by garbage collection anyway if the replace ref is deleted.

Best regards,
Christian.
