From: Andreas Ericsson <ae@op5.se>
Subject: Re: Usability of git stash
Date: Mon, 20 Oct 2008 11:49:35 +0200
Message-ID: <48FC542F.9010200@op5.se>
References: <87wsg9acfv.fsf@cup.kalibalik.dk>	<nKimSsYZj6xfGNCQS3i5cRwnWQfbHrtUrwdGB2zGWVfMOcfZMwJDKg@cipher.nrlssc.navy.mil>	<86vdvsg4up.fsf@lola.quinscape.zz>	<vCcONcOJu3QKQyRgPdT5Dws3F2P25RNAFOgM5GX6FWWKJe40papCRw@cipher.nrlssc.navy.mil> <87prly5k5r.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Mon Oct 20 15:03:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrrPf-0002xG-4L
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 11:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbYJTJtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 05:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbYJTJtp
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 05:49:45 -0400
Received: from mail.op5.se ([193.201.96.20]:50460 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbYJTJtp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 05:49:45 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C050F24B0001;
	Mon, 20 Oct 2008 11:43:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.834
X-Spam-Level: 
X-Spam-Status: No, score=-3.834 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.565, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZkcFueateTbc; Mon, 20 Oct 2008 11:43:04 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id B3F061B8036C;
	Mon, 20 Oct 2008 11:43:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <87prly5k5r.fsf@cup.kalibalik.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98665>

Anders Melchiorsen wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> In exchange for allowing new users to stub their toe on new commands, the
>> work flow of more experienced users is made a little easier.
> 
> I wonder whether experienced users even use stash a lot. Personally,
> after getting my head around the DAG, and thus getting more
> comfortable with git reset, I tend to make "WIP" commits instead.
> 

I use stash quite a lot. It's useful for me because my co-workers
sometimes pull from me so I cannot use 'wip' commits (without annoying
my co-workers anyway).

> After having used "git stash clear" at a bad time once, I am wary of
> stashing work that I actually want to keep. I prefer workflows where
> my mistakes can be (easily) corrected.
> 

I never use "stash clear", but always do "stash pop", so my stash-stack
is hardly ever deeper than one. It would be a lot worse for us to get a
"wip" commit accidentally propagated and built on further. It's happened
and it's no fun what so ever as it requires team coordination and rewrite
of published history to get it back to a good state.

> 
> The primary thing that stash does for me is preserve the index state.
> Unfortunately, --index is not default for stash apply, so I often
> forget it.
> 

I commit regularly enough that it doesn't take me long at all to re-do
the index changes.

> Sometimes, I also want stash to store away changes to untracked files
> (to get a clean working directory), but that is not possible.
> 

git add .
git stash --index

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
