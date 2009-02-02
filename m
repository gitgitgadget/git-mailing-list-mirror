From: Jeremy O'Brien <obrien654j@gmail.com>
Subject: git grep -I bug
Date: Mon, 2 Feb 2009 12:42:57 -0500
Message-ID: <20090202174257.GA8259@Ambelina.erc-wireless.uc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 18:44:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU2qo-0007ja-W4
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 18:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbZBBRnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 12:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbZBBRnE
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 12:43:04 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:38829 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbZBBRnC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 12:43:02 -0500
Received: by yw-out-2324.google.com with SMTP id 9so567261ywe.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 09:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=R++oYmYp2/M5YOPdHiNseSqnOVdSOFHSVnl+Lq8GRPQ=;
        b=vlIeMNOyCDYSmUExStv0cw/2FfeyAqsR5L8b+gLn89U91lmQ1XNWG6o6149ry0onys
         T2uDvxMApZnJF+ArFTUmeiT6SPFGIyijcCbjAKHqu9rcCnRqp/YHCkvfjLlRlHVW4N/O
         NWBFYtppgeRCh3zkRXzaSxBcVYuSoiBPOI3Wo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=vXwaAl/vrd4peTkItZpiZHr6PMxLn2kdaWiM1Odd8CNSLL9o9bxVC+AXHbNGBRpiHx
         2wuHf6JDaTsJxdsrL+ISJwvcgHrB2muZnvQL/09CpUDntWEoRaCCoLQKDjU8X1whaH+l
         Mnej2V6OQVnSqkLBSiUf3gy12UZ2a82TN2U/U=
Received: by 10.65.197.16 with SMTP id z16mr2766193qbp.25.1233596580953;
        Mon, 02 Feb 2009 09:43:00 -0800 (PST)
Received: from Ambelina.erc-wireless.uc.edu (dynamic-181-052.natpool.uc.edu [129.137.181.52])
        by mx.google.com with ESMTPS id k8sm6173706qba.5.2009.02.02.09.42.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Feb 2009 09:43:00 -0800 (PST)
Mail-Followup-To: Jeremy O'Brien <obrien654j@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108099>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I am running git version 1.6.1.2.309.g2ea3.

When I use

git grep -I "string_to_match"

to ignore binary files in my grep, binary files are returned anyway.

When I do a regular

grep "string_to_match" *

grep does not show the binary files. I believe this is a bug.

Thanks,
Jeremy O'Brien

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmHMKEACgkQJUoJkLEUD9tJVQCeJ4+i7ZBP1IgoPcgMCDg0lSEi
CAQAoLFAmdpyvuXeUg682FhQrKTNkOEJ
=fz1w
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
