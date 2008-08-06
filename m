From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] perl/Makefile: handle paths with spaces in the NO_PERL_MAKEMAKER
 section
Date: Wed, 06 Aug 2008 17:16:14 -0500
Message-ID: <1JOFfIWYHgmUErPhpB6xWtV5uZYv3_v3tBnt928x644O-1AquEzzIA@cipher.nrlssc.navy.mil>
References: <mLu74vNKfH1vFZlC7N_lRX3WekWReoVjWY42voUDUBUnAGVpDNYWndWqlaHoqVAkxOaCdYV6uDk@cipher.nrlssc.navy.mil> <osgPH47FO7h-zLUMqwCv-i9BWln2-_AK5T6TI-5mLGFjwAhJ4Bg_lw@cipher.nrlssc.navy.mil> <7v8wvbuit7.fsf@gitster.siamese.dyndns.org> <klGWkbWGpsUHZpuNwl9WvZs5UGGfYVAngWbiM3eippaejrXLNyLpRA@cipher.nrlssc.navy.mil> <7v7iaurwe4.fsf@gitster.siamese.dyndns.org> <lh6XIUcjpbjj8G8Ot7RQFlDitUn1njsc350QhnNmQkcgxlfluBPGZw@cipher.nrlssc.navy.mil> <7vy739nbmp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 00:17:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQrJv-0001Xi-4v
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 00:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbYHFWQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 18:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbYHFWQT
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 18:16:19 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55384 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbYHFWQT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 18:16:19 -0400
Received: by mail.nrlssc.navy.mil id m76MGFNA019315; Wed, 6 Aug 2008 17:16:15 -0500
In-Reply-To: <7vy739nbmp.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 06 Aug 2008 22:16:15.0300 (UTC) FILETIME=[0AB82840:01C8F812]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91545>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> There are problems here with spaces, single quotes, and double quotes.
>> I'll follow up in another email.
> 
> I guess we've opened up a large can of worms.  Let's have the minimum fix
> that says "We do support whitespace in these paths but no other funnies"
> and leave the more intrusive one for post 1.6.0, for now.

I think those two patches I just sent are enough.

You can apply the double-quote escaping patch I sent earlier if you want
(the one that escapes double quotes in the macros compiled in c programs).
But we'd have a problem installing the perl scripts using MakeMaker, and
we'd have a problem _running_ the perl scripts since the single double
quote causes a syntax error in the perl script. Let's wait till someone
wants to have " in their path shows up (and let them figure out how to
fix it).

-brandon
