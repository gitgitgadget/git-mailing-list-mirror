From: "David Jeske" <jeske@google.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 22:13:13 -0000
Message-ID: <31710.7249437415$1214347705@news.gmane.org>
References: <FmVFerrNVumRho9GZZwRiHrXV_hb12J_P_hSYUBnFhcCFiMGdtdCrg@cipher.nrlssc.navy.mil>
	<willow-jeske-01l5PFjPFEDjCfzf-01l63P33FEDjCVQ0>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Boaz Harrosh" <bharrosh@panasas.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:48:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHJ0-0007FJ-VX
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbYFXWrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbYFXWrL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:47:11 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60281 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751281AbYFXWrK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 18:47:10 -0400
Received: (qmail 21857 invoked by uid 90); 24 Jun 2008 22:47:03 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Tue, 24 Jun 2008 22:13:13 -0000
In-Reply-To: <FmVFerrNVumRho9GZZwRiHrXV_hb12J_P_hSYUBnFhcCFiMGdtdCrg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86165>

-- Brandon Casey wrote:
> I only have the same advice I gave to Boaz. I think you should try to adjust
> your workflow so that 'git reset' is not necessary. It seems that for the
> functions you're trying to perform, 'checkout' and 'branch' should be used
> rather than 'reset'.

Even when I change my workflow to avoid 'reset', I believe that the
user-interface of git will be stronger if it is a simpler expression of the
same functionality. One way to simplify it is to use convention that is
standardized across a set of tools so we don't have to learn every little
nuance of every little feature independently.

Two things I'd like to make it easy for users to never do are:
- delete data
- cause refs to be dangling

Therefore, I'd like a simple convention I can apply across all commands, so
that if users never do them, they'll never do either of the above things. I'm
not alone.

I think some of the impedance mismatch between my suggestions, and current
usage, has to do with where I'd like to be next. This is a meaty topic, I'll
start another thread on "policy and mechanism for less-connected clients".

> I'm not sure why you want to use reset so often. If there is something in the
> documentation that led you to want to use reset maybe it can be changed so
that
> other users are not led in the same way.

Yes, it's a problem in the git-gui and the "reset --hard" documentation. I'm
working on a patch.
