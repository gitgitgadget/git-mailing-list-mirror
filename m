From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Translate the tutorial to Brazillian Portuguese.
Date: Mon, 29 Jun 2009 09:08:00 -0700
Message-ID: <7vfxdjc9b3.fsf@alter.siamese.dyndns.org>
References: <7vljnbcbjs.fsf@alter.siamese.dyndns.org>
	<1246289542-1596-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Yasuaki Narita <yasuaki_n@mti.biglobe.ne.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 18:09:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLJPJ-0000iL-Ny
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 18:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757383AbZF2QID convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jun 2009 12:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754307AbZF2QID
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 12:08:03 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:47487 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbZF2QIC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 12:08:02 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090629160802.IKWB2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 29 Jun 2009 12:08:02 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9s811c0024aMwMQ04s81P7; Mon, 29 Jun 2009 12:08:01 -0400
X-VR-Score: -70.00
X-Authority-Analysis: v=1.0 c=1 a=Z7BUjtv_ByQA:10 a=uLpP-0uDAAAA:8
 a=NEAV23lmAAAA:8 a=Ew7iSBGB-MfKXXFNpqgA:9 a=JqMWZkgpjVO7Cjulp3hUABTSmQcA:4
 a=9DQb5BBr7e8A:10
X-CM-Score: 0.00
In-Reply-To: <1246289542-1596-1-git-send-email-cascardo@holoscopio.com> (Thadeu Lima de Souza Cascardo's message of "Mon\, 29 Jun 2009 12\:32\:22 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122444>

Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com> writes:

> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com=
>

Thanks.

> +Voc=C3=AA tamb=C3=A9m pode dar ao 'git-log' um "intervalo" de commit=
s onde o
> +primeiro n=C3=A3o =C3=A9 necessariamente um ancestral do segundo; po=
r exemplo, se
> +as pontas dos ramos "stable" e "master" divergiram de um commit
> +comum algum tempo atr=C3=A1s, ent=C3=A3o
> +
> +-------------------------------------
> +$ git log stable..experimental
> +-------------------------------------
> +
> +ir=C3=A1 listas os commits feitos no ramo experimental mas n=C3=A3o =
no ramo
> +stable, enquanto
> +
> +-------------------------------------
> +$ git log experimental..stable
> +-------------------------------------
> +
> +ir=C3=A1 listar a lista de commits feitos no ramo stable mas n=C3=A3=
o no ramo
> +experimental.
> +

I think you would want to update this part to match what you did in you=
r
[PATCH 1/2 v2].

    By the way, I think your MUA sent quoted-printable UTF-8 but somewh=
ere
    between your keyboard and vger the message was marked with content-=
type
    charset=3DISO-8859-1); I fixed it up when quoting the above.

I am somewhat worried about the way how this translation will be
maintained to keep in sync with the authoritative English version.
Narita-san (CC'ed) who translated the document to Japanese did this:

    gittutorial(7)
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    // =3D gittutorial(7)

    NAME
    ----
    // =3D=3D NAME
    gittutorial - A tutorial introduction to git (for version 1.5.1 or =
newer)
    // gittutorial - git =E3=83=81=E3=83=A5=E3=83=BC=E3=83=88=E3=83=AA=E3=
=82=A2=E3=83=AB (=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3 1.5.1 =E4=
=BB=A5=E9=99=8D=E7=94=A8)

and the idea seems that without // (comments in AsciiDoc markup) it
matches the English copy, and after passing sed -ne 's|^// ||p' it yiel=
ds
Japanese version.  Narita-san's translation can be seen at

    http://github.com/yasuaki/git-manual-jp.git/Documentation

if anybody is interested.

With this format, merging upstream changes may not work as smoothly as =
it
could be, but at least you can check which part of your translation is
based on a stale copy with something like this arrangement.

I am wondering if it would be a good idea to extend Narita-san's scheme=
 so
that we can keep a single source, perhaps like:

    =3D gittutorial(7)
    // ja =3D gittutorial(7)
    // pt =3D gittutorial(7)
    =3D=3D NAME
    // ja =3D NAME
    // pt =3D NAME
    gittutorial - A tutorial introduction to git (for version 1.5.1 or =
=2E..
    // ja gittutorial - git =E3=83=81=E3=83=A5=E3=83=BC=E3=83=88=E3=83=AA=
=E3=82=A2=E3=83=AB (=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3 1.5.1=
 =E4=BB=A5=E9=99=8D=E7=94=A8)
    // pt gittutorial - Um tutorial de introdu=C3=A7=C3=A3o ao git (par=
a vers=C3=A3o 1....

Then whenever somebody makes a change to the English version, he can an=
d
should also mark the corresponding translated versions "stale", so that=
 it
is easier to spot by translators.

    diff --git a/gittutorial.txt b/gittutorial.txt
    index 4478300..02d67d3 100644
    --- a/gittutorial.txt
    +++ b/gittutorial.txt
    @@ -4,7 +4,6 @@
     =3D=3D NAME
     // ja =3D NAME
     // pt =3D NAME
    -gittutorial - A tutorial introduction to git (for version 1.5.1 or=
 n...
    -// ja gittutorial - git =E3=83=81=E3=83=A5=E3=83=BC=E3=83=88=E3=83=
=AA=E3=82=A2=E3=83=AB (=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3 1.=
5.1 =E4=BB=A5=E9=99=8D=E7=94=A8)
    -// pt gittutorial - Um tutorial de introdu=C3=A7=C3=A3o ao git (pa=
ra vers=C3=A3o 1....
    -
    +gittutorial - A tutorial introduction to git (for version 1.6.3 or=
 n...
    +// **stale** ja gittutorial - git =E3=83=81=E3=83=A5=E3=83=BC=E3=83=
=88=E3=83=AA=E3=82=A2=E3=83=AB (=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=
=83=B3 1.5.1 ...
    +// **stale** pt gittutorial - Um tutorial de introdu=C3=A7=C3=A3o =
ao git (par...

As long as all the translations use the same encoding (I think UTF-8 is
the only practical choice for this), keeping translated strings in a
single file would be doable.

I however am not sure how practical it would be to force people to look=
 at
the *.txt version of document, only 1/n lines of which is now readable =
by
him (if you are like a typical American who understands only English ;-=
).

Thoughts?
