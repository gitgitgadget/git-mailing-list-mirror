From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 15/23] http.c: new functions for the http API
Date: Sat, 6 Jun 2009 09:21:29 +0200
Message-ID: <200906060921.30582.jnareb@gmail.com>
References: <20090606000550.17d48ace.rctay89@gmail.com> <m3iqja5rvc.fsf@localhost.localdomain> <be6fef0d0906051808k19a5a4acu29713c5e84fac4d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 09:21:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCqDl-00065q-K7
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 09:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbZFFHVe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 03:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbZFFHVd
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 03:21:33 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:62109 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbZFFHVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 03:21:33 -0400
Received: by bwz9 with SMTP id 9so1942858bwz.37
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 00:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dBP4mv3ouf8M9znXIrZuo1RJB6OUYItdkzUFNXy8qXU=;
        b=ZANWqzYaXsE3/P3dHDk6D1Qt6s9o120Bwb1uEKO+iXQyrseP5mWtudzs5gxcORwsME
         /8Cxcx8SKg/oM3zmOCTUCn8gcTnu4DSDpjSgmv+V0YRcx61pr9fwV1JZY5IzZO+xnb00
         vj6vO1XkakT4TyX/9NdmHAr1YetjGtI3BXqqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rD6jlM8H0SNezUCGK3zQ3ptHGWF3Tcl7HAP2pUtKAMrKnmEQ9cw6Gv2LihUqTu/VH+
         7+FENKUIqI3KkP/3sN95lOUGGxLPGIbYpDCB7k7f6UWUqmERpg6bO4dSARk8CCaOhXFb
         g/exwoOqvTP9WLgTaS2tVE9LVIh+cn+R9HAB0=
Received: by 10.204.54.198 with SMTP id r6mr3992093bkg.191.1244272893868;
        Sat, 06 Jun 2009 00:21:33 -0700 (PDT)
Received: from ?192.168.1.13? (abwo21.neoplus.adsl.tpnet.pl [83.8.238.21])
        by mx.google.com with ESMTPS id g28sm690812fkg.15.2009.06.06.00.21.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 00:21:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <be6fef0d0906051808k19a5a4acu29713c5e84fac4d7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120877>

On Sat, 6 Jun 2009, Tay Ray Chuan wrote:
> On Sat, Jun 6, 2009 at 4:50 AM, Jakub Narebski<jnareb@gmail.com>=20
wrote:

> > Or perhaps it better be
> > =A0"http.c: Add http_get_strbuf() and http_get_file() to http API"
>=20
> I also add http_error(). Listing out 1 or 2 functions in the subject
> is ok, but 3 is a stretch, IMO; I think the reader can know the
> functions added by reading the commit message.

You are right. Somehow I missed mentioning http_error() in the commit
message.

>=20
> Perhaps you think an enumerated list of the functions added in the
> commit message would be preferable?

I think the way you did in other commit messages in this thread, with=20
enumerated list of added functions (even if in case of this patch they=20
are set, rather than sequence), and later description of each function=20
(or subset of function) is a better way.

--=20
Jakub Narebski
Poland
