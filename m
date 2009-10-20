From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Makefile: set PERL_PATH and SHELL_PATH unconditionally
Date: Tue, 20 Oct 2009 09:33:07 -0700
Message-ID: <20091020163307.GA5208@ftbfs.org>
References: <7vr5syshat.fsf@alter.siamese.dyndns.org> <1256029588-24128-1-git-send-email-kraai@ftbfs.org> <7vtyxuox7u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 19:01:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0I5L-0006iS-5K
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 19:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbZJTRBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 13:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbZJTRBN
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 13:01:13 -0400
Received: from neon.ftbfs.org ([83.168.236.214]:46293 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbZJTRBM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 13:01:12 -0400
X-Greylist: delayed 1687 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Oct 2009 13:01:12 EDT
Received: from kraai by neon.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1N0Hdz-0001MR-3N; Tue, 20 Oct 2009 09:33:07 -0700
Content-Disposition: inline
In-Reply-To: <7vtyxuox7u.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130815>

On Tue, Oct 20, 2009 at 09:18:29AM -0700, Junio C Hamano wrote:
> Matt Kraai <kraai@ftbfs.org> writes:
> 
> > Do not check whether PERL_PATH and SHELL_PATH are undefined before
> > setting their default values.  This prevents them from being set via
> > environment variables.
> 
> Is there an upside of "preventing them from getting set", by the way?

Not that I know of.

I originally thought that the checks were superfluous, but now I just
believe they're inconsistent and confusing to people like me who think
they understand Makefiles but don't.  :)

-- 
Matt Kraai                                             http://ftbfs.org/
