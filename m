From: Levend Sayar <levendsayar@gmail.com>
Subject: git repo corruption
Date: Tue, 4 Jan 2011 11:10:38 +0200
Message-ID: <AANLkTi=TSy1WQZARNQgGfPiV93hQ-xmCTip75JAixgDB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 04 10:11:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa2v6-00009k-PZ
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 10:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab1ADJLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 04:11:00 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49967 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab1ADJK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 04:10:59 -0500
Received: by qyk12 with SMTP id 12so15935964qyk.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 01:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=OFeubhRuri/HJM0O8MhqTbIE/NH3S+6JGsZon5PiP5Y=;
        b=M6iuagkrs9U3F4+VG+JLBjVoYI66ElDqGof1YULA0/mTnWuvVstepB5Ko2S10OSWf/
         P8MYhAvlIqyi/v6yI2jnxt8dWKBRvSFfswGRZa+D/rmTmlt4RhHgzJ6IeCiy+XPTSR++
         mNvZKhb3xmgGY216NEtyJiqIXqFjPKPTPeRnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=gvywpeM39GwMjeICeQZJcdrBKf2qmtVVSyUmODUNBJ2he/jOx+tYiMJ+qWQRBrXCf8
         NxWGPypfxgsKSjVaxGOyYckz514IPiB+wJxjPfX6C6S0p6jtbOxUuu3Uxz9OsBd91Q0r
         QqROFTva7T3reZ7BgvKEbMNLWr+Gq8NfgUCnE=
Received: by 10.229.230.80 with SMTP id jl16mr909757qcb.240.1294132258801;
 Tue, 04 Jan 2011 01:10:58 -0800 (PST)
Received: by 10.229.219.147 with HTTP; Tue, 4 Jan 2011 01:10:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164480>

Hi, all.

We have a repo on a corporate server. The sysadmin changed access
rights of files on our repo by accedant.
Some directories have 2750 acces rights before, but he changed as

chmod -R 2770 *

Now when you make git status, every file that is tracked by git is said as

changed but not updated

So is there a way to get this back to normal ?

TIA

_lvnd_
(^_^)
