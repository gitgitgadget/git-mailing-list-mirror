From: Alex Blewitt <alex.blewitt@gmail.com>
Subject: Re: [PATCH 1/2] Allow monitor/unintersting objects to be null
Date: Wed, 6 May 2009 22:28:56 +0100
Message-ID: <636fd28e0905061428t519e1923g3ec94caf34ac3db@mail.gmail.com>
References: <1241642224-6914-1-git-send-email-alex.blewitt@gmail.com>
	 <200905062310.12895.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed May 06 23:29:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1ofr-0005r7-Fm
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 23:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758912AbZEFV26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 17:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753858AbZEFV26
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 17:28:58 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:45089 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbZEFV25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 17:28:57 -0400
Received: by fxm2 with SMTP id 2so413677fxm.37
        for <git@vger.kernel.org>; Wed, 06 May 2009 14:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DB+mi9EujMPI+nYw9Yt8X7gy4MvW6xwdJe5sBXbYXaQ=;
        b=R20r4TNpNg2kElD6CAZjj+o6qekis889XULXMohdiZq3GXBtu2T1dkMiRxecDjdD5s
         UZlKyf5ea/mROXDWXRWTYxR4J2xW1UCpVomgqmqur7zwhsmUajiUEV0/ayLd0miy+rdZ
         Ek1bMArMcBaYwuER/Np7orSyQOIwfgQll+2R0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rJvZVk5KQ574Z1aZr795JpC0mDy7XKyVXdhJKid5NIVf3BCTXii6Azf3sD4wkf82Bb
         gCggEgMHt36+L8b7V1Hm42WfTVp52ZFwHuS6YpXvc6BM1F6WwGAThD6A536iv8aZdNxY
         1J7dS3qfBMG1sCgsCrgLVTyRNZqkFRH8FIXsE=
Received: by 10.204.52.2 with SMTP id f2mr1627095bkg.90.1241645336876; Wed, 06 
	May 2009 14:28:56 -0700 (PDT)
In-Reply-To: <200905062310.12895.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118393>

Thanks Robin, that's great. I did attempt to set the subject on git
send-mail --subject, but unfortunately it had no impact; note the
'Subject' on the line.

It works if I configure the .gitconfig though. I'll do that in the future.

apple:egit alex$ git send-email origin/master --subject "Fooooooooo" --dry-run
(mbox) Adding cc: Alex Blewitt <alex.blewitt@gmail.com> from line
'From: Alex Blewitt <alex.blewitt@gmail.com>'
Dry-OK. Log says:
Sendmail: /usr/sbin/sendmail -i alex.blewitt@gmail.com
From: Alex Blewitt <alex.blewitt@gmail.com>
To:
Cc: Alex Blewitt <alex.blewitt@gmail.com>
Subject: [PATCH 1/3] Allow monitor/unintersting objects to be null
Date: Wed,  6 May 2009 22:26:05 +0100
Message-Id: <1241645167-8427-1-git-send-email-alex.blewitt@gmail.com>
X-Mailer: git-send-email 1.6.2.2

Result: OK
(mbox) Adding cc: Alex Blewitt <alex.blewitt@gmail.com> from line
'From: Alex Blewitt <alex.blewitt@gmail.com>'
Dry-OK. Log says:
Sendmail: /usr/sbin/sendmail -i alex.blewitt@gmail.com
From: Alex Blewitt <alex.blewitt@gmail.com>
To:
Cc: Alex Blewitt <alex.blewitt@gmail.com>
Subject: [PATCH 2/3] Use NullProgressMonitor.INSTANCE and indent for loop
Date: Wed,  6 May 2009 22:26:06 +0100
Message-Id: <1241645167-8427-2-git-send-email-alex.blewitt@gmail.com>
X-Mailer: git-send-email 1.6.2.2
In-Reply-To: <1241645167-8427-1-git-send-email-alex.blewitt@gmail.com>
References: <1241645167-8427-1-git-send-email-alex.blewitt@gmail.com>

Result: OK
(mbox) Adding cc: Alex Blewitt <alex.blewitt@gmail.com> from line
'From: Alex Blewitt <alex.blewitt@gmail.com>'
Dry-OK. Log says:
Sendmail: /usr/sbin/sendmail -i alex.blewitt@gmail.com
From: Alex Blewitt <alex.blewitt@gmail.com>
To:
Cc: Alex Blewitt <alex.blewitt@gmail.com>
Subject: [PATCH 3/3] Don't allow others to instantiate NullProgressMonitor
Date: Wed,  6 May 2009 22:26:07 +0100
Message-Id: <1241645167-8427-3-git-send-email-alex.blewitt@gmail.com>
X-Mailer: git-send-email 1.6.2.2
In-Reply-To: <1241645167-8427-2-git-send-email-alex.blewitt@gmail.com>
References: <1241645167-8427-1-git-send-email-alex.blewitt@gmail.com>
 <1241645167-8427-2-git-send-email-alex.blewitt@gmail.com>

Result: OK
