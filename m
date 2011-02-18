From: Jeenu V <jeenuv@gmail.com>
Subject: Hint for rebase in progress
Date: Fri, 18 Feb 2011 13:42:15 +0530
Message-ID: <AANLkTikY-e7pD1nnbnz_m41wn0AbyF7Fj4z8K6WuznOL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 09:12:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqLSO-0006nJ-2X
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 09:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603Ab1BRIMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 03:12:48 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55865 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519Ab1BRIMq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 03:12:46 -0500
Received: by wwa36 with SMTP id 36so3482912wwa.1
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 00:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=HfnQcrZzKjJHBRLNdK+MFrxMiOHR4LA8AcyqVeIWhkQ=;
        b=VOO2cOPLIpmxBVEqp4orhr2SMNgC5pLlQRoMPfzcWJrwgUdXzfX2oeKb41RHdSBHvM
         Kym2Zwz1umcaep5U3z8AQa4QzPbZRX1bB44yDUHRWu9QzDG6arNhgMAwbNzddsbZcxKD
         fWA3pFk2PRC36aZsSYbYOsfOMd4dCvG/bfePQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=K/HHVWH0WQ9Rw7dQNLylH4I2jsUNgIJ+REUwoU+52F8XOh0A5KHF36ZRplE4FKIudy
         qmlKsvJH/mO2W6gSxV96zgzaUji74ts0ZpGgT4y7UpKO3shqHbxoEiFZAj+FhlCTWRYA
         va4b1f2HZzEr0h1msWLEI/DTINAjTQHxBkPRQ=
Received: by 10.216.48.211 with SMTP id v61mr343345web.35.1298016765161; Fri,
 18 Feb 2011 00:12:45 -0800 (PST)
Received: by 10.216.53.8 with HTTP; Fri, 18 Feb 2011 00:12:15 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167185>

I was once in the middle of an interactive rebase, editing a commit
and happened to do a git status. I could see that Git warns in red
color "Not currently on any branch". Similarly, git branch said "* (no
branch)". Having gone this far, wouldn't it be helpful for Git to also
remind "Rebase in progress" or something like that, some where in
these hints? Since git status is meant to display the current status
of the tree, I think it's only apt for it to report so.

Because, once in a active rebase session, I think there's no command
which tells user that an interactive session is in progress (or is
there?); gitk doesn't help either. If the user happens to take a break
or something, it might be bit perplexing to figure out where he was,
why it was (seeing the working directory headless).

-- 
Jeenu
