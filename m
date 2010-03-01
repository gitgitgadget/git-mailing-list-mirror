From: Phil Miller <mille121@illinois.edu>
Subject: 'Deepen' after "git clone --depth=1"?
Date: Sun, 28 Feb 2010 21:55:56 -0600
Message-ID: <81f018ac1002281955g1461abb3q815f9a45c13fb515@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 01 04:56:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nlwk3-0006TR-AB
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 04:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab0CAD4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 22:56:18 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61515 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab0CAD4R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 22:56:17 -0500
Received: by wya21 with SMTP id 21so1104378wya.19
        for <git@vger.kernel.org>; Sun, 28 Feb 2010 19:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=B01z57ahj5eSFniDHaIozPkt/AVm3QtiWIbGAjBQn20=;
        b=PuN2FgdzV4U6MtAzFmvdmTqSOtZYuTB8LJ+ly+rPR+w79wCWf6JDAWNbPZmSHISvWU
         I6RsiPyLUguBqj6qvelIrs+jOuA/KsfzMCPFvKrJ66zG0AsHiThVyJ89NS8TBVOpWN5V
         IMxSTkcJoISoJSsRt1ifWXVARLO2WF0PqdeyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=DlD145SSN+jqqUIIwxVWy0tT5juV9kzWtGnkjsD9i8qTgCpcZ2Spp7slCprV3bCmYA
         4gui+iohuGGd0VHdvS9bj0QnYsqZlIK3dfErjIO1BSWm0qomGu4JPkDOnbj1PHFmGJ0V
         LDsodYs7M1rzrzI43LpCaX1u3wXgoUcj1gXeo=
Received: by 10.216.172.203 with SMTP id t53mr2716175wel.56.1267415776103; 
	Sun, 28 Feb 2010 19:56:16 -0800 (PST)
X-Google-Sender-Auth: 3b0a1e26e5cdadce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141297>

Suppose I want to make a shallow clone of a repository for some
size-sensitive application. I may later want to fill out the complete
history of that repository, so that I can work with it as if I had
done a full-depth clone to begin with. Is there an existing porcelain
command/option to produce that effect? If not, is there a fundamental
reason why this couldn't be implemented? It looks like this is
something fetch-pack should be able to do, but its documentation
doesn't seem to describe how. Also, the man page for fetch appears to
lie, in that --depth=n (where n is greater than the clone depth)
doesn't have any noticeable effect.

If the answer is simply "no one's written the code to do it yet", I'll
be happy to provide the necessary round tuits.

Phil
