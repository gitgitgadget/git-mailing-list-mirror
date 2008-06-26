From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Thu, 26 Jun 2008 10:13:27 -0500
Message-ID: <K8mYvOxbzHDUUveNqGY1qxKxQCRRn4fCJly5l1F_bU9bM2LdvpAD1g@cipher.nrlssc.navy.mil>
References: <m31w2mlki4.fsf@localhost.localdomain> <FmVFerrNVumRho9GZZwRiHrXV_hb12J_P_hSYUBnFhcCFiMGdtdCrg@cipher.nrlssc.navy.mil> <20080624225442.GA20361@mit.edu> <7vod5qa0tu.fsf@gitster.siamese.dyndns.org> <20080625022610.GB20361@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, David Jeske <jeske@google.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 26 17:18:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBtDj-0003Rr-G9
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 17:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355AbYFZPQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 11:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754922AbYFZPQE
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 11:16:04 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33156 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814AbYFZPQB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 11:16:01 -0400
Received: by mail.nrlssc.navy.mil id m5QFDRIX020654; Thu, 26 Jun 2008 10:13:27 -0500
In-Reply-To: <20080625022610.GB20361@mit.edu>
X-OriginalArrivalTime: 26 Jun 2008 15:13:27.0435 (UTC) FILETIME=[2F5B65B0:01C8D79F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86456>

Theodore Tso wrote:
> On Tue, Jun 24, 2008 at 04:07:57PM -0700, Junio C Hamano wrote:
>>> Instead, I've just learned to be careful and my use of git reset
>>> --hard is mainly for historical reasons.
>> This makes it sound as if avoiding "reset --hard" is a good thing, but I
>> do not understand why.
> 
> Well, it was Brandon Casey who was asserting that git reset --hard was
> evil, which I generally don't agree with.

I definitely don't think 'reset --hard' is evil. I _do_ think it is somewhat
of an advanced command. It should be used where it is appropriate. I think
it is a misuse of the command if it is used in place of checkout, which I got
the impression might be the case.

You described resetting an integration branch, Junio does a similar thing
with pu and these are both valid uses. This is what I was talking about
when I said that usually when I use reset I don't care about the state of
the branch I am resetting. I also agree there are many other valid uses for
'git reset --hard'.

-brandon
