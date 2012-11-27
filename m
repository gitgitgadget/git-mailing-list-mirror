From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/4] t4041 (diff-submodule-option): minor cleanup
Date: Tue, 27 Nov 2012 14:11:28 +0530
Message-ID: <1354005692-2809-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 09:42:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdGjt-0007nT-Rt
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 09:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758329Ab2K0Ilm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 03:41:42 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55401 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758294Ab2K0Ilm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 03:41:42 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so5764871pad.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 00:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=opBLXVtO1W6Q8w0a3UFogDo+q2Ta/DKTFE30qgu9LTg=;
        b=f0/eaVX3sTmeRJlY5VccojLGtYcy36NtMdaNdoA9szLAvZScZoeEpKx62X/nzRFXGx
         Ku0KSyJ9CTVA8fgXI+qajB21sz+0oJomGK4h26bA5Dkoi4Nw2tgIZ7cbVUYckEaR1f8H
         8rEUaKk3ZANaYiw1JrQA1/RGUpynL+OAzwH2MVVu3mukeiHIIMpZN6kT2JvCX/HOzc2t
         Ny0/2yEvXXD1KZG6KZ+Xj3h7yw1a9xQADQMVOIkIbT8T5p3XT70RLO9j3ojMClKe2Ysl
         MjJSEVD1Ohx5YJjkCn6oYssrjLvGsCyOrqaTH5rMHPTupC5u+Sw+4U4xKsFVgKMOaGYh
         c4MA==
Received: by 10.66.78.231 with SMTP id e7mr40935708pax.44.1354005701642;
        Tue, 27 Nov 2012 00:41:41 -0800 (PST)
Received: from localhost.localdomain ([49.206.179.73])
        by mx.google.com with ESMTPS id vi9sm10284793pbc.41.2012.11.27.00.41.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 00:41:40 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210544>

Hi,

This is the result of one lazy afternoon.

Ram

Ramkumar Ramachandra (4):
  t4041 (diff-submodule-option): parse digests sensibly
  t4041 (diff-submodule-option): rewrite add_file() routine
  t4041 (diff-submodule-option): modernize style
  t4041 (diff-submodule-option): change tense of test names

 t/t4041-diff-submodule-option.sh |  484 +++++++++++++++++++-------------------
 1 files changed, 240 insertions(+), 244 deletions(-)

-- 
1.7.8.1.362.g5d6df.dirty
