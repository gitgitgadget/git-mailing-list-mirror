From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Third try at documenting command integration
 requirements.
Date: Tue, 27 Nov 2012 22:36:39 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121128033639.GC1669@thyrsus.com>
References: <20121126053557.E56434065F@snark.thyrsus.com>
 <7vzk24qgjx.fsf@alter.siamese.dyndns.org>
 <20121126214134.GA1713@thyrsus.com>
 <50B4A8E1.7050801@alum.mit.edu>
 <20121127175618.GA11845@thyrsus.com>
 <7vobiijxol.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 04:37:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdYSK-0000Ak-IC
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047Ab2K1Dgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:36:45 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:59001
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879Ab2K1Dgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:36:44 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 0925340665; Tue, 27 Nov 2012 22:36:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vobiijxol.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210692>

Junio C Hamano <gitster@pobox.com>:
> I won't worry about Python 3 yet; in what timeframe did Python's
> i18n/unicode support become usable?  In 2.4, or 2.6?

Er, it depends on what you consider "usable".

Unicode integration turned out to have a lot messier edge cases than
anyone understood going in.  First-cut support was in 1.6, but I'd say
it still has some pretty sharp edges *today*.  Which is why 3.0 has
gone all-Unicode-all-the-time.  The problems mostly come from having
two different notions of "string" that don't really mix well.

Me, I still avoid the hell out of Unicode in Python.  And occasionally
fund myself cursing a library maintainer who didn't.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
