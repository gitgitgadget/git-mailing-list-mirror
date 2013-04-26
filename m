From: =?UTF-8?Q?Pierre=2DFran=C3=A7ois_CLEMENT?= <likeyn@gmail.com>
Subject: Possible bug report
Date: Fri, 26 Apr 2013 16:59:26 +0100
Message-ID: <CANWD=rVdAVP0KSdai-tQf9VtVj7bOLMrENiG_fx-mD_R2f8SnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 17:59:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVl3v-0007en-QO
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 17:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219Ab3DZP7r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Apr 2013 11:59:47 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:54995 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558Ab3DZP7r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Apr 2013 11:59:47 -0400
Received: by mail-vc0-f182.google.com with SMTP id ht10so282538vcb.13
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=hjSa9YucmqkcNVRrzC45CRs07XRRQM6vVaXCLN5Ogk0=;
        b=ne7srk4OaAKXapjF6iBLwbcVQQ9+HJzNCiYuGqqwC9+ZAx3+85L0i0XTtGDDVLtlvz
         M2E1fxlDz1N4dw4XCsuCuLOr4LUS6zVKBCNf2gsuFWW97A/HcA4gvzFXNVY54pDvZYSR
         U24/nOptnO4SW2dI+kwAfazng/hv5AaeG5o8JL/vC2PNd/S3jZhDs/By00t0GN71oC+U
         C732G1yic/ljJ2fi1qpMjl8w87m0cdRtVo1qwfZyVJPDlX33YI3g/ACNG2VngdNDSdp/
         fgB2IiZ/sQSaCgbCrA9YXXeR8y+yOPKNOu/iD217aB5BLIDDAmM1IUtDLhFjmdqon6cJ
         jzXQ==
X-Received: by 10.58.214.231 with SMTP id od7mr29399834vec.44.1366991986323;
 Fri, 26 Apr 2013 08:59:46 -0700 (PDT)
Received: by 10.58.106.42 with HTTP; Fri, 26 Apr 2013 08:59:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222534>

Hi guys, I get strange result when running the following command:

$ git diff develop..HEAD --shortstat --cumulative
 27 files changed, 886 insertions(+), 101 deletions(-)
   9.2% apps/frontend/modules/conversionspecs/actions/
  35.2% apps/frontend/modules/conversionspecs/templates/
  45.0% apps/frontend/modules/conversionspecs/
  45.2% apps/frontend/
   8.7% config/doctrine/
   4.8% lib/filter/doctrine/
   8.1% lib/form/doctrine/
  21.9% lib/migration/doctrine/
  10.0% lib/model/doctrine/
  44.9% lib/
  12.9% apps/frontend/modules/conversionspecs/actions/
  37.1% apps/frontend/modules/conversionspecs/templates/
  50.6% apps/frontend/modules/conversionspecs/
  50.7% apps/frontend/
   6.6% config/doctrine/
   3.2% lib/filter/doctrine/
   9.1% lib/form/doctrine/
  20.6% lib/migration/doctrine/
   8.5% lib/model/doctrine/
  41.5% lib/

As you can see, the --cumulative lines seem to be duplicated, though
the computed stats aren't exactly the same... It appears when you
combine the --cumulative option with either --stat, --numstat or
--shortstat (but not --dirstat) on any local or remote branches EXCEPT
on both master and origin/master.

I use git-flow and git v1.7.9.5 on Ubuntu 12.04 LTS.
Let me know if you need any further informations.
--
Pierre-Fran=C3=A7ois CLEMENT
Self-employed web developer
Application developer @ Upcast Social
Phone number (FR): +336.827.331.89
Phone number (UK): +447.449.508.188
http://www.linkedin.com/in/likeyn/en
http://www.doyoubuzz.com/pierre-francois-clement/
