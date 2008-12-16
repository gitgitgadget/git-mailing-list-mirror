From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Undo a git stash clear
Date: Tue, 16 Dec 2008 15:07:28 +0300
Message-ID: <c6c947f60812160407l1b2593e1pde817f5cfb091d59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, git-users@googlegroups.com
X-From: git-owner@vger.kernel.org Tue Dec 16 13:08:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCYjK-0005y3-AO
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 13:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbYLPMHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 07:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753574AbYLPMHb
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 07:07:31 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:40953 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbYLPMHa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 07:07:30 -0500
Received: by bwz14 with SMTP id 14so3620202bwz.13
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 04:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=h26ac0ebe9ShTq9EdjIFdFUMEUq3FBkA/Nne2u86D/E=;
        b=wcRcY0JDqspqcqS0GehN91VQaCHhUOk1YzGEOuBrFX2KqvTcGm0hazgYQUD1gmAy0u
         aDi7pIWCCFhzZj1hWgYdzn1LepnaG9c5dF/gjtoDItOHPR0jp3sez6+OFDUdtJULo4uo
         2u8m1v6yc33fI1tadl3NcSI3xEe09O5wVwNns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=tLCt1FWgCgwf7nMt7dNWR2sU8HVgzfb1ChJb862TsvH3Yjd1HH4K+jFOKOEc7k53Tj
         w7/bBNVhIgddqAB/Du4xH86ATmVO1nadjWbKgR5Zy8eSWSh1TBNEDfaBT9O+7q5bjOPD
         +VnR9fvpG8n1AsSBfs17RlOAS8X/GHpbuqw84=
Received: by 10.181.17.13 with SMTP id u13mr2926979bki.152.1229429248904;
        Tue, 16 Dec 2008 04:07:28 -0800 (PST)
Received: by 10.181.220.19 with HTTP; Tue, 16 Dec 2008 04:07:28 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103273>

Hi, list!

I've stashed some valuable changes and then I accidentally did git
stash clear. (Yes, today is not my day).

Is it possible to restore stashed changes?

Alexander.
