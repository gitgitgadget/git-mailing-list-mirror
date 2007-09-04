From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/3] archive: specfile support (--pretty=format: in  
 archive files)
Date: Wed, 05 Sep 2007 01:13:32 +0200
Message-ID: <46DDE69C.1080908@lsrfire.ath.cx>
References: <46DC4D45.4030208@lsrfire.ath.cx> <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org> <46DCF0EF.9020604@op5.se> <Pine.LNX.4.64.0709041139140.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 05 01:13:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IShah-0003E4-0Y
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 01:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977AbXIDXNq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 19:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbXIDXNq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 19:13:46 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:37424
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752403AbXIDXNp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2007 19:13:45 -0400
Received: from [10.0.1.201] (p508EDAF7.dip.t-dialin.net [80.142.218.247])
	by neapel230.server4you.de (Postfix) with ESMTP id 98E78873B5;
	Wed,  5 Sep 2007 01:13:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709041139140.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57655>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Tue, 4 Sep 2007, Andreas Ericsson wrote:
>=20
>> Junio C Hamano wrote:
>>> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>>>
>>>> The attribute is useful for creating auto-updating specfiles.  It =
is=20
>>>> limited by the underlying function format_commit_message(), though=
=2E=20
>>>> E.g. currently there is no placeholder for git-describe like outpu=
t,=20
>>>> and expanded specfiles can't contain NUL bytes.  That can be fixed=
=20
>>>> in format_commit_message() later and will then benefit users of=20
>>>> git-log, too.
>>> Interesting. I however wonder if "specfile" is a good name for this=
=20
>>> attribute, although I admit I do not think of anything better offha=
nd.
>> "releasefile", perhaps?
>=20
> Maybe we should not so much name it by purpose, but by function.  How=
=20
> about "substformat" for the attribute name, and replacing any=20
> $Format:blablub$ inside those files with something a la=20
> --pretty=3Dformat:blablub?

I like the $Format:...$ notation.  How about naming the attribute
"template", as that's what a thus marked file is?

Ren=E9
