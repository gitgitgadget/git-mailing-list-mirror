From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCHv2 2/2] Add url.<base>.pushInsteadOf: URL rewriting for
 push only
Date: Tue, 8 Sep 2009 00:15:14 -0700
Message-ID: <20090908071513.GA3236@feather>
References: <cover.1252313313.git.josh@joshtriplett.org>
 <5e58748923d9b4a182499a6ba8fa4636bce4810e.1252313313.git.josh@joshtriplett.org>
 <7vws49gbql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 09:15:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkuvO-0005ou-N3
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 09:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbZIHHP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 03:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753728AbZIHHPZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 03:15:25 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:47016 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbZIHHPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 03:15:25 -0400
Received: from feather (pool-173-50-250-234.ptldor.fios.verizon.net [173.50.250.234])
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 1AC84225173;
	Tue,  8 Sep 2009 09:14:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vws49gbql.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127982>

On Tue, Sep 08, 2009 at 12:02:42AM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > This configuration option allows systematically rewriting fetch-only
> > URLs to push-capable URLs when used with push.  For instance:
> >
> > [url "ssh://example.org/"]
> >     pushInsteadOf = "git://example.org/"
> >
> > This will allow clones of "git://example.org/path/to/repo" to
> > subsequently push to "ssh://example.org/path/to/repo", without manually
> > configuring pushurl for that remote.
> >
> > Includes documentation for the new option, bash completion updates, and
> > test cases (both that pushInsteadOf applies to push and that it does
> > *not* apply to fetch).
> 
> Thanks.
> 
> I will queue these patches, but I presume you would also want to add a
> test that pushInsteadOf is ignored for remotes with an explicit pushURL?

Will do.

- Josh Triplett
