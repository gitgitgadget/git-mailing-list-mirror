From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] remote-helpers: test fixes
Date: Fri, 17 May 2013 16:10:06 -0500
Message-ID: <1368825008-2815-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 17 23:11:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdRwG-0000Rq-Nn
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 23:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756301Ab3EQVLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 17:11:40 -0400
Received: from mail-ye0-f182.google.com ([209.85.213.182]:47108 "EHLO
	mail-ye0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab3EQVLj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 17:11:39 -0400
Received: by mail-ye0-f182.google.com with SMTP id h13so736961yee.13
        for <git@vger.kernel.org>; Fri, 17 May 2013 14:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=nk8d7/J1+LdJ+z5/NYVDl55VsWYgP3ll9QaWuV3ZUaw=;
        b=xzvWiEn8h45t1u/vGu8GJOjeWUsnq+uIkzuCZGfXNAZaJbGnH4x//UyWfCLKhYGZor
         Hom2rETWid99gvobYQ1HMYfPpSwRrSIuy67IoPPcK/9VLUzQjxYujBljed4bpKX1mGxJ
         En4LuLYSRjzbv/brhYwr7HqL9kbdXfVgH57AaZwmejtRdfz2f+wEvyNtOsIwVx2THrEI
         pNxvk2hhFxPuPqW6UF1w7oEgrZ48sehpNyPVfH5SO5zp5W600FRbIhSWCmwBP3c1RG61
         y6/Fq38jefI2OYvqoDi8n10c8zeD1XTWb3X2xvgXLNzaTT0OdHLOFQE2XYTlBUNfrjU3
         S/yw==
X-Received: by 10.236.20.102 with SMTP id o66mr27387537yho.125.1368825098689;
        Fri, 17 May 2013 14:11:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id j27sm19915177yhf.18.2013.05.17.14.11.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 14:11:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224738>

Hi,

I've setup a project in Travis CI for continuous integration with very good
results, however, I had to apply a couple of fixes.

I'm not sure if this is v1.8.3 material, but here they are.

https://travis-ci.org/felipec/git/builds/7262886

Felipe Contreras (2):
  remote-helpers: tests: use python directly
  remote-hg: tests: fix hg merge

 contrib/remote-helpers/test-bzr.sh       |  2 +-
 contrib/remote-helpers/test-hg-bidi.sh   |  2 +-
 contrib/remote-helpers/test-hg-hg-git.sh | 11 ++++++-----
 contrib/remote-helpers/test-hg.sh        |  2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

-- 
1.8.3.rc2.542.g24820ba
