From: Orgad and Raizel Shaneh <orgads@gmail.com>
Subject: submodule.ignore is not respected on commit
Date: Tue, 8 May 2012 17:09:27 +0300
Message-ID: <CAGHpTB+BgR4ugNH=cttZSyETgtgL87r0t6yDR=UFyUOfW5L-cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 16:09:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRl6b-0007YD-Qq
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 16:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386Ab2EHOJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 10:09:29 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56406 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689Ab2EHOJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 10:09:29 -0400
Received: by bkcji2 with SMTP id ji2so4649676bkc.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=20+OTWijLEoIEKMyj/u4dRZjNafk1WrlL6ppnhPblBc=;
        b=LXE9iTgeKRJh9DshkbIeEJtS44gSd3/Vi3OOWtMdwT0GY4SsdouZimKzutGsGgBa7n
         BHAAgDc8od84WHvyqC//dcXNZ0QdmtUKoE3uQrgKt0efq3TYPp5x4u87gdro8DPhhykN
         nZGBcKQ9B0sQi4K2D9Zxx8vkoR0OJyJotGG1SIoVwypGFu16pFaxqpbuVpVDcptdEFd3
         eOQY58XWC7SnXpbHUkSQiNhSc9n+542HrtH5Zzirwn8o4Voxnj9493zAUy4Xs/RSrVPh
         Lr5qBdg5FuuDtnvL8o/mTxU1XFSMs62tla4IYCwzvGc1fnKQr7HGMlm+QdT6PMRPj6Bv
         xvqA==
Received: by 10.205.129.8 with SMTP id hg8mr7057330bkc.25.1336486167542; Tue,
 08 May 2012 07:09:27 -0700 (PDT)
Received: by 10.205.82.9 with HTTP; Tue, 8 May 2012 07:09:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197367>

Hello,

Setting submodule.<sub>.ignore = dirty makes git ignore dirty working
directory in the submodule when 'git status' is used.

However, when committing, the submodule status does appear in the
commented lines.

- Orgad
