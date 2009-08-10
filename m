From: John Bito <jwbito@gmail.com>
Subject: [EGIT] Push to GitHub caused corruption
Date: Mon, 10 Aug 2009 14:46:34 -0700
Message-ID: <3ae83b000908101446q2d4f1101we4bbd7023f78b03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 10 23:46:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MachX-0001Zk-Q3
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 23:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbZHJVqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 17:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753895AbZHJVqe
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 17:46:34 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:36991 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbZHJVqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 17:46:33 -0400
Received: by gxk9 with SMTP id 9so4565769gxk.13
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=ZqwkOnOcgzR9geOigEL3xjjv18DJY3ONJZitl1WapTU=;
        b=KyB33CLhsYxtlfTmPEHaszmJfGLb5v84Em9gcGB1R5Qb6tgRVPnL892fc5X29J0Fto
         4p6B0OcerfpV3+w3SGU5/+d5PKe3+DAbJ1YV2xLQACj4Abidgd6DxY58KUczqktge4vf
         TbgX8orFl6iVEsxLBetzHDybiPpurMl6zUpWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=FMH2s98B7IHdnHGPxRp3FVUIrGFvehMiGk9uIIy2C589LmeitcAWChf9PNJS1j6LmE
         1QtufY8WiplVE8+HGwiT6qiC1yyDuweahedYAesxnCx8zCFYNb0MhUuxZUIogIvVZWdf
         pl2OffVARIBsjvjShcYPJD5vnd1K1GqSutfz8=
Received: by 10.90.28.16 with SMTP id b16mr4432930agb.44.1249940794319; Mon, 
	10 Aug 2009 14:46:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125501>

Using the 'release' build of EGit (0.4.9.200906240051) I pushed a
commit to GitHub.  After that, using git to pull, I get 'bad tree
object' resulting in 'remote: aborting due to possible repository
corruption on the remote side'.  I had a similar problem back in April
(using integration builds of 0.4.0).  I'm willing to investigate if
there's interest in finding the root of the problem.
