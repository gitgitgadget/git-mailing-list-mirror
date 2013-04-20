From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [QUERY] Why do we have git-completion.zsh?
Date: Sat, 20 Apr 2013 15:09:51 +0530
Message-ID: <CALkWK0=NrJ-9mxSkOBw=kJ0CTJLUFNWBoGdqGcHEU6YqR-foFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 20 11:40:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTUHn-00043D-ER
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 11:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab3DTJkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 05:40:33 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:45760 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780Ab3DTJkc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 05:40:32 -0400
Received: by mail-ia0-f170.google.com with SMTP id 21so3925269iay.1
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 02:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=61oNN77CI2BOkWz3r+UFXjyQrMEiO28D3y+mWStJrAo=;
        b=rOAWWhdm9ERLvmsW/G5YBi0S5aeYHL1xzgwm13Acy5E6zr6mOV3sdaNngKdO9WoBcA
         DZqGJesFYWPuwoHsvOO8nhfLl3l0xrGwusQg0xwdGGlGqk1QH+67a1qpF3fwdVGg0FUq
         lxqOrc8IJ6QujuCIHgbAcNsLbaMAkdZrQ5/6glnQwSfSqyIwD4RMCef2VLX6tALaRiF5
         OHgKC9mXNsMrvmk5aSn6aMNxmXYDA2n0H5hm5NBC6y6AhzAF5/589rv0Qp9Ihi6QB4mc
         BpVaQx9wsdihK9r4CDZgUQCgVcvncGiEQH5UsF2rar3Lu4nlWEoI1iX/SI45qd+/im65
         bd8w==
X-Received: by 10.50.17.166 with SMTP id p6mr4121234igd.12.1366450831753; Sat,
 20 Apr 2013 02:40:31 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sat, 20 Apr 2013 02:39:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221839>

Hi,

I realize that we maintain a bash completion script, and a thin
wrapper around it for ZSH.  However, I don't understand why we
maintain it, because there's a comprehensive first-class completer in
ZSH core [1] which I use all the time.  Shouldn't the completion folks
be contributing to this instead?

Thanks.

[1]: https://github.com/zsh-users/zsh/blob/master/Completion/Unix/Command/_git
