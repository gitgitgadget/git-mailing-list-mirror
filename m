From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v2 2/2] Move git-dir for submodules
Date: Tue, 9 Aug 2011 20:23:33 +0200
Message-ID: <20110809182332.GD42153@book.hvoigt.net>
References: <1312831022-12868-1-git-send-email-iveqy@iveqy.com> <1312831022-12868-3-git-send-email-iveqy@iveqy.com> <20110808204439.GA41500@book.hvoigt.net> <7v1uwvwpsk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 20:23:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqqxs-0007m1-O8
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 20:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297Ab1HISXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 14:23:39 -0400
Received: from darksea.de ([83.133.111.250]:59378 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750942Ab1HISXi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 14:23:38 -0400
Received: (qmail 16823 invoked from network); 9 Aug 2011 20:23:33 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 9 Aug 2011 20:23:33 +0200
Content-Disposition: inline
In-Reply-To: <7v1uwvwpsk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179038>

Hi,

On Mon, Aug 08, 2011 at 02:34:35PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > Hi,
> >
> > On Mon, Aug 08, 2011 at 09:17:02PM +0200, Fredrik Gustafsson wrote:
> >> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> >> index c679f36..1ae6b4e 100755
> >> --- a/t/t7406-submodule-update.sh
> >> +++ b/t/t7406-submodule-update.sh
> >> @@ -408,6 +408,7 @@ test_expect_success 'submodule update exit immediately in case of merge conflict
> >>  	 test_cmp expect actual
> >>  	)
> >>  '
> >> +
> >
> > There is a whitespace error here which we seem to have overlooked. Junio
> > could you remove that?
> 
> Hmm, confused.
> 
> A blank between test would be the perfectly normal thing to see, no?

Yes indeed you are right I did just see the lonely new line here. I
missed that a blank line was missing previously here.

Cheers Heiko
