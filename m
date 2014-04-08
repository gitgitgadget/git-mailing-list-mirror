From: Olivier LE ROY <olivier_le_roy@yahoo.com>
Subject: Re: Handling empty directories in Git
Date: Tue, 8 Apr 2014 11:06:09 -0700 (PDT)
Message-ID: <1396980369.49724.YahooMailNeo@web120801.mail.ne1.yahoo.com>
References: <1396968442.95061.YahooMailNeo@web120806.mail.ne1.yahoo.com> <vpqob0blpna.fsf@anie.imag.fr>
Reply-To: Olivier LE ROY <olivier_le_roy@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 08 20:06:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXaPb-0002fh-Hf
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 20:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757982AbaDHSGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Apr 2014 14:06:13 -0400
Received: from nm27-vm3.bullet.mail.ne1.yahoo.com ([98.138.91.157]:29040 "EHLO
	nm27-vm3.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757933AbaDHSGK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 8 Apr 2014 14:06:10 -0400
Received: from [98.138.100.111] by nm27.bullet.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 18:06:09 -0000
Received: from [98.138.88.239] by tm100.bullet.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 18:06:09 -0000
Received: from [127.0.0.1] by omp1039.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 18:06:09 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 601713.18954.bm@omp1039.mail.ne1.yahoo.com
Received: (qmail 56065 invoked by uid 60001); 8 Apr 2014 18:06:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1396980369; bh=BKJSBQHLvti1VhmrWc9py++pEjN6WnrdxHUzIsWR/jQ=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=ERaMZRWelKpA0QmQNqbiFukV69/Xs/ItsFx7NP+iv0xKPsJAXN0NNEzZFstIkvPjlPPKvEQQxVeeQs5Z64s7T3hWgOuqanZBpid8a5PF41IwNSNLEHUXm2yIvenaJAp8V+gfwG7MIerjhQaHItjZ7wrbprG132olkL6P6rQILvk=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=k+qQQePXxHlfC/eAfXiic8pzvAiV23uDquVd6ZRgmSuXR2S3n9LFtvkzB8gaZ3yqDS4FUKMRAEG6D0VIj1pDmor5Ikt9BOQLMY9r1vRnb7p5yIa2xNTAOZg/WI/tVHkXDAJ7RRe5PGUbFpAh7N7PgksYRNZCBRnoXZ6Q2oxnS7M=;
X-YMail-OSG: SiYtTKAVM1lc0bThi.2fw7ZDFXWDv50lMMMhXcNHADbYIEG
 oX3lG3MO8BLFkedwOXei0J5USE5ig2uJwvbJJd1peIWUF29apapwqGWrf9.s
 QpC6wO06JOy0qORJ3tAD7.4_vhARcYpKk5Fv7BGUXs4byNX3CtanGir27TaL
 BSnMwaLJswGw5zn_bhVFP.SpukoJQMx2MvdIHih9Qv..sfxzKp9vkVXM.qce
 EhSRB9m1Qw8zeb8HDLd8OXOIALVA7GNg63CJn0YBocHFvcf3MU3F9g4KX.9N
 eQH4350MnnaCF1LWbSr0qO5VTQILQsF84TXbZlRYolWlAB4ybfVNJJz3Dlu4
 o1C1HNH2pEsFlPjHPvxSGrvkDidJyMDrLqdjtCOz.sDGooWHfCI3oTarN5Mh
 fYjMQ8jRf4xjsDmLfkSQxJxpC1wR.z1qXXZ1zoR5o2Ff9QfIq0AGRB.CrWAV
 3fFPkcJGYlUd.bglyc3d1W9zCYSDrpzYWXzVd4St0.rHIafbfhwJINbfc.Un
 KMz5N6SWSBnE5FIXU0Fwwz9Ei6t1KfnJjOx9T_dIytKB5Sk1XkGuZ6tZoeso
 MvCQwIB43SI1_mVIVD5MIRlLkhc.pfzPFbkt7Ns_Y3xxEBAX3twQnqdzJEnk
 oKCI-
Received: from [92.163.125.246] by web120801.mail.ne1.yahoo.com via HTTP; Tue, 08 Apr 2014 11:06:09 PDT
X-Rocket-MIMEInfo: 002.001,SGkgTWF0dGlldSwKCnRoYW5rcyBmb3IgdGhpcyBhbnN3ZXIuIEl0IGlzIGNsZWFyIGVub3VnaC4KCk9saXZpZXIgTEUgUk9ZCgoKCgotLS0tLSBNYWlsIG9yaWdpbmFsIC0tLS0tCkRlwqA6IE1hdHRoaWV1IE1veSA8TWF0dGhpZXUuTW95QGdyZW5vYmxlLWlucC5mcj4Kw4DCoDogT2xpdmllciBMRSBST1kgPG9saXZpZXJfbGVfcm95QHlhaG9vLmNvbT4KQ2PCoDogImdpdEB2Z2VyLmtlcm5lbC5vcmciIDxnaXRAdmdlci5rZXJuZWwub3JnPgpFbnZvecOpIGxlIDogTWFyZGkgOCBhdnJpbCAyMDE0IDE3aDAzCk8BMAEBAQE-
X-Mailer: YahooMailWebService/0.8.182.648
In-Reply-To: <vpqob0blpna.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245939>

Hi Mattieu,

thanks for this answer. It is clear enough.

Olivier LE ROY




----- Mail original -----
De=A0: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
=C0=A0: Olivier LE ROY <olivier_le_roy@yahoo.com>
Cc=A0: "git@vger.kernel.org" <git@vger.kernel.org>
Envoy=E9 le : Mardi 8 avril 2014 17h03
Objet=A0: Re: Handling empty directories in Git

Olivier LE ROY <olivier_le_roy@yahoo.com> writes:

> The solution: put a .gitignore file in each empty directory to have t=
hem recognized by the Git database cannot work, because some scripts in=
 my projects test the actual emptiness of the directories.

Another option is to have a post-checkout hook that does the mkdir for
you. Or do that in the build system if your use case is to store
untracked generated files in the directory.

> Is there any expert able to tell me: this cannot be done in Git, or
> this can be done by the following trick,

https://git.wiki.kernel.org/index.php/Git_FAQ#Can_I_add_empty_directori=
es.3F

Short answer: it cannot be done.


> or why there is no valuable reason to maintain empty directories unde=
r
> version control?

The reason would be closer to "there is a valuable reason, but not
valuable enough to change Git to do it". It's actually not so easy to
track directories properly. Storing them in the Git repository is
actually possible (actually, an empty tree is a special case of this,
and is obviously supported), but defining and implementing a decent
behavior for each Git command wrt this is not trivial.

David Kastrup gave it a try a few years ago. I don't remember exactly
what made him give up, but it was never completed and merged.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
