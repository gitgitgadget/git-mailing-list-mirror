From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] New date format: local_original
Date: Wed, 7 Oct 2009 19:31:39 -0400
Message-ID: <20091007233139.GB22533@coredump.intra.peff.net>
References: <200910062209.47606.tuomas.suutari@gmail.com>
 <20091007125427.GA20067@coredump.intra.peff.net>
 <7vocojrn26.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tuomas Suutari <tuomas.suutari@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 01:33:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvg0D-0000sU-Hj
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 01:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbZJGXcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 19:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbZJGXcU
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 19:32:20 -0400
Received: from peff.net ([208.65.91.99]:53998 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753936AbZJGXcT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 19:32:19 -0400
Received: (qmail 2424 invoked by uid 107); 7 Oct 2009 23:35:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 07 Oct 2009 19:35:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Oct 2009 19:31:39 -0400
Content-Disposition: inline
In-Reply-To: <7vocojrn26.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129664>

On Wed, Oct 07, 2009 at 01:01:05PM -0700, Junio C Hamano wrote:

> I think "--date=iso --local-dates-too" is still not orthogonal enough, let
> alone "local_original" which invites "Why is this combination supported
> and not this, that, and 47 others?" questions.
> 
> I however do not think it is so bad an idea to allow something like:
> 
> 	git log --date='custom:%Y-%m-%d ...'
> 	git log --date=custom	;# looks at "date.custom" config

Thanks, that (and the %{local} bit) is a much better suggestion than
mine, I think.

-Peff
