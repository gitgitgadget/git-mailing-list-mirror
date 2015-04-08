From: Phillip Susi <psusi@ubuntu.com>
Subject: Notes do not follow rebase
Date: Wed, 08 Apr 2015 14:40:59 -0400
Message-ID: <5525763B.3020300@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 08 20:41:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yfuuw-0001Aa-Rp
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 20:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707AbbDHSlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 14:41:32 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33849 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbbDHSla (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 14:41:30 -0400
Received: by qkgx75 with SMTP id x75so92875806qkg.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=pb5qLD6jWG/Npl8dPVUalrGrtDyDCVLfG9s8tk8teck=;
        b=VaTLlAumSsz2j8TDVtGbEf+ozL+EYbeqHiA5l4Xz9xkXDF72loCmiJFUWfZorwc6w2
         IdmFgsKHREer5ufhXsdtruonuJ160JlGKZxFHPQUrExOeF5ZPNv+3nntWs5pN9wIFfrw
         Fxe2NwhD6X8dyYqiTOpvn3agz/epGErxNhkLvlSfo4J1R1r5Z3aKh5JV75+eA7av3OKY
         3lZSTOlJIibue9LDNgI9SGM2pHLd8p9ZhsDM0B5ILTUKTCygpSgR1yp0ygtiBvICGqgU
         qRAC+UePo7KZuVfOY2RAcP/CU3sIo2Cg0rjBE0SxJRMLxET7Ng4vrxzZ/Zlj8tFteAT0
         ia8A==
X-Received: by 10.55.50.20 with SMTP id y20mr52194401qky.58.1428518489462;
        Wed, 08 Apr 2015 11:41:29 -0700 (PDT)
Received: from [10.1.1.228] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id a82sm7234416qka.0.2015.04.08.11.41.28
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2015 11:41:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266968>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

After doing a rebase -i to fix up some older commits, I noticed that
notes I had associated with commits failed to follow the commit across
the rebase, so the notes are now orphaned and will be pruned.
Shouldn't notes be copied to the new commit during an ammend/rebase?



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJVJXY7AAoJENRVrw2cjl5RUe8IAI0tGUeBUAef4xIIU/UfV5eQ
VAdkUfYXCHnkjqukS/iBusyNM3PssabHmRFc+AdKGPPmbsv9JGKpj5G9hwf6Bdh+
RNDPMTlt/Ii90eu+v3uXwFHNUNf0b6kv7Tw63L0bFxGsFzu55DBm48LT/DJ9T05x
Yqz5hbisKAhiVfAep2ib32f8gvC6p47CBmKVY4ii/PpOIzX/clZOQEgSPxvuHcSR
cVcMGdljG+n8UqEOkkX5im0cW7pOUUht5GXWRGnBjXjtKTG64zxZnBPsPcqVJtxT
q/lloKerUktJH3bJbUDU6iefBBzukQyy6tF37nbZH68bwTBlrh8CGL1BT2Eviqs=
=WyFy
-----END PGP SIGNATURE-----
