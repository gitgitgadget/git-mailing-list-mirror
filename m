From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: starting off
Date: Wed, 7 May 2008 15:00:26 +0200
Message-ID: <8aa486160805070600v5d7b3d2eqce5ee893d0016148@mail.gmail.com>
References: <loom.20080507T121321-885@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matt Davies" <mjdavies@glam.ac.uk>
X-From: git-owner@vger.kernel.org Wed May 07 15:01:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtjH2-0005Ak-Vx
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 15:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbYEGNAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 09:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbYEGNAo
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 09:00:44 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:23489 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbYEGNAm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 09:00:42 -0400
Received: by yw-out-2324.google.com with SMTP id 9so146293ywe.1
        for <git@vger.kernel.org>; Wed, 07 May 2008 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ahDH3gD4SHbocGkMG/SjOAlG6801WWNhGO5+z8gyzy4=;
        b=Dd3F805k/fDz9DF2m/2NdvciaSCvJ+qDxZSwJwP92isDPw9aULEtC8XVktJfRmfSYjjD/e7rebWAnFEOWP9VBXl1HqbySAVj6lDTA4BpJvS/mg5OdpJ13QV4ugSn9nljpw25DizSixDfmHHBwqNRa8XqvB6IJjup1xXbYRtaCtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CLw6ocbyFA3PWCL/hBO4EmroNRoraXNGYuCWb04hL0v7A0YFutGSzBCOhiUX1iPo+l1PMwr5XURXdaP/wGNHEsXCxnZ7f4Yp4/PzJGSdw/DorxgAYTV133UN7N35yzbfv4/p2Xyvt31tPLctW4dgq0zRTZZaTiEGsXzoYx5Osqw=
Received: by 10.150.68.41 with SMTP id q41mr1919873yba.107.1210165226057;
        Wed, 07 May 2008 06:00:26 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Wed, 7 May 2008 06:00:26 -0700 (PDT)
In-Reply-To: <loom.20080507T121321-885@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81433>

On Wed, May 7, 2008 at 2:17 PM, Matt Davies <mjdavies@glam.ac.uk> wrote:
> Hello everyone
>
>  I'm as new as new can be so please be gentle.
>
>  git version 1.5.4.5

Can you remove the double spacing?

>
>  I'm following the peepcode tutorial peepcode-015-git.mov
>
>  I've created a branch, and now we're trying to use
>
>  rebase to 'watch' the master branch from the new branch.
>
>  When I run the rebase command from the other branch
>
>  I get these types of warnings/errors
>
>  http://pastie.caboo.se/192951

Why a link? Paste this inside the mail, this way the mail is self
consistent, the others do not have to go to this site and can quote
it.

>
>  Can someone explain to me what's happening here and if I
>
>  should be worried about it?

Some of the patches introduced lines with trailing whitespaces, git
apply warns about it. You can remove the warnings setting the config
"apply.whitespace" to nowarn, or you can remove them or get used to.

The final result was OK? what you expected?  Did it keept the trailing
whitespaces?

You can try rebase with different
--whitespaces=<nowarn|warn|fix|error|error-all>

>
>  If I should be worried about it
>
>  can anyone point me in the direction of some
>
>  documentation of a good (easy)way
>
>  to remove the whitespace?
>

git rebase --whitespace=fix

At least 1.5.5

>  Thanks everyone.
>
>  PS, I do check the archives and found this from yesterday
>
>  http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=81336

It's a long mail...

Santi
