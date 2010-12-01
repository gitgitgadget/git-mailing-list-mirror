From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/config.txt: Order variables alphabetically
Date: Wed, 01 Dec 2010 17:33:56 +0200
Organization: Private
Message-ID: <877hftwlqz.fsf@picasso.cante.net>
References: <1291209174-9239-1-git-send-email-jari.aalto@cante.net>
	<m3eia14mu7.fsf@localhost.localdomain>
	<20101201142920.GB6537@picasso.cante.net>
	<201012011557.30849.jnareb@gmail.com>
	<20101201150917.GD6537@picasso.cante.net>
	<AANLkTindMBh4dzo-VG2vPrKfgNZVUhs0-5AEU2fWChaC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 16:34:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNohE-0006c9-9w
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 16:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927Ab0LAPeK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 10:34:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:34210 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab0LAPeI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 10:34:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PNoh5-0006XU-OI
	for git@vger.kernel.org; Wed, 01 Dec 2010 16:34:07 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 16:34:07 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 16:34:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:39W3AqYvCfbuEWJZAXbifhzkquI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162532>

2010-12-01 17:19 Erik Faye-Lund <kusmabite@gmail.com>:
> On Wed, Dec 1, 2010 at 4:09 PM, jari <jari.aalto@cante.net> wrote:
>
>> On 2010-12-01 15:57, Jakub Narebski wrote:
>> | On Wed, 1 Dec 2010, Jari Aalto wrote:
>> | > The phone books have an index where to up information.
>> | >
>> | > =C2=A0 =C2=A0 - When you see script and it use VARIABLE, you loo=
k it from
>> | > =C2=A0 =C2=A0 =C2=A0 manual page
>> |
>> | Manpages (and 'git <cmd> --help') are displayed in pager, so you c=
an
>> | always search for option in a pager (e.g. '/' in 'less', the defau=
lt
>> | pager).
>>
>> Yuck, it's real fun start backward/forward ping-pong when you dont'
>> know the directions and can't rely on standard A-Z index.
>>
>
> ...but for config options, I tend to ping-pong between items that are
> related to each other, which are already located close by. Your
> argument weighs more for keeping the current layout, IMO.

This isa all academic. It's known in literature that you can't in
practise group all related. That's why you add "see also".

    A
    B   references X
    C   references A
    D
    E
    F   Refrences A
    ...
    X

So what's the order? All related items gruped? There will always be
zillions of related items.

The A-Z that works, always.

CASE:

    You read piece of ~/.gitconfig somewhere. You wonder what that
    does. You pick up the manual, A-Z and, voila -- you know the option=
=2E

    Then read next. And you know to what direction to search (A-Z). Ano=
ther
    search gone gold.

    And you continue. No problems. All straight A-Z.

With "grouped" you just feel dizzy after a real detective work. "Was it
upward, downward -- Damn my pager is not even less(1)".


Jari
