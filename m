From: Sergei Organov <osv@javad.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 20:40:53 +0300
Message-ID: <871w9jrjdm.fsf@osv.gnss.ru>
References: <20071217110322.GH14889@albany.tokkee.org>
	<506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
	<7vk5nd53lp.fsf@gitster.siamese.dyndns.org>
	<57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
	<7vfxy04ze7.fsf@gitster.siamese.dyndns.org>
	<20071218105941.GA17251@albany.tokkee.org>
	<Pine.LNX.4.64.0712181231420.23902@racer.site> <4767D7A2.30703@op5.se>
	<Pine.LNX.4.64.0712181445420.23902@racer.site>
	<4767E07A.2020100@op5.se>
	<Pine.LNX.4.64.0712181513060.23902@racer.site>
	<4767E717.2060902@op5.se> <m3lk7sovt0.fsf@roke.D-201>
	<4767EFFA.1070909@op5.se>
	<Pine.LNX.4.64.0712181610080.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Jakub Narebski <jnareb@gmail.com>,
	Sebastian Harl <sh@tokkee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 18:42:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4gSb-0002XH-Ua
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 18:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbXLRRmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 12:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbXLRRmE
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 12:42:04 -0500
Received: from javad.com ([216.122.176.236]:1523 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbXLRRmD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 12:42:03 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lBIHexU89153;
	Tue, 18 Dec 2007 17:40:59 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1J4gR3-00036f-I7; Tue, 18 Dec 2007 20:40:53 +0300
In-Reply-To: <Pine.LNX.4.64.0712181610080.23902@racer.site> (Johannes Schindelin's message of "Tue\, 18 Dec 2007 16\:11\:43 +0000 \(GMT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68787>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi,
>
> On Tue, 18 Dec 2007, Andreas Ericsson wrote:
>
>> Jakub Narebski wrote:
>>
>> > Andreas Ericsson <ae@op5.se> writes:
>> >
>> > > My point is that it would be nice if all git commands that actually 
>> > > manipulate objects (create/delete/modify) had a safe default, and 
>> > > that experienced users such as yourself could endure the 
>> > > insufferable agony of retraining your fingers to type five more 
>> > > chars so that people won't have to get bitten by surprises.
>> > 
>> > Also for "git commit"?
>> 
>> git commit has a very safe default; It runs "git status" and exits.
>
> Not in my universe.  It starts an editor, and then commits what I
> staged.

... allowing you to abort the operation by means of providing empty
commit message. On the other hand, "git stash" has immediate effect, so
it's somewhat more dangerous. Just to be picky, anyway.

-- 
Sergei.
