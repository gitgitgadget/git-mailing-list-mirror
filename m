From: Andrew Romanenco <andrew@romanenco.com>
Subject: problem with file mode
Date: Mon, 8 Jun 2009 12:09:23 +0300
Message-ID: <18e14dc30906080209m9eceb6ft81c77ea0345b30e3@mail.gmail.com>
Reply-To: andrew@romanenco.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 11:09:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDarG-0004o3-MO
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 11:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbZFHJJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 05:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753561AbZFHJJY
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 05:09:24 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:41825 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941AbZFHJJX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 05:09:23 -0400
Received: by ewy6 with SMTP id 6so3968896ewy.37
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 02:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:reply-to:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=qoZNm4I94sgps2QCVzrWlwdeq2bs2zpfvc/oK6C1FNw=;
        b=W0h0WubdSXbReESSgWZkf3dmWwZWUuxrZ6B1qv5spnuOooLrx9rHS6IEyXdoJLUiK2
         knCa3r/5aGFnQa4BXvxGb5jCN82MtZJfvcTqI5VVnxc2s/Kc2Y7EDn02wmPgEfBu7ZoR
         o3vfR6dGAJRy5Z3c3TSngybVof7+KFMx4ABps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:reply-to:date:x-google-sender-auth:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        b=VLiN7LR9OgXAm/wHBY1AufHVNJ8lwLLo25dFrTUxv4PfLkqGSvahp41os8nj6ymWD2
         QRLJkLRmMPBjek6v0rU9yMVFMRYah92ByrmzYvSOqjJg2/W7L7Y4Yhrj2r5nP7FnFLEv
         Qk0NUgZI5MJ64WDDZLT2L8tf4sTF0wiiapjFk=
Received: by 10.216.22.206 with SMTP id t56mr2256714wet.131.1244452163857; 
	Mon, 08 Jun 2009 02:09:23 -0700 (PDT)
X-Google-Sender-Auth: dc15af43c43323bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121055>

Hello

I have problem with cloning git repo

Both stations are ubuntu 8.10
And I have repo with text files on station A
When I do git clone to station B all files become executable 755
And git status show that all files are modified, diff shows mode change

could you help me with this issue?

thanks
Andrew
