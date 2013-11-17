From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 00/86] replace prefixcmp() with has_prefix()
Date: Sun, 17 Nov 2013 09:52:00 +0100 (CET)
Message-ID: <20131117.095200.299497690980619465.chriscool@tuxfamily.org>
References: <xmqq7gcdgvmf.fsf@gitster.dls.corp.google.com>
	<20131113.074703.1555957018827670255.chriscool@tuxfamily.org>
	<20131113071747.GA31251@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, ae@op5.se, git@vger.kernel.org,
	apenwarr@gmail.com, Johannes.Schindelin@gmx.de, jrnieder@gmail.com,
	max@quendi.de
To: peff@peff.net
X-From: git-owner@vger.kernel.org Sun Nov 17 09:52:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhy5S-00041Q-R7
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 09:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab3KQIwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 03:52:07 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:61779 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794Ab3KQIwE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 03:52:04 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id AAB096C;
	Sun, 17 Nov 2013 09:52:00 +0100 (CET)
In-Reply-To: <20131113071747.GA31251@sigill.intra.peff.net>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237952>

From: Jeff King <peff@peff.net>
>
> On Wed, Nov 13, 2013 at 07:47:03AM +0100, Christian Couder wrote:
> 
>> My preference is:
>> 
>> 1) with an "s"
>> 2) "start"
>> 3) underscore
>> 
>> so that gives: starts_with() and ends_with()
> 
> FWIW, that looks good to me, too. Whether there is confusion over the
> meaning of "suffix" or not, it makes sense, all other things being
> equal, to use the same terms as other popular languages.
> 
> Like you, I prefer "with an s", but we are deep in bikeshedding
> territory now. I can live with anything. :)

When I prepared a new version of my patch series, this time to rename
suffixcmp() to ends_with(), it appeared that we already have a static
ends_with() function in vcs-svn/fast_export.c with another slightly
different implementation :-)

I will send a new version that will remove this redundant
implementation.

Cheers,
Christian.
