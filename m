From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: git commit -v does not removes the patch
Date: Thu, 20 Nov 2008 14:09:28 +0100
Message-ID: <20081120130851.GA17608@neumann>
References: <adf1fd3d0811100720n52ac1d47id9b7f402412aa0d3@mail.gmail.com>
	<20081110181023.GA22753@coredump.intra.peff.net>
	<adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com>
	<7vej1j40x5.fsf@gitster.siamese.dyndns.org>
	<20081111000706.GA26223@coredump.intra.peff.net>
	<adf1fd3d0811102356u6e671dcfj6491f81cf462ec2e@mail.gmail.com>
	<20081111102914.GA30330@coredump.intra.peff.net>
	<7v4p2e2nkg.fsf@gitster.siamese.dyndns.org>
	<20081112081609.GA3720@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 14:10:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L39J1-0006za-Np
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 14:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbYKTNJb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Nov 2008 08:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbYKTNJb
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:09:31 -0500
Received: from francis.fzi.de ([141.21.7.5]:40213 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750716AbYKTNJb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 08:09:31 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 20 Nov 2008 14:09:28 +0100
Content-Disposition: inline
In-Reply-To: <20081112081609.GA3720@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 20 Nov 2008 13:09:28.0222 (UTC) FILETIME=[37F6D3E0:01C94B11]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101421>

Hi,

On Wed, Nov 12, 2008 at 03:16:09AM -0500, Jeff King wrote:
> Here's a patch series that at least improves the situation by turning
> off the diff-stripping if we never put in a diff in the first place.
> That way only people who actually _use_ "-v" will have to pay for it.

I always want to see the diff while editing a commit message, even if
it's the commit message of a merge, a revert, a squash in rebase.
Since these commands do not have an option equivalent to 'git commit
-v', I wrote a little prepare-commit-msg hook to always append the
appropriate diff to the end of the appropriate commit message file.
This worked pretty well for the last couple of months, until 5/5 got
into maint.

So, what is the/is there a preferred way to always include the diff in
the commit message template and get it removed automatically?  Are
there any workarounds other than revert that commit locally?

Thanks,
G=E1bor
