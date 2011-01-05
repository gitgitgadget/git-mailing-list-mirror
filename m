From: Edmond Halley <halleyinvent@gmail.com>
Subject: How to import a exist git repository into another git repository?
Date: Wed, 5 Jan 2011 14:50:35 +0800
Message-ID: <AANLkTi=ahqFz=NVMrhtf+u2fJR_PAW-vcXgNYcce=2R+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Halley <halleyinvent@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 05 07:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaNCl-0006oj-Ke
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 07:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310Ab1AEGuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 01:50:37 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37394 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab1AEGug (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 01:50:36 -0500
Received: by iwn9 with SMTP id 9so14976644iwn.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 22:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=qN5HfMKPxTRLj0W/4UmO1VLECZmTObs71K1gi7hz/xk=;
        b=qcSP3gMod0/zYQycL7l/8zHvH3UZdS/8/5CeI/GPJZc1fAVz/zkr5bKaQneloRHufQ
         dH/6ieO8b8qZoQcKSVRfmiVuXptSzDJExyIZVunZ+oi5Ogawty9vTN6K6C7DKtlccOiP
         XLeEcnEXvPtL5fKTV22qwbid92BhTZj/ZkSFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=K/mgxtxHKZEl95Aqq5p4V/Vo8UR29tVJswxl5/HSFL990mVfjNpbohLha4CGUAWDVQ
         I2I5DmPwO2g0BjDbZ3M8ORopgBtU6knOGblZO/Y+mgQr0wUdWQzfSuV8Qro/9ZeiXNga
         bqaYZczuq6970krKs1xhFjji+pFFCrSQeTXv4=
Received: by 10.231.174.71 with SMTP id s7mr6523367ibz.56.1294210235952; Tue,
 04 Jan 2011 22:50:35 -0800 (PST)
Received: by 10.231.157.9 with HTTP; Tue, 4 Jan 2011 22:50:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164552>

Hi,

I have two exit repos A and B. I would like A becomes part of B. For example:
original:
A
|-- a.cpp
`-- Makefile

B
|-- b.cpp
`-- Makefile

combined:
B
|-- b.cpp
|-- Makefile
`-- A
    |-- a.cpp
    `-- Makefile

The git log of repo A is kept in the combined repo.

I try google but the following methods turn out they do not work like
what I want. I can not view the log of original repo A after
combining.
1) http://stackoverflow.com/questions/1683531/how-to-import-existing-git-repository-into-another
Fail at the following command.
git checkout -b ZZZ other/master
error: Untracked working tree file 'Makefile' would be overwritten by merge.

2) http://thread.gmane.org/gmane.comp.version-control.git/5126/
git log only give the lastest commit message. I do not know how to get
the log if orignal repo A.

Thank you!

Best regards,
Halley
