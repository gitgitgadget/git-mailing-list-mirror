From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Checkout first version of each file?
Date: Tue, 8 Nov 2011 10:58:05 -0300
Message-ID: <CABLeVKF5P_sWwNX+OR_FX4+SPCN+SovZ2QuMmGGvJ-EskK7=YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 08 14:58:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNmC8-0004KG-AB
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 14:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776Ab1KHN62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 08:58:28 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43805 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab1KHN61 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 08:58:27 -0500
Received: by qyk2 with SMTP id 2so538802qyk.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 05:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=ekBvEVzZ4Euo88wz4RHbQi5VZlGodjE/Mx9fog0rPZs=;
        b=HV1LUfPsJLE3s6iv2pHU4Lz/J53DEQpTBFwIXkRO8TxheW/2VVnPLtRRddb5LyPYMj
         cuO7R/+tGIg9dRuy7tB/5gPXh2nyV2gy6ZhpUPAGgJ3SM7WEWPog3cMOiF13nweLCHHC
         qyDtHboAQ6Y5GKlzDxZE7iCPTBJZseSp5qKUI=
Received: by 10.68.4.200 with SMTP id m8mr1016291pbm.50.1320760706072; Tue, 08
 Nov 2011 05:58:26 -0800 (PST)
Received: by 10.142.253.7 with HTTP; Tue, 8 Nov 2011 05:58:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185085>

Hello,

My "issue" comes with my usage of git at work. I work with lots of
applications, each of them part of each system. There are lots of
processes and lots of subsystems, so I never clone the entire repo
into GIT, since it could be painful and slow. Even if I do so,
everyone else is using ClearCase, and their changes cannot be included
into my git repo until they "chickin". Sometimes, I must update
sources from FTP because the changes are not up to date in
ClearCase...

So, I clone every file that I will need to work into GIT, so i can
work with these files having a better control (With ClearCase it's a
foolish "checkout>>lots of changes>>checkin" flow). But sometimes I
don't know how many files I am going to change until I start coding
the requisites.

In this cases, there is a situation that I don't know how to handle.
If I need to rollback every change made to every file I cannot just
checkout the initial commit, cause I've added files after that, and I
need their initial versions too.

So, how can I checkout the first version of each file? (I know that
GIT tracks contents and not files, but the fact is that I need to keep
track on files, it's the real thing I work with)

pd: Sorry about my Argentinian-English (if it sounds so)

Thanks,
Dario
