From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: A Python script to put CTAN into git (from DVDs)
Date: Sun, 06 Nov 2011 08:42:23 -0800 (PST)
Message-ID: <m37h3d430e.fsf@localhost.localdomain>
References: <4EB6A522.3020909@pytex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: python-list@python.org, git@vger.kernel.org
To: Jonathan Fine <jfine@pytex.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 17:42:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN5nj-0002ML-QN
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 17:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401Ab1KFQm1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 11:42:27 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49619 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab1KFQm0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2011 11:42:26 -0500
Received: by faao14 with SMTP id o14so4381632faa.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 08:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:subject:references:to:cc:from:user-agent
         :date:in-reply-to:message-id:lines:mime-version:content-type
         :content-transfer-encoding;
        bh=7w8BKmBv3yC11NWAj3jN/bG0reUkHy1mrnk7mNp+TyY=;
        b=ihY0jy0R2GOYC2OfJaJZOcaaLMJP3O1dnX+LlZmg20sRi2JtheU7weeiqIeJXuZtZV
         QGcrU8oNVlXhVFXcxZd36b89Blj2TyvlX7dNvdq/2+FpRHKo09ylaWp4ju9w1ncaPBQ2
         bYT2rofcuXYzsgrdrYrMy6CNEmNP5UNbdVpUA=
Received: by 10.223.75.150 with SMTP id y22mr40220605faj.29.1320597745058;
        Sun, 06 Nov 2011 08:42:25 -0800 (PST)
Received: from localhost.localdomain (aehn151.neoplus.adsl.tpnet.pl. [79.186.195.151])
        by mx.google.com with ESMTPS id y10sm24205552fal.10.2011.11.06.08.42.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 08:42:23 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pA6Gfxuj030835;
	Sun, 6 Nov 2011 17:42:04 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pA6GfcVP030824;
	Sun, 6 Nov 2011 17:41:38 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
In-Reply-To: <4EB6A522.3020909@pytex.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184918>

Jonathan Fine <jfine@pytex.org> writes:

> Hi
>=20
> This it to let you know that I'm writing (in Python) a script that
> places the content of CTAN into a git repository.
>      https://bitbucket.org/jfine/python-ctantools

I hope that you meant "repositories" (plural) here, one per tool,
rather than putting all of CTAN into single Git repository.
=20
> I'm working from the TeX Collection DVDs that are published each year
> by the TeX user groups, which contain a snapshot of CTAN (about
> 100,000 files occupying 4Gb), which means I have to unzip folders and
> do a few other things.

There is 'contrib/fast-import/import-zips.py' in git.git repository.
If you are not using it, or its equivalent, it might be worth checking
out.
=20
> CTAN is the Comprehensive TeX Archive Network.  CTAN keeps only the
> latest version of each file, but old CTAN snapshots will provide many
> earlier versions.

There was similar effort done in putting CPAN (Comprehensive _Perl_
Archive Network) in Git, hosting repositories on GitHub[1], by the name
of gitPAN, see e.g.:

  "The gitPAN Import is Complete"
  http://perlisalive.com/articles/36
=20
[1]: https://github.com/gitpan

> I'm working on putting old CTAN files into modern version
> control. Martin Scharrer is working in the other direction.  He's
> putting new files added to CTAN into Mercurial.
>      http://ctanhg.scharrer-online.de/

Nb. thanks to tools such as git-hg and fast-import / fast-export
we have quite good interoperability and convertability between
Git and Mercurial.

P.S. I'd point to reposurgeon tool, which can be used to do fixups
after import, but it would probably won't work on such large (set of)
repositories.

P.P.S. Can you forward it to comp.text.tex?
--=20
Jakub Nar=EAbski
