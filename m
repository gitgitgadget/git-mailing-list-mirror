From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 11:44:11 +0300
Message-ID: <87r5xihqxw.fsf@iki.fi>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
	<20090618063348.6117@nanako3.lavabit.com>
	<alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
	<20090618001111.GB12954@vidovic>
	<7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302>
	<87vdmuhs75.fsf@iki.fi>
	<alpine.DEB.1.00.0906181028140.4848@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:44:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHDEV-0003JA-4x
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 10:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725AbZFRIoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 04:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755365AbZFRIoS
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 04:44:18 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:43730 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327AbZFRIoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 04:44:16 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 49F5CB6401EBB530; Thu, 18 Jun 2009 11:44:14 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1MHDEB-0006F4-Mw; Thu, 18 Jun 2009 11:44:11 +0300
In-Reply-To: <alpine.DEB.1.00.0906181028140.4848@intel-tinevez-2-302>
	(Johannes Schindelin's message of "Thu, 18 Jun 2009 10:29:58 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121818>

On 2009-06-18 10:29 (+0200), Johannes Schindelin wrote:

> So let's just interpret the "!" in the most common meaning, namely to
> add an imperative. Then it means "yes, I do want to squash". Not
> "squash, but oh, BTW, I want to lose the second commit message
> completely, and I do not want to edit the commit message either".

My main point is the "small modifier character" for squash. Perhaps
"squash*" is better? I'll repeat that it is still doing very much the
same thing as "squash" expect for one little thing. Hence it would be
nice to use only small modifier character, not totally new word with
possibly different connotations.

    pick aaaa ...
    squash* bbbb Small fix to be squashed
    pick cccc ...
    pick dddd ...
