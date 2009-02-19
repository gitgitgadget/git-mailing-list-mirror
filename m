From: Sean Kelley <sean.v.kelley@gmail.com>
Subject: Migrating from StarTeam to GIT
Date: Thu, 19 Feb 2009 11:19:28 -0600
Message-ID: <89b129c60902190919p2cdbe349o4a2a659617dae341@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 18:25:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaCa3-0003TT-Ge
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 18:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbZBSRTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 12:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbZBSRTa
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 12:19:30 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:59032 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506AbZBSRT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 12:19:29 -0500
Received: by rv-out-0506.google.com with SMTP id g37so501078rvb.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 09:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=oi/0geAYeOYoeTx3CyF/h2UmpNpxC5Sl6Q5tjbMtqVk=;
        b=KrXqx2GxFddNRmqC5QPVWhcEo8gSSQW+Bz3ywAAs7ncl8Zf7gDjtTpQjlMAZD6CHVy
         e8l+OQfcIVHlRV0zXyJPSgavce6YkYF6bClYhCfeQfLvU7IudMIa5LNDfttIJ9W4syxD
         LQfU0f+1Ym3ltNUbyTEeYmipaAmsAG1b1HpOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=sWzu5M3x7WytEnbkrwyXjwz25mLZN2KmtAa5gH7KJv2JbzQkLeSdEiuUU5wEyBBPv9
         AFP5fhEA9ox2GmneEcHUX/4dNWTJ9skrqJrdFZnTSC1OwEcsYze19uigZAVyzyXWF65i
         uwWvEL6Df6G8gX6U8zwjha6p0kn77BAh7ltKA=
Received: by 10.141.115.6 with SMTP id s6mr2338292rvm.186.1235063968414; Thu, 
	19 Feb 2009 09:19:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110719>

StarTeam has got to be the horrendous version control system I have
ever encountered in a company.  StarTeam has this notion of file
sharing between what they refer to as views. Basically a view in
StarTeam can be thought of as a repository for purposes of conversion
and it can share individual files from other views. It can then branch
the files as well.  Imagine, just imagine the mess of many many views
stringing files amongst each other.   It's like a version control
system designed by my four year old with a few balls of yarn strung
all over the house.  Hideous, I know.

I have avoided using StarTeam myself but others within the company are
looking for strategies of moving to GIT or possibly Mercurial.  My
crew uses Mercurial and started using GIT but we do embedded Linux for
the most part.

Are there ways to migrate views in StarTeam to a DVCS like GIT? Anyone
have experience with this?

Sean
