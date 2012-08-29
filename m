From: Orgad and Raizel Shaneh <orgads@gmail.com>
Subject: relative objects/info/alternates doesn't work on remote SMB repo
Date: Wed, 29 Aug 2012 09:43:11 +0300
Message-ID: <CAGHpTBKNurqd0xcz9A9bC8MQU8yHfef0ozJ2Khr9uQvwHoyP2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 08:43:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6bzk-0000bh-MS
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 08:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab2H2GnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 02:43:13 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:48010 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab2H2GnM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 02:43:12 -0400
Received: by qaas11 with SMTP id s11so3298909qaa.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 23:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Ye44RLNuT8GYmf7MN4beDGwsqgLNmBZzpFQSKgBVA8E=;
        b=xz2chGIldHVVyh0e2E5xHreA4x4CtOjTQ/6CQSpG21DEcjuS1LSK8G5gEbHVQSGbHU
         GFd1cD9tr3hCtG9bWwK7sxo3LMZcTjC4PPmvs2oQRFnWKgDXL59yZIZrHUzUQVgBDhYW
         sjdcVvwcwGxDaU4pXPGIurbrnis27XDmZPmiBnrkUjEkga4jvuh0yr13MEHllIfv2dwH
         2Ux7gbx0KVzfAWnLL+Vd5/NilWjcB64Sy/mORpaaXtCM1QzhS3VjyuRTU5s+lEkmZtBZ
         qnjBbhAh8R2/Yn00geLWbYhrooWgLMDk1R6v3OacCD0Vv0FVWouhQRsp65YuIVHIGzqI
         AGXQ==
Received: by 10.229.136.9 with SMTP id p9mr247770qct.73.1346222591653; Tue, 28
 Aug 2012 23:43:11 -0700 (PDT)
Received: by 10.49.131.8 with HTTP; Tue, 28 Aug 2012 23:43:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204469>

Hi,

I have a repo accessed through //server/share/foo/repo (Using msysgit).

.git/objects/info/alternates contains '../../../bare/objects'

Running 'git status' (or almost any other action) gives the following output:
error: object directory /server/share/foo/bare/objects does not exist;
check .git/objects/info/alternates.

Note that it tries to access /server instead of //server.

- Orgad
