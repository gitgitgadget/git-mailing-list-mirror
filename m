From: Johnny Lee <johnnylee194@gmail.com>
Subject: [Question] Why sometimes the unmerged file doesn't contains any 
	conflicts
Date: Mon, 13 Apr 2009 10:35:06 +0800
Message-ID: <488807870904121935nab40117n56070570ecd31aa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 04:36:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtC2T-0008Fd-FL
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 04:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbZDMCfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 22:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752740AbZDMCfJ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 22:35:09 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:13346 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175AbZDMCfI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 22:35:08 -0400
Received: by yx-out-2324.google.com with SMTP id 31so2038425yxl.1
        for <git@vger.kernel.org>; Sun, 12 Apr 2009 19:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=hYz16oEcChR3NVjN+CE5QkWPfLWUrOpmN4PgA57/ulA=;
        b=C+FQrjRrYc1iUIl8eeAeKEwvAxWehJlPciMmgGpDamhu4gP4XNtMbSE/TLVhyVQdgo
         DDCx4EX2H2uouNNOg/AipT56YQ86URBXTW1AzsbuV5XWRds89EYHGdl0bBtPGqSqT2U/
         ZK8eGkZGv/HE2UkbEc6FlH5yhS5qSCCFCIxgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Bhfti52j6Ih6/oIB6slQhJjbFru6Vn9EEatlu4iVpucAINagtrg10Y+IM23aza7fKG
         tjsQu+ge9Gm78CqRIR0+6MkrAgaLrDHmVlebLJ8VvjREMTnSEWywfR8JpJlmlLVMeKuF
         2IwtfUzbqgZ/cHy0YCFliaocnzaQK52jgUJaU=
Received: by 10.150.50.1 with SMTP id x1mr10088910ybx.52.1239590106528; Sun, 
	12 Apr 2009 19:35:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116400>

Hi all,

Sometimes when I merge two branches, the unmerged files don't contain
any conflicts.
When I edit the file, I can't find any conflict information. Usually
all I have to do is manually "git add" them.

I do the merge with a clean workspace, all changes have been committed.
This doesn't happen all the time, usually the unmerged files contains
the correct conflict information inside.

Do you know what's going on here?
The version of my git is: 1.6.2.1

Thanks for your consideration.

Regards,
Johnny

-- 
we all have our crosses to bear
