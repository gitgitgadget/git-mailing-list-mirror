Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C1C22013C
	for <e@80x24.org>; Wed, 15 Feb 2017 01:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdBOBoi (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 20:44:38 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53290 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751267AbdBOBoh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Feb 2017 20:44:37 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BB53C280AD;
        Wed, 15 Feb 2017 01:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487123075;
        bh=cYQG1YKzmLUypVeMO9s+3Unyzxv8PaDQqP4SKpIxJcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLjL2wl+ghoeEZpIau/NzIq+47g4e5cfDEofFh+Hvh9SnpTZ/R/HiW+vsN7IWAZE7
         YNrNiRf0A8nUBqSjJAI3TKQIpuE3Fce/Agsn46UCtyGrLIrfzlLGsfiNyB8IAkuhu7
         3xz89QOBdqQDo+9AgGdmJxojtwsznEL6vxkn1B/Wfn5I9Th7PRoYTjPNx0U+vU2Qvg
         XwJZMcALMdPTzU6rMMX1JK6c54GPJdcEor82Tf2OK9iStPnrGwT8SBCtdFj/WiY23l
         H71tA5BCMRGQfzgSD/Z39YoAiTlG2O8SnCsXJhUmpjOvk0bRaOXw1lwoZO8//erjK/
         2Rjfui2O7XF+jS1TAOnFvN7++044Rwu2B2b06jlKtoTWswiBSSTdij2/Exc3sPKDXG
         LptzdZQywhG1693WIM8caJHjZBWGna4HWlnr2ICBU/z4F+jOQsAcG8G8BJZaX6F/Tr
         3wcnM7rovSLPRlUmm1mqWzDtlTmdh5Yn4Hjwy8yah+kGA47hOru
Date:   Wed, 15 Feb 2017 01:44:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH 01/14] lib-submodule-update.sh: reorder
 create_lib_submodule_repo
Message-ID: <20170215014430.ngd5wtnvhe2nt6q5@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        bmwill@google.com, jrnieder@gmail.com, gitster@pobox.com
References: <20170215003423.20245-1-sbeller@google.com>
 <20170215003423.20245-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="33jpoq3yijmfzwwn"
Content-Disposition: inline
In-Reply-To: <20170215003423.20245-2-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--33jpoq3yijmfzwwn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2017 at 04:34:10PM -0800, Stefan Beller wrote:
>  create_lib_submodule_repo () {
>  	git init submodule_update_repo &&
>  	(
> @@ -49,10 +54,11 @@ create_lib_submodule_repo () {
>  		git config submodule.sub1.ignore all &&
>  		git add .gitmodules &&
>  		git commit -m "Add sub1" &&
> -		git checkout -b remove_sub1 &&
> +
> +		git checkout -b remove_sub1 add_sub1&&

You're missing a space before the "&&".
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--33jpoq3yijmfzwwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlijsn4ACgkQv1NdgR9S
9oufEA//XwvTcOZkgvMRANbnfy5F5rErETCk8QvHrJOZdua6lNES62MCHLyPloJm
CrWFrLv1hCc5LLSNGgua8CI6NiH1K8JVFoDWX2Y+GaW1HGB0D7K6oJN1pTeQjRHS
6luhwXcyNeBekb8HqiQLU6t+adnjCZUXEtJjS3Etmyg02YqpLl/bQh3cXiHm72QM
yN4PcQZWq412NZTkoaiQXdqZ8h2cVQyz0rKo9qW8k2Kd4vxyzAFENLJXSNzfdeSG
9UYFDRSrQQe0I/GtYTy6Vun2CLf5r5AENrKQXRATfN0jlv8nRKbzonTJOaLkAif2
038TFaxvSOe9x+UUkwdd4eXDDq1oTB8aN6ELvIbhr3cS7U4un0tjWUVPje2Mz/fk
c4jAjtP5Sy6/xEQXNBA3LoO53FsX3g9funWYDQ1SA/4+APKQE/rGh8Coff4o7Dn5
ewPON1FJKpTq4wL7fwFklOA4gJmZwpWoEh2m0VufcXI+UnIqIW0MSfkzFobV85Sx
EE4Mg+k3MAOBoCOM0eZ/eTILa5G7iqPS022OSKHWfPUe/e0gKIPYNRuQyphLU2Sc
FcXsdg7IReJkp60ouT0VEBomQdJorRWwa+ShJ4k3X1lEEWayMlcG2EFSxgq6Vb/S
rEG2wnPDo1wmktUQ7AjGVn/mi6U+6eB/zBw79PvnBVVczkM/Yp0=
=CS7O
-----END PGP SIGNATURE-----

--33jpoq3yijmfzwwn--
