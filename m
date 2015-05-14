From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Show all branches and ahead/behind states
Date: Thu, 14 May 2015 09:57:41 -0500
Message-ID: <CAHd499AyEDNM7mDstFugD0Ah46=gAS=BRocDmpmOK-1k+qMCmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 14 16:57:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysua5-0007Av-0i
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 16:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933240AbbENO5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 10:57:43 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35073 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933012AbbENO5m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 10:57:42 -0400
Received: by iebpz10 with SMTP id pz10so62770901ieb.2
        for <git@vger.kernel.org>; Thu, 14 May 2015 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=vaVmk0wRDPJoSsDvWV0ilKG1HWsKnM29ZNIHkksNFOk=;
        b=C+i51I5ho0rQFSl/AIsrNpV0Zey+j7PpqEH4Y96qhC0axvpMFL/AzidJX55UFsjxfG
         hCZQLQPKLm8fyfCNSVOeMBbJOnJzjmg5bPgYj0eIw/ABDiC1AzGFEhHymcpfuTGgYg2f
         gFCr2ByaD9xsR03XddC7IpN3aC9IUUO1UOEW9i49VxpyTR27Mlbv6N8zYqMORJuAyI74
         L3c3v37E6XTTC/RgGAdSjkUftaDmiIlSd+bb067DdUo9mVR7gb7in74f3R3LDGSkCcfB
         fz8F8GaoCX/DXO8zRjeJQKsA83X1w0lpd0tp9P+zmAEJZNMFm8XckyKFBTbRYzdD5RHr
         VtZw==
X-Received: by 10.50.143.33 with SMTP id sb1mr34015097igb.33.1431615461867;
 Thu, 14 May 2015 07:57:41 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Thu, 14 May 2015 07:57:41 -0700 (PDT)
X-Google-Sender-Auth: co04OiK1Fv_dZP9xcVwWuPaus2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269040>

Is there a script or built-in functionality in git 2.4.1 that will
allow me to list all local branches with the ahead and behind status
of each? Basically the first line of:

$ git status -sb

But for every branch would be roughly what I'm looking for. Any ideas? Thanks.
