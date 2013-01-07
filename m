From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: git push --force to update tag
Date: Mon, 7 Jan 2013 10:23:52 +0800
Message-ID: <CAHtLG6Ss=KE8j_VZWf77A9FXantnwJvdDi1uoN9M-XO0c9GgEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 03:24:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts2Np-0001Qa-S3
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 03:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409Ab3AGCXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 21:23:54 -0500
Received: from mail-vc0-f170.google.com ([209.85.220.170]:35026 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311Ab3AGCXx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 21:23:53 -0500
Received: by mail-vc0-f170.google.com with SMTP id fl11so18863102vcb.15
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 18:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=1CeEXl76pPP7b5CMn4z0Rzd0XDVJS6BF4hF2DCouwiM=;
        b=Fj33euJBWyThabekvpPz8r2WrmJBH8Jjt08iCYRvGst5El/X0dh1ZgIxwS40L4BjpX
         zCXYV4FfcSLmCiejdQomLo8sqR+i3OE5I8BNZuDKSo53SKCVm0tUVLBOlumyN1KmVgYG
         VgAxH3vaW2qE1AX7kX4AJbclLec9RgOHYLdrLeFWelumytOlY6klsz6xu7pyZYmA85pw
         tYmQzKpuopDrO8JdU53TGSGvT9mf7G99qcUs142iBgCvU/LvswP44ka9J7msULojckDR
         tZsy6kVeaIdPqVoF3W1PeU+uGgr/UI4fYED6JFy3V0xbkCpSFMInBiHp5h8Zzcvo/ByZ
         uoJA==
Received: by 10.58.172.103 with SMTP id bb7mr84155135vec.41.1357525432369;
 Sun, 06 Jan 2013 18:23:52 -0800 (PST)
Received: by 10.221.6.201 with HTTP; Sun, 6 Jan 2013 18:23:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212868>

about git 1.8.2

 * "git push" now requires "-f" to update a tag, even if it is a
   fast-forward, as tags are meant to be fixed points.

Does the server side validate this? Do we need to upgrade git on
server side to support this?
