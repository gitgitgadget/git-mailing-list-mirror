From: Alex K <spaceoutlet@gmail.com>
Subject: newbie question
Date: Fri, 3 Jul 2009 11:39:45 -0700
Message-ID: <e4a904790907031139rc61c2e0t6b9dbbc0c3dc379e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 03 20:39:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMnfx-0007ui-21
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 20:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757305AbZGCSjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 14:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756792AbZGCSjo
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 14:39:44 -0400
Received: from mail-bw0-f207.google.com ([209.85.218.207]:41942 "EHLO
	mail-bw0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756684AbZGCSjn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 14:39:43 -0400
Received: by bwz3 with SMTP id 3so515973bwz.37
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=tYtO61RokpXcc1CVD/9puLRY2RTZPuCoQ2fgFuLl/zk=;
        b=WEcxxtLj2d8PAl13NQp7Ni2J0HSf3wAcPrCWoQqmByib+S0PoHX078Gmyj+1QVEyRZ
         LxY5i7owbJLhUCt+q0dbwigU2w30rCQmMzsu0W/O/jirT0LR1D+96GHDgYiYrrSwT8F+
         BJDVoLQmCOUZIaeXHDbQHmQRSgH3IQTCggpcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=SmEHOfnLHQeCgyPjTe3OsTrzQuybddL6eJe7ChJ3ExX+2QGhzMpOd39s2HsfummBGO
         /4ne5htgGM+di0+w0TP9e8dI7hBXCsQB/w3GyvwAL0C9Kzz2S6LYRpxARlK1K8XS1083
         DLP7Nk/2HajeganmmZGinOXZMc261XDeYPSzM=
Received: by 10.204.58.79 with SMTP id f15mr1507625bkh.202.1246646385792; Fri, 
	03 Jul 2009 11:39:45 -0700 (PDT)
X-Google-Sender-Auth: f0ad59f02487629d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122705>

Hello,

I would think the following simple pattern would be possible:

Create two branches A and B. Switch to A, modify some files, do not
commit to A, switch to B. Now B should not show any of the changes
performed to A? However a git status while on B does show that the
files on A have been modified. Is there something I am missing?

Thank you,

Alex
