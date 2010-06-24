From: Christian MICHON <christian.michon@gmail.com>
Subject: on pulling/cloning git notes
Date: Thu, 24 Jun 2010 10:22:21 +0200
Message-ID: <AANLkTilDMVU6b7SwHx0Bztu1rTCubiIPTuDDX6pJBcHx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 24 10:22:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORhhe-0001Go-D2
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 10:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494Ab0FXIWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 04:22:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:28323 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab0FXIWW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 04:22:22 -0400
Received: by fg-out-1718.google.com with SMTP id l26so624573fgb.1
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 01:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=jJmq/xnsR2xkXeMgk1ixM6Gmlj5RTWUbJpguLNLU4Rk=;
        b=jxejyg1FeDNijWIa/dXuqT+ZaXV6vuZPCWgKtNwmcHJIrcVoGIxu29jOXbex0z3jyP
         5vIrxG5aT7lfFLWslD+F3SBij20RvVuD/IxyBoy2uAwMyNFPk5KS7gMb9BUuPfE7PeYz
         2GD1G2c51auUnAYwVwijByf9CdFJYnSFhqs6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=lwMOwsiRrfJX1x7Aiap2d/1yhpkJRCuVb99LoLjambGXfzAPU1sf66Kt/Ost9uQLtb
         c/wrdHhzDdC6yvCwPPCxc8+PAHvMrkEkZD+yWsxGg3FxqtEyHEnwUMii16aUOke1ulz+
         WymvR7xAhBhfO+IH6bq7HTLUdMHtEPWQKw540=
Received: by 10.103.50.13 with SMTP id c13mr2984925muk.63.1277367741024; Thu, 
	24 Jun 2010 01:22:21 -0700 (PDT)
Received: by 10.103.138.8 with HTTP; Thu, 24 Jun 2010 01:22:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149566>

Hi list,

I've been playing recently with git notes and figured out how to push
my notes to my central gitolite server, tweaking .git/config in this
way (adding a push section):

[remote "gitolite"]
        url = gitolite:daat
        fetch = +refs/heads/*:refs/remotes/gitolite/*
        push = +refs/notes/*:refs/notes/*

When trying to to a 'git clone --mirror' from that same gitolite
server, I was expecting to get back refs/notes, but I did not.

Did I miss something or git notes are actually not meant to be cloned/pulled?

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
