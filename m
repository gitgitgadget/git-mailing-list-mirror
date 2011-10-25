From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Tue, 25 Oct 2011 18:35:04 -0400
Message-ID: <1319582104.10399.38.camel@drew-northup.unet.maine.edu>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
	 <20111019190114.GA4670@sigill.intra.peff.net>
	 <20111019193834.GA14168@sigill.intra.peff.net>
	 <7vvcrk9td7.fsf@alter.siamese.dyndns.org>
	 <20111020043448.GA7628@sigill.intra.peff.net>
	 <7vr5289mlu.fsf@alter.siamese.dyndns.org>
	 <20111020071356.GA14945@sigill.intra.peff.net>
	 <20111020131454.GB7464@thunk.org>
	 <20111020155611.GB16114@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Ted Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 26 00:36:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIpc6-0001HR-KC
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 00:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725Ab1JYWgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 18:36:45 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:38577 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab1JYWgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 18:36:44 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p9PMZBQA004832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 25 Oct 2011 18:35:16 -0400
In-Reply-To: <20111020155611.GB16114@sigill.intra.peff.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC--Metrics: basalt.its.maine.edu 1356; Body=5 Fuz1=5 Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p9PMZBQA004832
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1320186939.25561@f2K+6z9DaUzkU4pki/sIKQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184240>


On Thu, 2011-10-20 at 11:56 -0400, Jeff King wrote:
> On Thu, Oct 20, 2011 at 09:14:55AM -0400, Ted Ts'o wrote:
> 
> > Another possibility is to warn if the commit messages are not NULL
> > terminated.
> 
> A minor nit, but it's not whether they are terminated with NUL, but
> rather whether they have embedded NUL. But yeah, this could maybe just
> be something fsck looks for.

God (or your deity of choice) forbid that anybody ever writes code that
saves raw UTF-16 as the commit message...

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
