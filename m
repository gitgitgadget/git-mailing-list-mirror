From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: git checkout -t -B
Date: Sun, 26 Aug 2012 15:27:26 +0800
Message-ID: <CAHtLG6QgnvG6eYEChojY_jB25QWqxis6brbst2ff5FixFLAXAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 26 09:27:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5XFu-0004Ni-FM
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 09:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446Ab2HZH12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 03:27:28 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62676 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab2HZH11 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 03:27:27 -0400
Received: by lbbgj3 with SMTP id gj3so1944422lbb.19
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 00:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=7pzDr5fnOFIcB554qHgS6PDvW6b71RdtGqo67vVkBoc=;
        b=lMGhpynKygmJT/xkGfaeeHOX/i7xHI4jEX7yoOlCSdV+llDy5ZhZB+ynR0NWn+ssRY
         oB/W/zv8Xo6EoeYYx1NHQeMXE3JaUeNIF1EOK4DxpmVMOCQ6Cc6M+0lUapmqVswXfA/d
         OY8TWnZk+5SON2O/04XDmdk70FbDDbUTFjiKx1YIcxfJzanxWUVIfiFhQCYsCfZp1Vki
         c6Xpw59xSHAtkCSz5mLx6CSwg/X6STmMpNZSNh327EvmMPc85Gp5nG+Tvl8lCrf2bf1e
         ShmDFV4J6Tnt3Vz4Gqn3g/CNwi1jPG3xUpdm6qwsdarpmHM85/OsYxWIxSKB8IddUxVW
         HF0w==
Received: by 10.112.51.205 with SMTP id m13mr4806386lbo.75.1345966046469; Sun,
 26 Aug 2012 00:27:26 -0700 (PDT)
Received: by 10.112.19.35 with HTTP; Sun, 26 Aug 2012 00:27:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204294>

Dear Sir,

I want to make current branch abcde a remote tracking branch with origin/abcde.
Since I am working on current branch abcde, I have to use the force option.
So I run

git checkout -t -B origin/abcde
works

but
git checkout -B -t origin/abcde
does not.

Could you document the order of parameters or fix the behaviour?

Thanks,
ch3cooli
