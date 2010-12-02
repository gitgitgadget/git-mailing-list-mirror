From: Eugene Sajine <euguess@gmail.com>
Subject: cannot find hash in the log output
Date: Thu, 2 Dec 2010 14:57:08 -0500
Message-ID: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 20:57:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POFHJ-0002cu-38
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 20:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757947Ab0LBT5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 14:57:11 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56688 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757709Ab0LBT5K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 14:57:10 -0500
Received: by bwz15 with SMTP id 15so7601082bwz.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 11:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Ay9VY17uahaC+ADgPx1Kkc1thQDwE1+ljW2LGpBdbWg=;
        b=gkSEbi9AqZQFt3VN26aNG1wpjGb9sKyR6Ndqc4lDIQgaq7vFfkt8kNbxAUxGTKd8sS
         QCqP+zKCdDJL+CConwq8U9LF+aSWSAwI9jwkMzIci+f+PTlr/URcLwE8YqXI/TU1rTe+
         YM0b9uo46KZz2L+isuKOjKR2G7SfWwnJJIjJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=PyAGNgdaMkz78KHMashSsY8Ufv56RKR/X6n4d9/HJxQ0M3N37/3+Kdn0paXbZfb4pG
         BbsgLaar1eRuuy/AlhulekTB2iftIXsm7KRxTfSGOUrZ/TUWShqzEeqpSLUwZna9eggt
         oADp/WUVkHPcl8KmwUxnWsC1yKR1RdJdTGo/4=
Received: by 10.204.57.18 with SMTP id a18mr1331751bkh.164.1291319828964; Thu,
 02 Dec 2010 11:57:08 -0800 (PST)
Received: by 10.204.152.206 with HTTP; Thu, 2 Dec 2010 11:57:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162743>

Hi,

I have a strange issue (git v 1.7.3.2). I'm cloning the repository,
navigating to the folder containing some scripts and performing
git hash-object <one_of_my_scripts>

Then I'm trying to run:

git log --raw --no-abbrev | grep <resulting SHA1 from previous command>

And i don't see anything.

How is that possible, considering no local changes to the file has
been done, working directory clean?? How could the file get into this
state?

Thanks,
Eugene
