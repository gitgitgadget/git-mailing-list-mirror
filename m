From: Ryan Sun <ryansun81@gmail.com>
Subject: rebase question
Date: Fri, 11 Mar 2011 14:57:25 -0500
Message-ID: <AANLkTi=8Q+gNSY2jzgMMtPX-JHUy4MUEGNTeK85Ddvys@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 20:57:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py8Sq-0005k0-Tp
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 20:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab1CKT52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 14:57:28 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59235 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab1CKT50 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 14:57:26 -0500
Received: by iyb26 with SMTP id 26so2978809iyb.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 11:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=7oIwB02A/jOMxdiqa/g9PJuxSES6SFaUpAoS3q65PrA=;
        b=Y2lzNbij/xw1wfLtv7oVD0uyAqoXs3X/h2lEz0LDeN0mcPUJqB9nL52kC1CgGe8k1B
         +PeK5KRi/UOwLHJ0TlcViUD9Hoakl7cc8dTOLMZ9iBkMk9aUQcLc1t3YiLjKB4ayDzUr
         Ecm4xzY3dagDsxz3loJ7Jn4dtQBKv609RPwng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=qztIr31bBAYLTwn3iew3/caNaKljuQ17UnIafM+YuD2u4Tt1OQC7BpHY3uTCuWZKTB
         hpA5VNBvK6CsWHrZfeRq/cMZqlhELp9MNwk3kFrUypUvRG+95vJoip4h8sWAK53Fdo5V
         Q/xtUro0PgqlykH1mDwKyfWGRvAziN14H81Hg=
Received: by 10.42.175.7 with SMTP id ay7mr78680icb.298.1299873445216; Fri, 11
 Mar 2011 11:57:25 -0800 (PST)
Received: by 10.42.228.74 with HTTP; Fri, 11 Mar 2011 11:57:25 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168923>

I want to rebase the current branch B1 from origin/A1 to origin/A2
so I want to use this command
git --onto origin/A2 origin/A1 B1

Q1: is this command right? (A2 is based on A1, current branch is B1,
B1 is already pushed to origin, a remote repo, and I think I will
force push B1 after rebase)

but I accidentally typed
 git --onto origin/A2 origin/A1 origin/A2
and git says
----
First, rewinding head to replay your work on top of it...
Fast-forwarded origin/base to origin/base.
----

Q2:I assume this command is safe and it didn't change anything right?

THANKS IN ADVANCE
