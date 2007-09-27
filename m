From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Create .dotest-merge after validating options.
Date: Thu, 27 Sep 2007 07:03:13 -0700
Message-ID: <20070927140312.GA4499@ftbfs.org>
References: <1190770213-8651-1-git-send-email-kraai@ftbfs.org> <7vfy10woqi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 16:03:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iatxw-0004yi-JG
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 16:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932AbXI0ODh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 10:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbXI0ODh
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 10:03:37 -0400
Received: from neon.ftbfs.org ([83.168.236.214]:45715 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224AbXI0ODg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 10:03:36 -0400
Received: from pool-71-104-149-201.lsanca.dsl-w.verizon.net ([71.104.149.201] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1IauEX-0005WF-6R; Thu, 27 Sep 2007 07:20:56 -0700
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.67)
	(envelope-from <kraai@ftbfs.org>)
	id 1IatxR-0003or-7i; Thu, 27 Sep 2007 07:03:13 -0700
Content-Disposition: inline
In-Reply-To: <7vfy10woqi.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Score: -4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59300>

On Thu, Sep 27, 2007 at 12:29:09AM -0700, Junio C Hamano wrote:
> Matt Kraai <kraai@ftbfs.org> writes:
> 
> > Creating .dotest-merge before validating the options prevents both
> > --continue and --interactive from working if the options are invalid,
> > so only create it after validating the options.
> 
> Thanks.  Will apply with a minor fixup.  Next time, please make
> sure the testsuite passes before submitting.

Will do, thanks.

-- 
Matt
