From: Miles Bader <miles@gnu.org>
Subject: Re: orthogonal cases of log --date option
Date: Fri, 06 Mar 2009 10:47:10 +0900
Message-ID: <87bpsffmn5.fsf@catnip.gol.com>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com>
	<7vtz6bdmfi.fsf@gitster.siamese.dyndns.org>
	<20090305104304.GA17760@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 02:48:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfPBE-0002P0-Ns
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 02:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbZCFBrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 20:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbZCFBrY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 20:47:24 -0500
Received: from main.gmane.org ([80.91.229.2]:43071 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678AbZCFBrY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 20:47:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LfP9k-00086r-RN
	for git@vger.kernel.org; Fri, 06 Mar 2009 01:47:20 +0000
Received: from 218.231.175.8.eo.eaccess.ne.jp ([218.231.175.8])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 01:47:20 +0000
Received: from miles by 218.231.175.8.eo.eaccess.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 01:47:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 218.231.175.8.eo.eaccess.ne.jp
System-Type: x86_64-unknown-linux-gnu
Cancel-Lock: sha1:R0ln+YcSbwoRurPr2+ji0nQAcHU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112367>

Jeff King <peff@peff.net> writes:
>   git log --local-dates --date=default
>
> This makes the interface simpler to understand: --date remains a
> selector, and --date=local is a special case that new people don't need
> to think about or understand.

I agree, a separate option is more clear.

I suppose (as Junio later commented) that an explicit "--date-tz" option
might be cool too, though I suppose 99% of the time, people would only
ever specify "--date-tz=local" or "--date-gz=gmt"...

[one use-case I can think of for a more general option would be
if you want to see a log from somebody else's point of view ... "when
was john in san francisco doing all that hacking?"]

-Miles

-- 
The trouble with most people is that they think with their hopes or
fears or wishes rather than with their minds.  -- Will Durant
