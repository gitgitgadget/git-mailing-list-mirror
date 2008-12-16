From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] gitweb: unify boolean feature subroutines
Date: Tue, 16 Dec 2008 06:23:57 -0800
Message-ID: <20081216142357.GF4529@ftbfs.org>
References: <7vabawu1ao.fsf@gitster.siamese.dyndns.org> <1229408179-7655-1-git-send-email-kraai@ftbfs.org> <7vmyewqypk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 15:25:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCarh-0003l0-Tm
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 15:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873AbYLPOYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 09:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754525AbYLPOYS
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 09:24:18 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:38416 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754444AbYLPOYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 09:24:18 -0500
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net ([71.119.193.199] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1LCaqD-0003FX-RS; Tue, 16 Dec 2008 06:24:09 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1LCaq5-0002ls-H8; Tue, 16 Dec 2008 06:23:57 -0800
Content-Disposition: inline
In-Reply-To: <7vmyewqypk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score-Int: -41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103282>

On Tue, Dec 16, 2008 at 01:03:03AM -0800, Junio C Hamano wrote:
> But a change to the function signature of feature subroutines is not
> something I'd like to apply while other series that want to add new
> features are still cooking.  How about doing these two patches as the
> first thing that goes to 'next' after 1.6.1, and then force other series
> rebase on top of your change?  Alternatively, we could make you wait until
> other series do settle in 'next' and then apply your change rebased on
> them, but I think that is probably less optimal.

OK, I'll resubmit the patches on top of 'next' once 1.6.1 is
released.  Thanks for your help,

-- 
Matt                                                 http://ftbfs.org/
