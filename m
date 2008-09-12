From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 1/2] Documentation: new upstream rebase recovery section
 in git-rebase
Date: Thu, 11 Sep 2008 21:15:16 -0400
Message-ID: <48C9C2A4.6070601@griep.us>
References: <200809030738.09589.trast@student.ethz.ch> <1221147525-5589-1-git-send-email-trast@student.ethz.ch> <1221147525-5589-2-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig35C6663A91437C97E0652A90"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Sep 12 03:21:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdxLS-0007LB-SW
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 03:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbYILBPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 21:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbYILBPg
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 21:15:36 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:48270 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbYILBPf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 21:15:35 -0400
Received: by an-out-0708.google.com with SMTP id d40so75478and.103
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 18:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:sender;
        bh=70TaRr9hPP0LpXdyvnkktj9QgBgGwkk9gY/nRa6CdWc=;
        b=VQ1MOilAUrXTPr4pAOf98wbu4zvVRySdct/clsXWh8AWvvSL0Wu/20G4Qvw2s8Lt/X
         3WQRF6Y3n1bTggyU/rJ+gXnl7pQR8gQWZvFUZbFIo6Ryf4qOK/NwJnT4JAIW7cCR/uhb
         X35C40pleOp1+c5ocIeUkq2rOpgyQWEesDVFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type:sender;
        b=ig/R40CqvqSbWu2Ix1kfVh1owe83APzFVX3wCj1cYISUM8D33o4Xeflq3eNmjOmIl3
         w2ORa6G4rZFo20vBfcqEp9hHTrOuVVFKV8gviyyVYhz9opAAJEtDfyLVMPpVwzWsSE7w
         fU96j5K2eEntQOl9PxnQDho6kymD2XtJzxQlM=
Received: by 10.100.232.13 with SMTP id e13mr4385432anh.140.1221182134681;
        Thu, 11 Sep 2008 18:15:34 -0700 (PDT)
Received: from ?192.168.1.154? ( [71.174.65.37])
        by mx.google.com with ESMTPS id b37sm17702227ana.33.2008.09.11.18.15.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Sep 2008 18:15:33 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <1221147525-5589-2-git-send-email-trast@student.ethz.ch>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95677>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig35C6663A91437C97E0652A90
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thomas Rast wrote:
> +Now suppose the 'subsystem' maintainer decides to clean up his history=

> +with an interactive rebase.  He edits commits A and D (marked with a
> +`*`), decides to remove D entirely and moves B to the front.  This
> +results in

Minor correction:
-+with an interactive rebase.  He edits commits A and D (marked with a
++with an interactive rebase.  He edits commits A and C (marked with a

> +To fix this, you have to manually transplant your own part of the
> +history to the new branch head.  Looking at `git log`, you should be
> +able to determine that three commits on 'topic' are yours.  Again
> +assuming you are already on 'topic', you can do
> +------------
> +    git rebase --onto subsystem HEAD~3
> +------------
> +to put things right.  Of course, this again ripples onwards:
> +'everyone' downstream from 'subsystem' will have to 'manually' rebase
> +all their work!

I like this documentation because it provides another clear case of how
the '--onto' option is used.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4


--------------enig35C6663A91437C97E0652A90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIVAwUBSMnCsQPFruyc22R/AQKUBQ//YKJIkFZZF60vfK/AMNpcxYYCwhZQg6aF
Ns53wdCcbtFi2pweT6u6fbO7gV6lAWcIlZipXDnFqsVkLSZVoEJOfAljwN/b9Kjn
NnjKgq4+FoZVGFcKMmySO7nLqsG2ZgQvRAe24/OYgmx05nUbgAKlLZFGlvD499pi
v/joXyZdSzEttLF4AAbnp54pIfOh1nkiEjnxXByhiNOtakk+/4PhxW/ELH7fG+v9
W660l06V4AyflLxhb//LOv5ubVJfgdu37JzJ3rblboVx4aRzIRCGbTySvlUABAlE
kPPTqICEgBCOa0ps0JyfkcaZa7BsRc6C7d6ZsTLa4KntCuwC5deov2AP1wgxypeB
s8ppmE+Ahb4CamUwUKptjRbjuqQt02NFxC5eGE6gv27YQqN5M1U4vQ1f7/hpNBWG
K7h3vwcbvYTkscKCe6LPVgGYhL1hqgo6XBnS+6mOheatbOSGsK5KXSiQ3w1jCVjU
icjzZm0FQgO9EP06UFlMXIvglP0/7fCfxPelqoTdHzfkvwVQfFe+w31ulU48GD6E
XYT68ZUoTmE369rLHltbh9XPkiPAVN+03xp/W8cOdGJSvQWpReOVDw6nJmkhHc+Z
7iZkpVhSMcEXmUEZZOxBtxg4WTTbi5qG6kFfN+F2ejSDwC/8XSPIMaT2nqZjanPp
7/0lVySDidc=
=NCpw
-----END PGP SIGNATURE-----

--------------enig35C6663A91437C97E0652A90--
