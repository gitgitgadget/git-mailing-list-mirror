From: =?UTF-8?B?0J7Qu9C10LMg0K/RgNGL0LPQuNC9?= <arhad95@gmail.com>
Subject: Wish bug report: "Comments to the state" group may be inconsistent
 with real state
Date: Thu, 3 Jul 2014 22:24:59 +0400
Message-ID: <CAOJ_rAC6pcOBVqteK_xe-MVC+tg_R_gyBriDTe-=mbBbvLJgKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 20:25:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2lgz-0004TF-RX
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 20:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbaGCSZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 14:25:03 -0400
Received: from mail-la0-f68.google.com ([209.85.215.68]:46755 "EHLO
	mail-la0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbaGCSZB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 14:25:01 -0400
Received: by mail-la0-f68.google.com with SMTP id gf5so134590lab.3
        for <git@vger.kernel.org>; Thu, 03 Jul 2014 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=++EYsaD8WHxzqUUJ/9yr24zNBfH74t4zCPG0xoIa9CA=;
        b=picEnZTXWxZ1O7uPKSbNVnGKLt0J4aMdqgnztE43+gKHAYIjGNjR6liJW9JCfES/dR
         IGKW/vmEU9tul9805keOkX7NMniO0CflVo02qwX3bLCYfpqMzPFYh0A68kmQaQL/M9Pc
         0EziduIsVyHsz0lYvAhsKvIv5STVG6ubzpGVrp2Lw/ygoynUnvoDB7OUUFF9taDNG47b
         3tnj3iSthPpy3DELUbWcI1VPCzDZ5TWyAqiVGkqVw/i3vHM83PS4prES+3UTc9Gba+OE
         Qnxxbqjm3D++JifWa+AAOquO8ZIasvQGQHoas3QWnScHkiOSrIo3Iv3AYKRtOpOfOzDD
         0NXQ==
X-Received: by 10.152.10.40 with SMTP id f8mr1990152lab.75.1404411899956; Thu,
 03 Jul 2014 11:24:59 -0700 (PDT)
Received: by 10.112.201.38 with HTTP; Thu, 3 Jul 2014 11:24:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252872>

Hello to the community!

I noticed when HEAD is changed outside the Wish (for example in
console) while "Amend Last Commit" option in the GUI is chosen,
committing state becomes inconsistent. Staged files list and commit
description looks like "New Commit" is chosen, but options group still
points to "Amend Last Commit".

I consides that this is a bug.

My Wish version is 0.19.

---

Oleg Yarigin <arhad95@gmail.com>.
