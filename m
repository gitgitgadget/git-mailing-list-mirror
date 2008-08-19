From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] adapt git-cvsserver manpage to dash-free syntax
Date: Tue, 19 Aug 2008 09:12:35 +0200
Message-ID: <20080819071235.GD11842@schiele.dyndns.org>
References: <20080818141704.GC11842@schiele.dyndns.org> <7v3al1lunw.fsf@gitster.siamese.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="83Y2sXKo4f/n2njO"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 09:14:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVLPv-0006ck-Of
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 09:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbYHSHMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 03:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbYHSHMs
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 03:12:48 -0400
Received: from gv-out-0910.google.com ([216.239.58.184]:46779 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbYHSHMq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 03:12:46 -0400
Received: by gv-out-0910.google.com with SMTP id e6so624525gvc.37
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 00:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:from:reply-to;
        bh=SabQ5JzFC5caHwvYIfrgT8bePvz3z10Pm4hWYtA9jog=;
        b=sUWuhLNWXe4/s27H/77h+Ky+kGHqIaieVKdXZ7WDjuMSKmn8HKPHIVzWtZ9lU64m7M
         uvD8wyuNUKkDhnsOjX3QZP2Gq1/3lrkg/7d6fbUrRErnF3IOiA0lsqTSEPo5NO8depTY
         oPZPEGABB75H7/0sAG7uXrdW4Z5MOxEVnXbGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:from:reply-to;
        b=nrU0kktKqKf9lSpZu4IHUYT0mgWmlPtTRUXtGetfsMQXWqJdkOXK1u2kBiv4AUtN3+
         6/Rhd3LslUnsTp1N89TczBUZKbf6XPEOyAau54z/AhplxbyWckwG8QArly1lUk/mVY8e
         xMR5krcaJ346Pn2E7YKdFCGQpk2VH1bh0JAKo=
Received: by 10.103.131.18 with SMTP id i18mr4559718mun.116.1219129963795;
        Tue, 19 Aug 2008 00:12:43 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.123.131])
        by mx.google.com with ESMTPS id t10sm106497muh.16.2008.08.19.00.12.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 00:12:37 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id CCD4316053; Tue, 19 Aug 2008 09:12:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3al1lunw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92818>


--83Y2sXKo4f/n2njO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2008 at 05:23:31PM -0700, Junio C Hamano wrote:
> Thanks; have you tested these instructions, by the way (I haven't)?

You mean whether I tested that replacing "git-cvsserver" by "git cvsserver"=
 in
CVS_SERVER does work?  Yes, I did with cvs 1.12.12 on Linux.  I had concerns
myself because of the space, especially in the syntax where CVS_SERVER is
inlined into the CVSROOT but everything worked without any issues as long as
you quoted the strings correctly.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--83Y2sXKo4f/n2njO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFIqnJjxcDFxyGNGNcRAgqHAJ4pUh74dKs5LndcM2QCX34inob1YACgk5LG
/nKpxEC34FScX0qShAxtU9Q=
=sdVf
-----END PGP SIGNATURE-----

--83Y2sXKo4f/n2njO--
