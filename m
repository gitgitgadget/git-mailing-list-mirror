Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B0B320248
	for <e@80x24.org>; Thu, 11 Apr 2019 17:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDKRUk (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 13:20:40 -0400
Received: from tschil.ethgen.ch ([5.9.7.51]:48774 "EHLO tschil.ethgen.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbfDKRUk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 13:20:40 -0400
X-Greylist: delayed 2156 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2019 13:20:39 EDT
Received: from [192.168.17.4] (helo=ikki.ket)
        by tschil.ethgen.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <klaus@ethgen.ch>)
        id 1hEcob-0004TD-4G
        for git@vger.kernel.org; Thu, 11 Apr 2019 18:44:41 +0200
Received: from klaus by ikki.ket with local (Exim 4.92)
        (envelope-from <klaus@ethgen.ch>)
        id 1hEcoa-0008R3-Rm
        for git@vger.kernel.org; Thu, 11 Apr 2019 18:44:40 +0200
Date:   Thu, 11 Apr 2019 17:44:40 +0100
From:   Klaus Ethgen <Klaus@Ethgen.ch>
To:     git@vger.kernel.org
Subject: fatal: unable to read after commit
Message-ID: <20190411164440.GC12669@ikki.ethgen.ch>
Reply-To: Klaus Ethgen <Klaus@Ethgen.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi folks,

I am a heavy user of git now at version 2.20.1 on debian.

Since some weeks I have the problem that I get often "fatal: unable to
read ..." and a unclear repository after a git commit. The commit itself
is correct and so a git reset --hard helps to fix the issue.

Any Idea what could be the reason for that problem. I encounter it on
different repositories so not limited to one.

Any hint how to find out the reason?

Regards
   Klaus

Ps. I am not subscribet to the list, so please keep me in the response.
- -- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C
-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAEBCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAlyvbvEACgkQpnwKsYAZ
9qyeggwAjLjfP8M2+Bybc6WFCnPjT2tAoU2Rpt1w7lPfycbqOykwa8YHML9Hy4OW
G+ODpR3SXnRgKDzQ8xpz7i5/6pNC3ZlAYrvnOQFPHpL6zlOWr9aeDo8wai8FzVKk
4ei32u3Gw/bu0tH6D/SKxCVjC8sZzHWx+NjUDJh8ld3ln5RmF5XpK5+UvVak/nal
rj+MxUyB1Aklho5cnwlFbdW0aUOM6Iom4G5uZz3dfh3p2VuPNzbbU/RKYXHGrJIB
01/Wh67r9XsML8z2kwYrpmT6Hcpuz/uuuIw81fHp55419YcbtS9bCJsYwYy0BGo0
LWJX5PzyMbWbbJE6oS1YDZOfnY/W/iIdq9JysMsyt1+nURcWNkHdOQ4+vY5DeBDa
/kEDH9BLyzGddLAShYvspMpZg2J5c0v1FtX9N7q4A/vUyemevpQKJq+qJPV1WelI
7Hs45gvWj7oTOxVE4yJtMYkdO1jZLznVSLG36XT06+ciXiBl2FmVkTZ9yQaRse9L
bIWDVDXp
=4x1q
-----END PGP SIGNATURE-----
