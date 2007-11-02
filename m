From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Fri, 2 Nov 2007 14:11:35 +0100
Message-ID: <5D2EDD64-CD98-4747-8579-25DF7FC9DAAC@wincent.com>
References: <1193593581312-git-send-email-prohaska@zib.de> <1193593581114-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org> <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> <7vejfcl8aj.fsf@gitster.siamese.dyndns.org> <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org> <B3C76DB8-076D-4C43-AC28-99119A05325C@z ib.de> <7vve8nglrt.fsf@gitster.siamese.dyndns.o
 rg> <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org> <0C176853-8848-46C8-AD7A-97F73274DC29@wincent.com> <Pine.LNX.4.64.0711021213370.4362@racer.site!
 > <A862668C-7895-489A-B13B-597084CAEE11@zib.de>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Nov 02 14:12:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InwK7-0005VR-Hz
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 14:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbXKBNMQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 09:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbXKBNMP
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 09:12:15 -0400
Received: from wincent.com ([72.3.236.74]:37358 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbXKBNMP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 09:12:15 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lA2DBaum031930;
	Fri, 2 Nov 2007 08:11:37 -0500
In-Reply-To: <A862668C-7895-489A-B13B-597084CAEE11@zib.de>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63114>

El 2/11/2007, a las 13:48, Steffen Prohaska escribi=F3:

> On Nov 2, 2007, at 1:14 PM, Johannes Schindelin wrote:
>
>> On Fri, 2 Nov 2007, Wincent Colaiuta wrote:
>>
>>> Of course, it's too late too change now, but it would be nice if th=
e
>>> mirror of "fetch" were "send". (I know it's been commented in the =20
>>> past
>>> that the fact that "push" and "pull" aren't mirror operations has
>>> surprised quite a few people.)
>>
>> Could you please just do
>>
>> 	git config --global alias.send push
>>
>> and be done with it?

(snip)

> The comment was about how to avoid surprises for people that
> are new to git, not how to let long-time users have an alias
> for push.

Exactly. I was talking about the *initial* surprise for new users, not =
=20
for people who already know the difference between push, pull and =20
fetch (99% of people reading this list already, myself included).

> The _only_ real solution I see right now, is to stop the
> discussion and leave "git push" as is. I strongly believe that
> the git community in its majority will refuse to rename push;
> though I have no evidence for this.

As I said above, "Of course, it's too late to change now"... I don't =20
think it will be renamed either.

Cheers,
Wincent
