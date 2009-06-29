From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Translate the tutorial to Brazillian Portuguese.
Date: Mon, 29 Jun 2009 11:35:00 -0700
Message-ID: <7vtz1yc2i3.fsf@alter.siamese.dyndns.org>
References: <7vljnbcbjs.fsf@alter.siamese.dyndns.org>
	<1246289542-1596-1-git-send-email-cascardo@holoscopio.com>
	<7vfxdjc9b3.fsf@alter.siamese.dyndns.org>
	<20090629162738.GE4327@vespa.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Yasuaki Narita <yasuaki_n@mti.biglobe.ne.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 20:35:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLLh8-0004gE-Ke
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 20:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbZF2SfA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jun 2009 14:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbZF2Se6
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 14:34:58 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:49038 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbZF2Se6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 14:34:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090629183500.XGCO17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 29 Jun 2009 14:35:00 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9ub01c00E4aMwMQ04ub0CD; Mon, 29 Jun 2009 14:35:00 -0400
X-VR-Score: -180.00
X-Authority-Analysis: v=1.0 c=1 a=Z7BUjtv_ByQA:10 a=uLpP-0uDAAAA:8
 a=xNf9USuDAAAA:8 a=9nYpvJFdj5FqqrQsj2oA:9 a=pYojHE-zp5Tl2ewSCgMA:7
 a=gja9F8zb5tQFPHGEahk4XVRJJj0A:4 a=9DQb5BBr7e8A:10
X-CM-Score: 0.00
In-Reply-To: <20090629162738.GE4327@vespa.holoscopio.com> (Thadeu Lima de Souza Cascardo's message of "Mon\, 29 Jun 2009 13\:27\:39 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122452>

Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com> writes:

> On Mon, Jun 29, 2009 at 09:08:00AM -0700, Junio C Hamano wrote:
>> Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com> writes:
>>=20
>> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.=
com>
>>=20
>> Thanks.
>>=20
>> > +Voc=C3=AA tamb=C3=A9m pode dar ao 'git-log' um "intervalo" de com=
mits onde o
>> > +primeiro n=C3=A3o =C3=A9 necessariamente um ancestral do segundo;=
 por exemplo, se
>> > +as pontas dos ramos "stable" e "master" divergiram de um commit
>> > +comum algum tempo atr=C3=A1s, ent=C3=A3o
>> > +
>> > +-------------------------------------
>> > +$ git log stable..experimental
>> > +-------------------------------------
>> > +
>> > +ir=C3=A1 listas os commits feitos no ramo experimental mas n=C3=A3=
o no ramo
>> > +stable, enquanto
>> > +
>> > +-------------------------------------
>> > +$ git log experimental..stable
>> > +-------------------------------------
>> > +
>> > +ir=C3=A1 listar a lista de commits feitos no ramo stable mas n=C3=
=A3o no ramo
>> > +experimental.
>> > +
>>=20
>> I think you would want to update this part to match what you did in =
your
>> [PATCH 1/2 v2].
>
> Well remembered. Thanks.

As I do not speak the language, even though I can guess that a straight
replacement "s/experimental/master/g" would be enough for the above quo=
ted
part (including the body text), I do not feel comfortable enough to upd=
ate
these myself.  Please send in a replacement [PATCH 2/2 v2].

>> I however am not sure how practical it would be to force people to l=
ook at
>> the *.txt version of document, only 1/n lines of which is now readab=
le by
>> him (if you are like a typical American who understands only English=
 ;-).
>>=20
>> Thoughts?
>
> I think that using something like po would be better. There are tools
> that can extract and update the template messages from many different=
e
> sources. Adapting them to produce a template file from gittutorial.tx=
t
> would allow translators to verify how stale their translations are an=
d
> much smoother merges. How about that?

After thinking about it a bit more, I think I would prefer something th=
at
keeps translation sources separate from the original text.  That way, I
have a lot less chance of having to deal with merge/patch conflicts.

Your patch adds Documentation/pt/ hierarchy, but I noticed that the ker=
nel
folks seem to use Documentation/{ja_JP,ko_KR,zh_CN}/.  I do not think i=
t
would make much difference for Japanese language between ja vs ja_JP, b=
ut
for many languages used in different geographic areas, such an arrangem=
ent
would make a lot more sense.  As your patch identified itself as a
translation to "Brasilian Portuguese", I am imagining that it would be
sufficiently different to merit the distinction from Old-world Portugue=
se.
Perhaps your patch should be made to Documentation/pt_BR instead?

As to the choice of the tool, from a quick superficial glance, po4a cou=
ld
be a reasonable choice, but I do not know how mature and/or widely used=
 it
is, or if there are better alternatives.  http://po4a.alioth.debian.org=
/
says it does support AsciiDoc.
