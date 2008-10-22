From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 2/3] Add -n/--no-prompt option to mergetool
Date: Wed, 22 Oct 2008 22:17:20 +0100
Message-ID: <20081022211720.GA23146@hashpling.org>
References: <1224583999-26279-1-git-send-email-charles@hashpling.org> <1224583999-26279-2-git-send-email-charles@hashpling.org> <48FDC1CA.2080800@op5.se> <20081021122655.GA29294@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	William Pursell <bill.pursell@gmail.com>,
	Andreas Ericsson <ae@op5.se>, "Theodore Ts'o" <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 23:19:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksl6h-0001xP-CX
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 23:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbYJVVRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 17:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbYJVVRr
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 17:17:47 -0400
Received: from ptb-relay02.plus.net ([212.159.14.146]:47283 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbYJVVRq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 17:17:46 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1Ksl5G-0006oM-BQ; Wed, 22 Oct 2008 22:17:41 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m9MLHSY4023630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Oct 2008 22:17:28 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m9MLHKII023629;
	Wed, 22 Oct 2008 22:17:20 +0100
Content-Disposition: inline
In-Reply-To: <20081021122655.GA29294@hashpling.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 0410ccc58260ce6a1afe5f91f7d25822
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98915>

On Tue, Oct 21, 2008 at 01:26:55PM +0100, Charles Bailey wrote:
> On Tue, Oct 21, 2008 at 01:49:30PM +0200, Andreas Ericsson wrote:
> >
> > There is discussion already about "-n should be for dry-run!" and git's
> > inconsistencies in such matters. Wouldn't -y ("assume yes on prompt")
> > be better?
> >
> 
> I must have missed this discussion. I've just had a very quick look at
> a handful of basic modifying git commands (merge, pull, commit,
> checkout, reset, revert) and only found 'add' that used -n as
> --dry-run.
> 
> That said, I've no real objections to -y if that makes for a better
> consensus.
> 

I'm pretty keen on this patch, but have no strong opinions on which
short option is used, so are there any votes against -y?

If I re-roll with the favoured short option is there anything else
that would prevent its adoption into next or master?

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
