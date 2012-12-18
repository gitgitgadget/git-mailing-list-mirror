From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Incorrect man page for git-diff
Date: Tue, 18 Dec 2012 18:40:08 +0100
Message-ID: <50D0AA78.5090603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 18:40:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl19e-0004D7-FV
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 18:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925Ab2LRRkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 12:40:14 -0500
Received: from mail-bk0-f43.google.com ([209.85.214.43]:45115 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab2LRRkN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 12:40:13 -0500
Received: by mail-bk0-f43.google.com with SMTP id jf20so513415bkc.30
        for <git@vger.kernel.org>; Tue, 18 Dec 2012 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=b4LgvgLrMz90XXaHLThSKfjAVViX+cGMLg4IvKIPcjY=;
        b=f+lld11d9au1+kCrhJLNg3q0I4t7CVLHDIg5La2lo7ZaDuPZz2Rny4sysrTormit1l
         OamBnRpJ006zuBQ7uiLj6O0EfFPfCJGIMI+Q/OMobI9aMDpwCbteWX/zp9Ak3kiYePsd
         ggVcEraq1n5Vw6+2T2WzryC2u8JtYeUav64tEoa2xVsS3uua0WGpoX1T6Dh0y/9tkLOf
         7xyAjyVB/V/yOnzL9k5M5TvWWTPvTATGITBnGIHOJkTl77MaMnw4wa7c7+ebQ4n8NIiM
         c+aZ3m7XkMy9fnxpneNgtGHDApbyAILA3FZRiJ4UPe/xc0n64l9H2BstbWbxDSudnILO
         12rA==
X-Received: by 10.204.128.203 with SMTP id l11mr1150553bks.70.1355852412135;
        Tue, 18 Dec 2012 09:40:12 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id y11sm2079592bkw.8.2012.12.18.09.40.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Dec 2012 09:40:11 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211766>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

Documentation seems to suggest this is supported, but it is not true:

  $ git diff HEAD:git.c HEAD~100:git.c -- git.c
  usage: git diff [<options>] [<commit> [<commit>]] [--] [<path>...]

unless I'm missing something.



Manlio

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDQqncACgkQscQJ24LbaUT9XwCfV40P7lGulSWw+dzVo17EhcDQ
YFoAnRb46025qYsKWp9mg6ZTRyuuaG3x
=0gO1
-----END PGP SIGNATURE-----
