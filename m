From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Git Bug report
Date: Wed, 5 Oct 2011 09:22:35 +0200
Message-ID: <20111005072235.GA12600@kolya>
References: <1317763443.17036.15.camel@skyplex>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Federico Lucifredi <federico@canonical.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 09:22:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBLoC-0006Cc-Fs
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 09:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757884Ab1JEHWY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 03:22:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50730 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755813Ab1JEHWX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 03:22:23 -0400
Received: by bkbzt4 with SMTP id zt4so1742659bkb.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 00:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T+siBrsZxpe6B2IZwg1I2GylDt515tFtNPEXsBYRWHE=;
        b=FIti9Y6JlRZASo4kJqBbV3kdJVDEBzsgd5nOFaKJLLobYyeSzcCG+OSAlBzbdiD1vg
         MRf+uBVQ8qSTONgBV8ukWE+3ewDewKyCNtR0boAneshaFkD4UZR+4drs1p0tj1EWpraC
         38jtR7jVFm2ArS18KJj7LpxBv9m8ypXc2b8dQ=
Received: by 10.204.156.91 with SMTP id v27mr1348962bkw.179.1317799341951;
        Wed, 05 Oct 2011 00:22:21 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se. [85.24.185.240])
        by mx.google.com with ESMTPS id s12sm699400bkt.4.2011.10.05.00.22.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 00:22:21 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1RBLoJ-0003Ho-R6; Wed, 05 Oct 2011 09:22:35 +0200
Content-Disposition: inline
In-Reply-To: <1317763443.17036.15.camel@skyplex>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182834>

On Tue, Oct 04, 2011 at 05:24:03PM -0400, Federico Lucifredi wrote:
>  Found a minor bug in git today - the error message reported is not
> correct when trying to access a repo that is not accessible
> permission-wise:
>=20
> > federico@skyplex:/etc$ git log
> > fatal: Not a git repository (or any of the parent directories): .gi=
t
>=20
> with correct access permissions, everything works as expected.

So if:
=2Egit/ is a directory with not enought permissions.
=2E./.git/ is a directory with enought permissions.

git would today use ../.git. You suggest that git instead would die
because a .git/ exists? (I'm not saying this is wrong or right).

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

E-post: iveqy@iveqy.com
Tel. nr.: 0733 60 82 74
