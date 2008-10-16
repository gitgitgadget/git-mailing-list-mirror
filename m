From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: What's in git.git (Oct 2008, #03; Tue, 14)
Date: Thu, 16 Oct 2008 10:21:24 -0500
Message-ID: <0my5lujnbpdG6sxrffMExwukINu2tasxBSH0E0xYQoe6y5yyFL0LNA@cipher.nrlssc.navy.mil>
References: <7vej2i7rt9.fsf@gitster.siamese.dyndns.org> <bsftmRx17krWBpVlulipoJEO1fWsD0hZfF3HOZcajX6GV66RKW8W6A@cipher.nrlssc.navy.mil> <20081016100805.GA20762@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Arjen Laarhoven <arjen@yaph.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mike Ralphson <mike@abacus.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 17:23:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqUhL-0005E4-07
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 17:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbYJPPWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 11:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754100AbYJPPWQ
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 11:22:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42329 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661AbYJPPWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 11:22:16 -0400
Received: by mail.nrlssc.navy.mil id m9GFLODr014943; Thu, 16 Oct 2008 10:21:25 -0500
In-Reply-To: <20081016100805.GA20762@sigill.intra.peff.net>
X-OriginalArrivalTime: 16 Oct 2008 15:21:24.0681 (UTC) FILETIME=[DA155B90:01C92FA2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98391>

Jeff King wrote:
> On Wed, Oct 15, 2008 at 10:35:30AM -0500, Brandon Casey wrote:
> 
>>   2) Do we want to stick with compat/regex on
>>
>>       Darwin: Arjen
>>      FreeBSD: Jeff
>>          AIX: Mike
>>
>>      now that the builtin funcname patterns have been converted to Extended
>>      Regular Expressions?
> 
> t4018 passes without compat/regex on FreeBSD. Is that a sufficient test?

I think so. t4018 makes sure all the patterns compile, and includes Arjen's test
for appropriate handling of the alternation operator.

Darwin, anyone?

-brandon
