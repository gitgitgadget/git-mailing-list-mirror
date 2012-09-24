From: Shakthi Prasad GS <shakthi.gs87@gmail.com>
Subject: Can I use tmp_packs in the git root.
Date: Mon, 24 Sep 2012 22:57:09 +0530
Message-ID: <CABx=OHw7P5ZpdDZ8XOKT4T03FUfPNAo9oX2mLR7OB95bWkXG_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 19:27:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGCRE-0005BP-CQ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 19:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756947Ab2IXR1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 13:27:11 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47907 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934Ab2IXR1K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 13:27:10 -0400
Received: by ieak13 with SMTP id k13so11538768iea.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Hnd6BlyYZSNTo101te7x1SD64Dj7V5jpp7VEPgttVeU=;
        b=LsSu+RO0aj3DY/KyHT3mDJRrEcWLyId6I7x5gZSLP/kEaET1Yhuo48YihGDamhgwNJ
         AYZmgCAsyBLOaPxziU0KMR5tK0unauGSTXFExFr5usiObgkO3/I/qeo28b7MNhry9VXP
         JQxRbEydtiXrLK7kkHJ81A3wDPOaQnE98n4oKvRXfcVwJxRD4iIY6lvQ6DgiCwyFEBv9
         siPN+tvE9AZBSszopdawXQ4u6fpt1GB5x1l6iX0cHo32LE/8JWsUe7uLiWOw4yLm+LQs
         SnrV3AEFl2gP/5IFBCCboq5x6+DgWDL3luu/HZfQIq7ZoX9gBAZetxo0YhavuZw6dQeL
         7fag==
Received: by 10.50.182.202 with SMTP id eg10mr5891693igc.56.1348507629764;
 Mon, 24 Sep 2012 10:27:09 -0700 (PDT)
Received: by 10.50.106.129 with HTTP; Mon, 24 Sep 2012 10:27:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206297>

Hi,

I am trying implement git incremental clone/fetch
Please check https://github.com/Shakthi/gitreclone/blob/master/gitreclone
Basically, I am trying to use temporary git packs to avoid re-fetching
of the objects. However, it seems git ignores unpacked objects, and
git-fetch starts again from 0%.

Basically I use, "cat tmp_packs*|git-unpack-objects" . Log indicates
that, objects are unpacked.

Am I doing anything wrong,
Thanks
Shakthi
