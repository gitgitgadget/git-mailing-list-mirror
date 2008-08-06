From: =?UTF-8?B?SsO8cmdlbiBNYW5nbGVy?= <juergen.mangler@univie.ac.at>
Subject: Re: do without .netrc
Date: Wed, 06 Aug 2008 13:28:07 +0200
Message-ID: <48998AC7.20204@univie.ac.at>
References: <4898DBA6.1060707@univie.ac.at> <20080806085025.GU32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 13:29:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQhCh-0003Fx-9q
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 13:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758876AbYHFL2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 07:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758802AbYHFL2L
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 07:28:11 -0400
Received: from grace.univie.ac.at ([131.130.3.115]:41001 "EHLO
	grace.univie.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758871AbYHFL2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 07:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=univie.ac.at; s=rev1; h=Message-ID:Date:From:MIME-Version:To:
	CC:Subject:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; bh=6IK6AFsQjip1zM22rnK9spxwaA3eEIikqq
	HpObg0ww8=; b=ofC/3dyGHhqzwAjbRDhMs1Sj1uGxxQ0JYqLpMmezuQb237cgbP
	wJ1VLNPtDv25BNo13E9V8trHchnGRICcz2XewlrayyCHiqsS923saioiV/v4Txfu
	6ZY+twg04gZWmI9oOYxOxqPmAwySJOctubP+cMvOLRHLBxDKqyiVrdB88=
Received: from justin.univie.ac.at ([131.130.3.111] helo=justin.univie.ac.at)
	by grace.univie.ac.at with esmtp (Exim 4.69)
	(envelope-from <juergen.mangler@univie.ac.at>)
	id 1KQhBX-00081l-P1; Wed, 06 Aug 2008 13:28:07 +0200
Received: from [131.130.37.200] (helo=[172.17.19.72])
	by justin.univie.ac.at with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <juergen.mangler@univie.ac.at>)
	id 1KQhBX-0001RE-Np; Wed, 06 Aug 2008 13:28:07 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080725)
In-Reply-To: <20080806085025.GU32057@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91505>

Miklos Vajna wrote:
> On Wed, Aug 06, 2008 at 01:00:54AM +0200, J=C3=BCrgen Mangler <juerge=
n.mangler@univie.ac.at> wrote:
>> it is working without a:b@ part, but ~/.netrc instead
>>
>> :-(, is it possible without .netrc
>=20
> I thought questions have question marks. ;-)

Explanation 1: I wrote it to IRC and then thought maybe crossposting to=
=20
the list would be no bad idea. On IRC i was not using question marks,=20
mail was just copying the lines, forgot to add question marks.

Explanation 2: its not questions but accusations! *fg*

> Anyway, what is the advantage of not using a ~/.netrc?

It's mentioned on several occations that it is not necessary (e.g.=20
http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-=
over-http.txt)

The advantages for me would be:

a) I have multiple different passwords on the same server for different=
=20
directories, it's not possible to put this to a netrc (AS FAR AS I=20
KNOW). So i have to edit the netrc for every push, clone, ... -> very=20
inconvenient
b) secondly (maybe not a super valid argument for you): netrc is not=20
considered to be the most secure thing, isn't it? Our network is invade=
d=20
every year "tested" by thousands of computer science students, so i=20
always try to have as few plain-text passwords as possible lying around=
=20
(one never knows - yes netrc has 0600).

i'd also prefer not to use the user:pass@server schema, but to be asked=
,=20
to not show pass in the history and config file in .git although even=20
user:pass@server would be an advantage because it solves a).

J=C3=BCrgen
