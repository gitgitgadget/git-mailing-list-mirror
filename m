From: FusionX86 <fusionx86@gmail.com>
Subject: git p4 rebase --branch
Date: Thu, 21 May 2015 18:52:52 -0600
Message-ID: <CAFcBi8-eH=td7478oPu5iPn9q1RGBFJ+NNLYHQid2xaF5T1sdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 22 02:53:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvbCt-0007bj-Bh
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 02:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbbEVAwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 20:52:54 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35894 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbEVAwx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 20:52:53 -0400
Received: by qget53 with SMTP id t53so1819648qge.3
        for <git@vger.kernel.org>; Thu, 21 May 2015 17:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Lc1NgNkPuPJk6XMyqePBDokL1PoA6nglbnisss51yrs=;
        b=WtJHjOY0A7hYyOnO7n44mcbVX4VINR7Ce0wA4NqRyDN/Z0PnuP1CLJ/E1HXNkMZA7y
         QhoYzTq60PLbepvY52HtEALvuoHdgygPxOEBWv55MV8Ejy3zkuPG2Oko6IWYQC6tsdWN
         e8YNj50VVyPxkGselFqnP0NqYIVqO0P0v0oCIZhuBuggqVpuIm7DyHGXoQ4g7/LDZQxU
         IoBLXZzd2tHWcubs40hNaLGAWZF5rRJny+NxHRfBgej4VQGZH51w/WoTK91j9HDnXlsM
         AdCfDD+AP0kWn3DOyJBImJYuGl9A+w7cHHyWgwa6nDF6fjUyGvOx8mY8f/5i3umQD+jI
         xwBg==
X-Received: by 10.229.30.8 with SMTP id s8mr5701368qcc.31.1432255973029; Thu,
 21 May 2015 17:52:53 -0700 (PDT)
Received: by 10.140.93.44 with HTTP; Thu, 21 May 2015 17:52:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269679>

For my Perforce to Git migration project, I am creating an empty local
git repo and then running git p4 sync with --branch to bring code from
Perforce into a specific Git branch. I'm going this route because I
need to take two Perforce branches that are similar and put them into
different branches of the same Git repo. One will go into dev and one
in master.

This seems to be working for me so far, but I want to use rebase to
pull new changes in and just realized that --branch isn't a supported
option for rebase. Any way to use git p4 rebase and target a local git
branch other than master?
