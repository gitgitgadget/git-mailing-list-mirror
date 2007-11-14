From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v3] Add line-wrapping guidelines to the coding style documentation
Date: Wed, 14 Nov 2007 20:08:48 +0100
Message-ID: <473B47C0.6030508@op5.se>
References: <56A87A65-3C2E-4E10-84D4-4470879EE466@wincent.com> <Pine.LNX.4.64.0711141717570.4362@racer.site> <622166FD-0727-47D4-B26C-8A01788FD1EA@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio Hamano <junkio@cox.net>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 20:09:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsNbq-0003Yq-OZ
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 20:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbXKNTIy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 14:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbXKNTIy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 14:08:54 -0500
Received: from mail.op5.se ([193.201.96.20]:33734 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbXKNTIx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 14:08:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B7D3E1F08716;
	Wed, 14 Nov 2007 20:08:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jUgglAn4Nqi5; Wed, 14 Nov 2007 20:08:50 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id DE4E21F08715;
	Wed, 14 Nov 2007 20:08:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <622166FD-0727-47D4-B26C-8A01788FD1EA@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64998>

Wincent Colaiuta wrote:
> Help new contributors by providing some advice about line-wrapping; t=
he
> advice basically boils down to "use 80 columns minus some slop as a
> rule of thumb", but also "use common sense", and "avoid gratuitous
> rewrapping".
>=20
> Signed-off-by: Wincent Colaiuta <win@wincent.com>
> ---
>=20
> El 14/11/2007, a las 18:19, Johannes Schindelin escribi=F3:
>=20
>> On Wed, 14 Nov 2007, Wincent Colaiuta wrote:
>>
>>> Help new contributors by providing some advice about line-wrapping;=
 the
>>> advice basically boils down to "use 80-characters minus some slop a=
s a
>>> rule of thumb", but also "use common sense", and "avoid gratuitous
>>> rewrapping".
>>
>> We already have this:
>>
>> - We try to keep to at most 80 characters per line.
>=20
> Ah, didn't see that. It's in the "C programs" section and I was tryin=
g=20
> to provide a guideline that applied to all source types (given that t=
his=20
> all started with a doc patch to an AsciiDoc source file).
>=20
>> Besides, is it really necessary to be as explicit as you word it?  I=
OW is
>> this patch needed?
>=20
> I was basically just trying to help new people from making the same=20
> mistake that I did; ie. not knowing if there was an official limit,=20
> looking at the maximum line length in a file, making sure my patch=20
> didn't exceed that length (and re-wrapping to avoid exceeding it), an=
d=20
> then getting reprimanded for gratuitous re-wrapping.
>=20
> As for the explicitness, I was just paraphrasing the guidelines as Ju=
nio=20
> expressed them.
>=20
>> Because if we go down that road, we might very well end up with a
>> CodingGuidelines document that is larger than git's source code.
>=20
> 134 lines down (the current length of CodingGuidelines with that patc=
h),=20
> about 100,000 lines to go (the rest of the codebase). So if we try ve=
ry=20
> hard, we could indeed get there.
>=20
> Here follows a revised patch which is more concise, and keeps all=20
> wrapping references at a single place. I lose your "at most 80=20
> characters" in favor of Junio's "80-characters minus some slop", and =
in=20
> fact state "80 columns" rather than "80 characters", because that's w=
hat=20
> we're really talking about, isn't it?
>=20
> Cheers,
> Wincent
>=20
>  Documentation/CodingGuidelines |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/CodingGuidelines=20
> b/Documentation/CodingGuidelines
> index 3b042db..d2d1f32 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -58,8 +58,6 @@ For C programs:
>   - We use tabs to indent, and interpret tabs as taking up to
>     8 spaces.
>=20
> - - We try to keep to at most 80 characters per line.
> -
>   - When declaring pointers, the star sides with the variable
>     name, i.e. "char *string", not "char* string" or
>     "char * string".  This makes it easier to understand code
> @@ -110,3 +108,14 @@ For C programs:
>     used in the git core command set (unless your command is clearly
>     separate from it, such as an importer to convert random-scm-X
>     repositories to git).
> +
> +Line wrapping:
> +
> + - We generally try to keep scripts, C source files and AsciiDoc
> +   documentation

"We generally try to keep source and documentation" ... ?

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
