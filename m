From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] gitk: Update swedish translation.
Date: Wed, 24 Sep 2008 15:31:48 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0809241527170.22419@ds9.cixit.se>
References: <237967ef0809232333y40e36d6bs3205091e3baa701c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 16:33:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiVQp-0001WC-5y
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 16:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbYIXOcP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2008 10:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbYIXOcP
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 10:32:15 -0400
Received: from ds9.cixit.se ([193.15.169.228]:50878 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875AbYIXOcO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 10:32:14 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m8OEVnY1007881
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 Sep 2008 16:31:49 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m8OEVm1H007876;
	Wed, 24 Sep 2008 16:31:48 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <237967ef0809232333y40e36d6bs3205091e3baa701c@mail.gmail.com>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Wed, 24 Sep 2008 16:31:49 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96634>

Mikael Magnusson:

Looks good! A few corrections:

> +#: gitk:327
> +msgid "Error executing --argscmd command:"
> +msgstr "Fel vid k=F6rning av --argscmd kommando:"

The word is incorrectly split (s=E4rskrivning).

  "Fel vid k=F6rning av --argscmd-kommandot:"

would be better (note the change to determined form).

> +#: gitk:2218
> +msgid "Blame parent commit"
> +msgstr "K=F6r blame p=E5 f=F6reg=E5ende incheckning"

"Blame" should probably be translated. git-gui uses "annotate", which
is easier to understand, so possible:

  "Annotera f=F6reg=E5ende incheckning"

> +#: gitk:2997 gitk:3006
> +#, tcl-format
> +msgid "Error creating temporary directory %s:"
> +msgstr "Fel vid skapande av tillf=E4llig katalog %s:"

The "-ande" form makes reading strange.

  "Fel n=E4r tillf=E4llig katalog %s skapades:"

or something similar

> +#: gitk:3039
> +msgid "No such commit"
> +msgstr "Ingen s=E5dan incheckning finns"

It looks like it is constrained for space, but you should check that.
If it is, something like "Incheckning saknas" would work.

> +#: gitk:3044
> +msgid "git gui blame: command failed:"
> +msgstr "git gui blame: kommando misslyckades"

Your missing a final colon, and it should be determined form:

  "git gui blame: kommandot misslyckades:"

--=20
\\// Peter - http://www.softwolves.pp.se/
