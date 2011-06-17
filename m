From: Michael Mc Donnell <michael@mcdonnell.dk>
Subject: git imap-send converting my patches to CRLF line endings?
Date: Fri, 17 Jun 2011 15:35:04 +0200
Message-ID: <BANLkTimXQQX_Fu0fgtWneF2cCLUZFhTaCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 17 15:35:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXZCb-0008R5-1v
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 15:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350Ab1FQNfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 09:35:07 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64733 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab1FQNfF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 09:35:05 -0400
Received: by yxi11 with SMTP id 11so1268720yxi.19
        for <git@vger.kernel.org>; Fri, 17 Jun 2011 06:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=bhA7ba9lMMGnvfbmhZph8ZsNbprlOBnl7w04OW8MPCA=;
        b=dgW5s/3LPM7KZkRjzh4DTFxU7TQUamBjJlkVSaNz8aKsg3j6K7TLa/a/ZbiyuF3EJv
         c5xwrJPJWI5l2VraEYHqUVtJcrf3xdG93qDgQBhic1KbrsbTq/RP8iGr5bbNt9el5DLW
         aSN3w/12UCHd011CSwvfjf0VdiXtxBDSehOk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=Srs71qlE8tjmWeYECdKYPxU1Bsqe4P/+kC28bXTYTI/7up+jWj0MmvEECzR82IiI89
         D5Et6L1l9kMAkjSKCQTXpAFulHqZTBE6IYFL+F/79cbeCUggVI1zgbeP7zPLgvnkknMz
         5pVWcjV6a2aqyT+iRjsm9OGQ9RGl/CYahKyOg=
Received: by 10.146.117.15 with SMTP id p15mr175283yac.32.1308317704371; Fri,
 17 Jun 2011 06:35:04 -0700 (PDT)
Received: by 10.147.113.1 with HTTP; Fri, 17 Jun 2011 06:35:04 -0700 (PDT)
X-Google-Sender-Auth: iZVdZs8BbNbQPf918YW1XZKWlxI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175944>

Hi

I'm using git imap-send to send patches to wine-patches, and it seems
like it converts all my patches to have CRLF line endings?

I can see it when I download the patch from the Gmail drafts folder.
Git complains about white space when I apply the downloaded patch. It
works fine if I just use git to create the patch and then apply it on
a new branch. Is it git imap-send or just Gmail that's the problem?

Is there any way to disable the conversion?

I'm using git 1.7.5.4

Thanks,
Michael Mc Donnell
