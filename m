From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCHv3] filter-branch: Add tests for submodules
Date: Thu, 28 Jan 2010 10:02:02 +0100
Message-ID: <201001281002.03232.sojkam1@fel.cvut.cz>
References: <201001280041.23182.sojkam1@fel.cvut.cz> <1264636547-24496-1-git-send-email-sojkam1@fel.cvut.cz> <7vfx5rnl0w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j.sixt@viscovery.net,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 10:02:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaQGj-0000fg-LL
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 10:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958Ab0A1JCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 04:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748Ab0A1JCS
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 04:02:18 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:42108 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932191Ab0A1JCP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 04:02:15 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id E315819F33D2;
	Thu, 28 Jan 2010 10:02:12 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id XT+YF95qNDlI; Thu, 28 Jan 2010 10:02:08 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 97ACE19F33C7;
	Thu, 28 Jan 2010 10:02:08 +0100 (CET)
Received: from steelpick.localnet (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 8082715C052;
	Thu, 28 Jan 2010 10:02:04 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31.11-amd64; KDE/4.3.4; x86_64; ; )
In-Reply-To: <7vfx5rnl0w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138231>

On Thursday 28 of January 2010 01:14:07 Junio C Hamano wrote:
> Michal Sojka <sojkam1@fel.cvut.cz> writes:
> > There are three important tests:
> 
> It is unnecessary and counterproductive to self-proclaim the importance of
> a patch or new tests.  If anything, what are important are not tests
> themselves but the conditions that they check, so "Add tests to check
> three important cases:" is slightly more palatable.
> 
> I'd suggest to just start with "Add three tests to make sure:".

OK

> > 1) 'rewrite submodule with another content' passes only with the
> >    previous patch applied.
> 
> Sorry, but I think I am missing some context here to understand this
> sentence.  Which previous patch?

I should have sent both patches. Sorry for that. I'll send them now.
 
> > 2) 'checkout submodule during rewrite' demonstrates that it is not
> >    possible to replace a submodule revision in tree-filter by checking
> >    the submodule out and reseting the submodule's HEAD. Fails both
> >    with and without the previous patch. This is because filter-branch
> >    sets GIT_WORKING_TREE to "." which causes clone (called from
> >    git-submodule) to fail.
> 
> I thought you agreed with Hannes that this is not something we would even
> want to support?

Yes. I'm removing this test.

Cheers,
Michal
