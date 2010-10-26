From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: performance impact of "receive.fsckObjects"
Date: Tue, 26 Oct 2010 19:14:53 +0530
Message-ID: <AANLkTi=aHVO=1-+hvzs-MwdR79mYFd7g24hOwDmrdiwq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 26 15:45:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAjpl-0000vP-Gd
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 15:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758019Ab0JZNoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 09:44:55 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61136 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab0JZNoz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 09:44:55 -0400
Received: by gwj21 with SMTP id 21so3268243gwj.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=MU7m5JtRkHf3sxvoxXVj7wRK2KsehDMVIOWw4A22Byg=;
        b=UxFlvG21PcjfXdb1q4wpriDrjI40CS2zz1dFI2hdSY6UMZs+VyXbvZZynJIeUUdWq4
         Gjtzcz1xxlDIJ1fMYw3Yee81NF/dGW2gG+sDqjVSxXiQYoM8plJ2Tb04jqFpbutHK49t
         kPPEWXSbPct3LraFO/5H+KRCOvpnkdw9/5BIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=yHUg0J7oLJdXgM6oRaSGVs/tHI5KDuOIPqG4OBkBrX5TgyjaL6Gw5tUpGdRX2VIQsp
         zXoETGpTPY0mecV/UTsw6xCA13Diju5hvu13Qx43CVnos+4AsdXycw56iG9/CcKNU0dq
         8Pt6Oisxg1SIVhumDwEOS02vciNvZ42JsZulU=
Received: by 10.150.226.18 with SMTP id y18mr15643397ybg.62.1288100693727;
 Tue, 26 Oct 2010 06:44:53 -0700 (PDT)
Received: by 10.91.55.3 with HTTP; Tue, 26 Oct 2010 06:44:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159989>

Hello,

Would anyone care to comment on the performance impact of this setting?

In crude tests I'm seeing an approx 50% jump in CPU usage with this
setting on a server hosting bare repos.  Does that sound reasonable?

-- 
Sitaram
