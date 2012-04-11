From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (bugfix)] gitweb: Fix unintended "--no-merges" for regular Atom feed
Date: Wed, 11 Apr 2012 17:39:06 +0200
Message-ID: <201204111739.07765.jnareb@gmail.com>
References: <4F79D76D.80805@pipping.org> <7v62df9yo5.fsf@alter.siamese.dyndns.org> <201204042058.32549.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sebastian Pipping <sebastian@pipping.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 17:39:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHzdi-0007PQ-Fd
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 17:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759004Ab2DKPjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 11:39:17 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:57870 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758470Ab2DKPjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 11:39:16 -0400
Received: by wejx9 with SMTP id x9so639014wej.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 08:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=T6RF4PPP60j1zCLZDDffgAL6LAKL5FhjgksVjK+4Ybg=;
        b=rOE6SnRmJ7tsRm+r8Kl315hidTvDlEYEPH+lhIJKwXrP1SFHCc3Ha4XFMpJlkoGUCu
         PM6kJ1Zai6M64yFKWKGHP1bc63tqR1gILN28zo7bNE2lLIyY/v5OYPK7S4cXv6X6LnpQ
         oXFcTxjYC2E2gwwNSXXobDiTV53LPHypUplluq3OUWRE3oTF+8wU2RT95dT/biwdemR7
         1di9WKoZdUCavW+H8mrGNT4YzU1a+QzGng98yr7mUftiPIO+Z8Wm/ujxoyG70DsQPqB8
         xoEIskYFjIjk9OjO3gz9IfJr0c1NET+QirUSVjTUnryUB7sJdLHMdUtEy3sTXrNjX4mP
         Oq3g==
Received: by 10.216.194.102 with SMTP id l80mr4469978wen.1.1334158755193;
        Wed, 11 Apr 2012 08:39:15 -0700 (PDT)
Received: from [192.168.1.13] (acxc116.neoplus.adsl.tpnet.pl. [83.11.160.116])
        by mx.google.com with ESMTPS id fz9sm45643537wib.3.2012.04.11.08.39.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 08:39:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201204042058.32549.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195191>

On Wed, 4 April 2012, Jakub Narebski wrote:
> Junio C Hamano wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:
> > 
> > > Junio, the bug is very minor, so I don't know if it is worth fixing
> > > for 1.7.10.
> > 
> > Does this exist in 1.7.9.x maintenance track?  If it is an old bug, I do
> > not think it should go to 1.7.10 proper (perhaps 1.7.10.1) this late, and
> > if it is a bug in a new feature added for 1.7.10, we may want to fix it
> > before the final, as the impact of the patch seems very minor.
> 
> It is an old bug, from 05bb5a2 (gitweb: Include links to feeds in HTML
> header only for '200 OK' response, 2010-12-18) which refactored feed link
> generation into print_feed_meta().  It is in gitweb since v1.7.4 I think.
> 
> So 1.7.10.1 it is...

Ping!

I don't see this trivial fix (admittedly for obscure bug) in "What's
cooking", and it is not present in 'master'.
 
> > >  gitweb/gitweb.perl |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)

-- 
Jakub Narebski
Poland
