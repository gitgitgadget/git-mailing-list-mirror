From: Michal Nazarewicz <mina86@tlen.pl>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 02:16:20 +0100
Message-ID: <87hc6gjs7v.fsf@erwin.mina86.com>
References: <87ljvsjuq7.fsf@erwin.mina86.com>
	<bd6139dc0811091643m31ff6f49o55a4c581be7f38b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon Nov 10 02:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzLPj-0002ym-5g
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 02:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407AbYKJBQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 20:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755345AbYKJBQo
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 20:16:44 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:28396 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbYKJBQn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 20:16:43 -0500
Received: by nf-out-0910.google.com with SMTP id d3so986618nfc.21
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 17:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :x-url:x-pgp-fp:x-pgp:date:in-reply-to:message-id:user-agent
         :mime-version:content-type:sender;
        bh=aDNp+rJj5HkwKfsER9cKNkscUtdWbl+lkowmFWF0A8s=;
        b=UA2do3yIXUdERVqNS6qYjP3uesVlINCo1tToMlY2bNWeGC1ethXvaGloZeAexQwruI
         XzcOe76oRtR8Z0e26ffyttxQ4rlolgPtf9amHfQowpN0bTUJDsOOpQ8dopQz5nP0RoyY
         ulmp0Cmb681mQrU8ME5T3Ut1dlhX0/O6xeIc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:x-url:x-pgp-fp:x-pgp:date:in-reply-to
         :message-id:user-agent:mime-version:content-type:sender;
        b=r4gnHz5pzlebvfjPJy1oS02ZRxQmEiZm0vYzPiyfhJeD9SDf9Onw4U22BbHMuAMQ9K
         vfQ6ciWW5L/G0Fv+rlbvFJrVk3bdSmMkaCAt173XLNLct0YoCQwku+5QNNRpuL+gWn5D
         cBSxkphIIAmcFOHherZmMATuup1izwAVlCdbk=
Received: by 10.210.119.16 with SMTP id r16mr895146ebc.147.1226279801558;
        Sun, 09 Nov 2008 17:16:41 -0800 (PST)
Received: from erwin.piotrekn (dng132.neoplus.adsl.tpnet.pl [83.24.88.132])
        by mx.google.com with ESMTPS id c24sm225508ika.23.2008.11.09.17.16.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Nov 2008 17:16:40 -0800 (PST)
X-Url: http://mina86.com/
X-PGP-FP: 9134 06FA 7AD8 D134 9D0C  C33F 532C CB00 B7C6 DF1E
X-PGP: B7C6DF1E
In-Reply-To: <bd6139dc0811091643m31ff6f49o55a4c581be7f38b2@mail.gmail.com>
	(Sverre Rabbelier's message of "Mon, 10 Nov 2008 01:43:41 +0100")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0 (Slckware Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100485>

--=-=-=
Content-Transfer-Encoding: quoted-printable

"Sverre Rabbelier" <alturin@gmail.com> writes:

> On Mon, Nov 10, 2008 at 01:22, Michal Nazarewicz <mina86@tlen.pl> wrote:
>> Now, what I need is such feature in GIT.  Upon committing I would like
>> some magic string (say "$Date$") to be replaced with some value
>> identifying uniquely given version of a file (a date of the commit would
>> be sufficient).
>
> Please have a look at the relevant entry in the faq [0].
>
> [0] http://git.or.cz/gitwiki/GitFaq#head-4a0afe71a2bb7734777a8b0b345e0308=
aefdbd40

Thanks for the quick reply (and yes, I can't believe I couldn't find
that myself...) but it still lacks one thing that I'd like to have.
I would like the "$Id$" sequences to be updated automatically after
a commit (ie. without the need to check out).  (Besides I would prefer
$Date$ more but I can live with $Id$ I guess ;) ).

=2D-=20
Best regards,                                         _     _
 .o. | Liege of Serenly Enlightened Majesty of      o' \,=3D./ `o
 ..o | Computer Science,  Michal "mina86" Nazarewicz   (o o)
 ooo +--<mina86*tlen.pl>--<jid:mina86*jabber.org>--ooO--(_)--Ooo--

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkXi3UACgkQUyzLALfG3x71DgCfXL+bitgjLKU81XhTaGdDQcEs
3TUAoI8GLea6WuwVDiXk4BBudQXhnAom
=4PBH
-----END PGP SIGNATURE-----
--=-=-=--
