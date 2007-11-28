From: Andreas Ericsson <ae@op5.se>
Subject: Re: StGit hooks
Date: Wed, 28 Nov 2007 18:06:36 +0100
Message-ID: <474DA01C.8010901@op5.se>
References: <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com> <20071128093403.GB12977@diana.vm.bytemark.co.uk> <20071128101718.GA13940@diana.vm.bytemark.co.uk> <474D5482.5020609@op5.se> <20071128121905.GA15953@diana.vm.bytemark.co.uk> <474D69A7.6020404@op5.se> <20071128132605.GB15953@diana.vm.bytemark.co.uk> <474D7710.4090303@op5.se> <9e4733910711280653q119f2c2n173eaebdda6cd774@mail.gmail.com> <474D8205.8030401@op5.se> <20071128154059.GA19302@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 18:07:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQNJ-0003hL-SZ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 18:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989AbXK1RGm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 12:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755933AbXK1RGm
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 12:06:42 -0500
Received: from mail.op5.se ([193.201.96.20]:50328 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754717AbXK1RGl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 12:06:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 20B661F0805C;
	Wed, 28 Nov 2007 18:06:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i+WfmLYvGbDW; Wed, 28 Nov 2007 18:06:39 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id F28171F0805E;
	Wed, 28 Nov 2007 18:06:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20071128154059.GA19302@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66387>

Karl Hasselstr=F6m wrote:
> On 2007-11-28 15:58:13 +0100, Andreas Ericsson wrote:
>=20
>> Jon Smirl wrote:
>>
>>> I would expect 'stg init' to switch the branch to using the stgit
>>> hooks and only those hooks. Branches that were not inited would
>>> continue to use the user hooks. I don't have any user hooks, but
>>> this is what I would expect to happen.
>> Obviously the stgit-installed hook will have to check if the branch
>> the user is operating on is managed by stgit before it prevents git
>> rebase (or whatever it's supposed to do).
>=20
> Yes. The point is, hooks are per repository, not per branch. So
> there's no concept of "replacing the hooks for just this one branch".
>=20

True, but there are ways of figuring out which branch you're on, using
the arguments passed to the hook.

The rebase hook (which is where this discussion started) gets the
branches passed to "git rebase" as arguments. Figuring out if either
of those branches are actually under stgit control shouldn't be overly
tricky for one so familiar with stgit as yourself.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
