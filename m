From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Sat, 19 Jan 2008 10:36:36 +0100
Message-ID: <20080119093636.GA4281@efreet.light.src>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com> <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com> <alpine.LNX.1.00.0801151728120.13593@iabervon.org> <7vhched3kw.fsf@gitster.siamese.dyndns.org> <7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org> <7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org> <alpine.LNX.1.00.0801152226000.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 10:37:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGA8a-0004xP-EZ
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 10:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424AbYASJgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 04:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754949AbYASJgr
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 04:36:47 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:33369 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753969AbYASJgp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 04:36:45 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id C8E835738E;
	Sat, 19 Jan 2008 10:36:43 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id qbeMUdpyl0td; Sat, 19 Jan 2008 10:36:41 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id C19B357381;
	Sat, 19 Jan 2008 10:36:40 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1JGA7w-0003Eb-SX; Sat, 19 Jan 2008 10:36:36 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0801152226000.13593@iabervon.org>
User-Agent: Mutt/1.5.17 (2007-12-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71091>

On Tue, Jan 15, 2008 at 22:56:14 -0500, Daniel Barkalow wrote:
> On Tue, 15 Jan 2008, Linus Torvalds wrote:
> > [...]
> > So maybe a --standard-diff option that removes the "--git" part, but also 
> > removes everything else.
> 
> That seems wise to me. We should be able to generate patches that are 
> accessible to programs that can't follow any clever instructions. I think 
> the point of the "Index:" header is that these programs will freak out if 
> two filenames don't match (or, more likely, break in some way), and it 
> means you can't sensibly generate patches that upset them for deletes or 
> creates.

Funny, Subversion has support for explicit renames in core. So I would have
thought it can represent them in it's diffs. Might be worth checking what it
generates for copies and deletes (rename being a copy+delete in SVN) before
creating the converter from git to subversion diffs.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
