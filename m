From: "Simon Chiang" <simon.a.chiang@gmail.com>
Subject: Do moves add to repository size?
Date: Wed, 31 Dec 2008 02:11:14 -0700
Message-ID: <85fafb0c0812310111s552247em5f0ca57b737aedc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 10:12:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHx81-00025N-Vo
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 10:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbYLaJLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 04:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbYLaJLQ
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 04:11:16 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:48773 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbYLaJLP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 04:11:15 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2815937wah.21
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 01:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Ig6kKd1ZSSFrKHJFhb9Ej1y4paJ1svLnL7E7npwAuQU=;
        b=g02+WEY3KU4oi88e038D9vuuWmxBG1Jt6CQIlwJBTKHqhrE+OAaOA4QDgcxDycNR7y
         B6wLTJkgovap0pPb2gQe0kk6CZWxitz/nJG4UeTJFT4en3tVN7jT3+QwTizzlIJ/8HcL
         GwcsewFp7NP8fIvrWKSC6qaGnrM9C7UNrHrv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=HYr6GV5aGacVs1Z8eR9FAtoTNRH5xU/nHQcN9aDkvLVi2bYyd1Rz9VxKgUNQCUYIU2
         y+AOD31Wtv2nSXX6PAtQawkT6Ex/qrS84pXytwhdl7FIc6KyQ/U9fFAalyVtDfg5mY9i
         Hzec8QVHL9Czf7l8/29i8tpBUzN+/9cBSelmU=
Received: by 10.114.124.1 with SMTP id w1mr10350700wac.132.1230714674821;
        Wed, 31 Dec 2008 01:11:14 -0800 (PST)
Received: by 10.114.202.11 with HTTP; Wed, 31 Dec 2008 01:11:14 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104259>

Hey, I'm quite curious to know if moves/renames duplicate the file
content in the repository (and hence grow the repository size) or if
they just change the location of the content.  I want to drastically
reorganize a repository and I'm wondering if will double it in size.

Thanks,

- Simon
