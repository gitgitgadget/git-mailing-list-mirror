From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/config.txt: Order variables alphabetically
Date: Wed, 1 Dec 2010 17:37:52 +0100
Message-ID: <201012011737.53652.jnareb@gmail.com>
References: <1291209174-9239-1-git-send-email-jari.aalto@cante.net> <201012011557.30849.jnareb@gmail.com> <20101201150917.GD6537@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 17:38:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNph4-0005wX-Jt
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 17:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099Ab0LAQiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 11:38:05 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47089 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab0LAQiE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 11:38:04 -0500
Received: by bwz15 with SMTP id 15so6289928bwz.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 08:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=OVlLcXC4fkJqP3EQzrPiig+qzxDUusVBM+kRX0AO6nM=;
        b=lfFNyUBE4tyVSjI/JwJtzJt2wJwxHTjJ/2cPmNhXODjBuVVegkFJaVdtMzJgwNHt4z
         TC81mIVSA0qhySWYxibjoZ2DNO6uIpps3MZ4McKrd6QvcaybeMbyyiY9SB/rap9dpwUg
         Yoe14oj9zMVq6f2sHDcXIZDYOn7RQEHhwBxqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wvGfgDCA1/wUFAy/PLamDsHvgcHM8v9yT85xXVPuRqWjtVVwbefiLJ8lKOMBvxEBjI
         6EelmBPMhRA4TSxorE8TGXTYAibu12VYuh+u1mssr3eba+8gPgG6YUPeulYijQfLr6sR
         DntFRbFEt3yrAKNBWNDvP6f0q5cJ3sDQtDPi8=
Received: by 10.204.112.81 with SMTP id v17mr8847608bkp.165.1291221481802;
        Wed, 01 Dec 2010 08:38:01 -0800 (PST)
Received: from [192.168.1.13] (abvl90.neoplus.adsl.tpnet.pl [83.8.209.90])
        by mx.google.com with ESMTPS id b17sm3509565bku.8.2010.12.01.08.37.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 08:38:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101201150917.GD6537@picasso.cante.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162546>

Dnia =B6roda 1. grudnia 2010 16:09, jari napisa=B3:
> On 2010-12-01 15:57, Jakub Narebski wrote:
>| On Wed, 1 Dec 2010, Jari Aalto wrote:
>|> On 2010-12-01 05:58, Jakub Narebski wrote:
>|>| jari.aalto@cante.net writes:
>|>|=20
>|>|> From: Jari Aalto <jari.aalto@cante.net>
>|>|>=20
>|>|>=20
>|>|> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
>|>|> ---
>|>|>  Documentation/config.txt| 1698 +++++++++++++++++++++++----------=
-------------
>|>|>  1 files changed, 852 insertions(+), 846 deletions(-)
>|>|=20
>|>| Why?  What such large change is for?
>|>|=20
>|>| Note that currently config variables are grouped by functionality:=
 for
>|>| example core.eol and core.safecrlf, or core.compression and
>|>| core.loosecompression are close to each other.
>|=20
>| What about the above?
>=20
> We use standard biblical refences:
>=20
> 	 Se ....
>=20
> Suggest what is needed, and it will be so.

Having related config variables together is IMVHO more important than
having config variables sorted alphabetically.

>|> The phone books have an index where to up information.
>|>=20
>|>     - When you see script and it use VARIABLE, you look it from
>|>       manual page
>|=20
>| Manpages (and 'git <cmd> --help') are displayed in pager, so you can
>| always search for option in a pager (e.g. '/' in 'less', the default
>| pager).
>=20
> Yuck, it's real fun start backward/forward ping-pong when you dont'
> know the directions and can't rely on standard A-Z index.

No need for backward/forward, simply go to beginning ([Home]) and searc=
h
forward (/<pattern>), or go to end ([End]) and search backward (?<patte=
rn>).

>|> It is same as putting option in alphabetical order. See GNU cp(1),
>|> ssh(1) etc.
>|=20
>| In git documentation command line options are not in alphabetical or=
der,
>| but grouped by functionality, therefore your argument is invalid.
>=20
> I see that only in pages that have tens and tens and tens of options.=
=2E

And git command doesn't have tens and tens of options?

BTW. you discarded my counterexamples of tar, rpm and uname.

>=20
> The problem is more the asciidoc's. Various bits and pices are
> "included" in place and make ordering the options impossible in some
> pages.
>=20
> Let's get all pages in shape with A-Z in this regard. That's a good
> quality goal.

If it is impossible to have options ordered alphabetically because comm=
on
options are extracted to separate file and then "included", why bother?

>=20
>|> There are zillion values and for a reference, alphabetical order ma=
kes
>|> sense.
>|=20
>| I agree that alphabetical order makes sense for glossary; I disagree=
 that
>| it makes sense here.
>=20
> About 60% in git-config is already in alpha order (core.*, sendmail.*
> etc), so there is not really much that is changing.

core.* is not in alphabetical order: we have `core.eol', `core.safecrlf=
',
`core.autocrlf'.

sendemail.* is not fully in alphabetical order: we have=20
`sendemail.smtpserverport', then `sendemail.smtpserveroption' (p-o, not
alphabetical o-p).
=20
> Well. If standard reading order is not the standard, I don't know wha=
t
> is.

I'd rather, _if we must_, *generate* gitconfig(5) file with alphabetica=
lly
ordered configuration variables (and subvariables).

=46unctional grouping is IMVHO more important than alphabetical orderin=
g.
--=20
Jakub Narebski
Poland
