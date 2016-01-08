From: Federico Bond <federico.bond@gmail.com>
Subject: git pull --rebase --autostash
Date: Fri, 8 Jan 2016 12:24:09 -0300
Message-ID: <CABKJOiy1+QAgp=_3ofr4CqNH7ZPP_eR4P71yGSgeAYLBz92AZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 16:24:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHYuM-0007KK-0w
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 16:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304AbcAHPYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 10:24:50 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36047 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbcAHPYt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 10:24:49 -0500
Received: by mail-ob0-f179.google.com with SMTP id ba1so356623627obb.3
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 07:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=wGC6Aa9Kt8l4jF+BQY1foHJldE/R8G8NmO9jL901mTU=;
        b=zMucqQQqNn303azDTRCUDHBR9B0U4Mc+6nyZyZZf4nILpMulGvaqoyQPGrIPWcIaVv
         EOuskVlQKHZfn+7Rj3WNXSDaKzuo7JseescutCfpVndqUshSRvRg9CVEHGgDGOJK43SX
         NK34GBEijS97m+LaA34xn4OwHm/obkb/0bGqqbWedR3sdJ5whCByDBMOdqLVCKB0reoy
         JxpSsQp7dCIEGKmrJXxmINU/z2C6GWdqYfbfzSNxBLi4PbvwUs7hWBuxUjY77EN33DSB
         wjUsoeZArMoPJ+47IL3VKd+50bby4Ray4JZjn/6uaJSqodaQc3eqavKVv7eHOWhhgrrf
         WVXw==
X-Received: by 10.60.131.147 with SMTP id om19mr8750556oeb.82.1452266689241;
 Fri, 08 Jan 2016 07:24:49 -0800 (PST)
Received: by 10.76.8.165 with HTTP; Fri, 8 Jan 2016 07:24:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283557>

Hi,

I was looking through the changes in 2.7 and learned about the very
useful autostash feature of git rebase which was present since git
1.8.4.

I was wondering if there has been discussion about adding the same
flag(s) for use with git pull --rebase. It seems odd that git pull
--rebase honors the rebase.autostash config setting but there is no
way to override it with a flag.

If you are OK with this, I can work on a patch to add --[no-]autostash
to git pull.

Thanks,

Federico Bond
