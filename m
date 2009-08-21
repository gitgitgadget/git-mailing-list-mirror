From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH 05/14] Change regerror() declaration from K&R style to 
	ANSI C (C89)
Date: Fri, 21 Aug 2009 22:37:21 +0800
Message-ID: <1976ea660908210737y7168d5d5od56485a1b4ab2956@mail.gmail.com>
References: <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
	 <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
	 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
	 <cover.1250860247.git.mstormo@gmail.com>
	 <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com>
	 <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 16:37:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeVFE-0002S5-ML
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 16:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbZHUOhW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2009 10:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbZHUOhW
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 10:37:22 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:38631 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932291AbZHUOhV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2009 10:37:21 -0400
Received: by qw-out-2122.google.com with SMTP id 8so437540qwh.37
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 07:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LLC7y0u5yiFSXu64K3YXiwlyAh8u5DF5Mue7g91RpFI=;
        b=WRcMjyE+vD6aTg4D2JFqyQM3aQ9/kLxOhAFNajUkSpyLrqP4HNiC4MKSF2FEtq1YQo
         gFnxpYqvz2JzHcW9mG4BqFrE1kMy8tUJ9ip6CjbT3jNGqZeoT9BTrikgEfi7+4XB/OvY
         CDT4g4w7y5mpYJ61XzmraQIyIrAx8oYeK2/fA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jpwQwC+vQCgNrgWjJi6cBVw/vcw5vFjPIPOMUVQ6N1/q+CYhu0KdKpd5MYUZcxjOnt
         M3ogYkgpWUavCnVDRCak9X8AQHXNy19+b4jmFsYwobFMDsUeaegh3hI8CJEiUpd8PZng
         i8vWD4mmwhmp78I7PERlINUye9TyLvcF7qu5U=
Received: by 10.224.102.212 with SMTP id h20mr756258qao.40.1250865441723; Fri, 
	21 Aug 2009 07:37:21 -0700 (PDT)
In-Reply-To: <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126728>

>
> =A0size_t
> -regerror (errcode, preg, errbuf, errbuf_size)
> - =A0 =A0int errcode;
> - =A0 =A0const regex_t *preg;
> - =A0 =A0char *errbuf;
> - =A0 =A0size_t errbuf_size;
> +regerror(int errcode, const regex_t *preg,
> + =A0 =A0 =A0 =A0char *errbuf, size_t errbuf_size)
> =A0{

The true reason is MSVC type define errcode as int.
=46rank Li
