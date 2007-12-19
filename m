From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Wed, 19 Dec 2007 09:29:56 +0100
Message-ID: <4768D684.5060300@op5.se>
References: <20071217110322.GH14889@albany.tokkee.org>	 <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>	 <7vk5nd53lp.fsf@gitster.siamese.dyndns.org>	 <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>	 <7vfxy04ze7.fsf@gitster.siamese.dyndns.org>	 <20071218154211.GB12549@alea.gnuu.de>	 <46a038f90712181541x781c3ebcq6d85b88dbf5cbe23@mail.gmail.com>	 <38C1471E-0927-4B43-AF73-70735820F8F9@wincent.com> <46a038f90712182346t5309448egebfd3726f4d493c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 09:30:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4uJu-00029D-2Z
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 09:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbXLSIaD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 03:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbXLSIaB
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 03:30:01 -0500
Received: from mail.op5.se ([193.201.96.20]:37752 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbXLSIaA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 03:30:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 07C8F1F08054;
	Wed, 19 Dec 2007 09:29:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sGZzOfLa3W99; Wed, 19 Dec 2007 09:29:57 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 7B5F21F08049;
	Wed, 19 Dec 2007 09:29:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <46a038f90712182346t5309448egebfd3726f4d493c5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68865>

Martin Langhoff wrote:
> On Dec 19, 2007 8:33 PM, Wincent Colaiuta <win@wincent.com> wrote:
>> El 19/12/2007, a las 0:41, Martin Langhoff escribi=F3:
>>
>>> On Dec 19, 2007 4:42 AM, J=F6rg Sommer <joerg@alea.gnuu.de> wrote:
>>>> I vote for stash print the list, because I dropped in the pitfall.
>>> I've dropped there myself, and work with a large team where we are
>>> both fans of stash, and scarred by it. Any newcomer to git that
>>> "discovers" stash gets hit by it a dozen times, this is completely
>>> unnecesary.
>> I may be missing something here, but what's the danger here? An
>=20
> Surprise. Your working directory has *just* changed under your feet.
> Maybe you have an editor with further unsaved changes that is about t=
o
> act confused whether you undo the stash or not.
>=20
>> unexpected stash is incredibly easy to revert, unless I'm missing
>=20
> Once you know about it, yes it is. Once you know about the reflog, yo=
u
> can sing and dance and never be worried. But for starting users, it's
> a dangerous command.
>=20
>> And nobody commented on the idea I posted earlier which
>> seems to address the concerns about newbies not knowing what "git
>> stash" with no params does:
>=20
> I agree with making stash more verbose -- if the unlucky new user is
> paying close attention, they'll have instructions on to how to get ou=
t
> of trouble. But I agree more with making it "just verbose, no action"
> by default. There are two strong hints:
>=20
>  - all other state-changing commands take parameters
>  - quite a few people in this list have gotten burned with it
>=20
> Even after knowing pretty well how stash works, I still get mixed up
> sometimes with the 'clear/clean/list' stuff. Or have a typo in the
> command.
>=20

The clear vs clean confusion has been remedied though, and you can no
longer create a named stash without using "git stash save" with a
recent enough version of git.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
