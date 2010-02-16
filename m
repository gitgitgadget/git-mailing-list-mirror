From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Using test-lib.sh under GPLv3?
Date: Tue, 16 Feb 2010 02:27:37 -0800 (PST)
Message-ID: <m3aav98oj7.fsf@localhost.localdomain>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
	<87hbpwpoko.fsf@yoom.home.cworth.org>
	<5641883d1002060727ia4e6c16lf800a92fc8735430@mail.gmail.com>
	<201002081614.24284.sojkam1@fel.cvut.cz>
	<871vgr78lr.fsf@yoom.home.cworth.org>
	<87iqa2y0gz.fsf@steelpick.localdomain>
	<87r5oqe7mi.fsf@yoom.home.cworth.org>
	<871vgmki4f.fsf@steelpick.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Carl Worth <cworth@cworth.org>,
	notmuch@notmuchmail.org, git@vger.kernel.org
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Tue Feb 16 11:27:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhKeg-0005py-Hp
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 11:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767Ab0BPK1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 05:27:41 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:41627 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932603Ab0BPK1k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 05:27:40 -0500
Received: by bwz5 with SMTP id 5so1760891bwz.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 02:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=4nqny5w1n+t8Cobm2IkkVO9m67PtwfXxx8RMXMsqYJg=;
        b=OLY07QD1/k5KyY6/Cp+0N3ix1zYDVc1DnDTHbutvWoVaWGTu19nfNz9YFo2f72Jgqu
         LZRixzv8qQQ/3rvESYdn7eGxBmp8s669+u2Cve1fEZ0PuQMVaaiOLthTHCkGH3TUVyiD
         /Guruf79XRuST62nZCLOfFfNoBUi1xOV5lw0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=bcqaoApo1dv4Da5f0QHHA7BZIh3BA/1y6SmL45yKJjHdgy6ANuCpsgJKvDJzvaqqeT
         2p6A3HxnnrZjIWKyf/ktYZGXXB0/rw36S5i5an3szKnTife1hh4FAgo5iVWOvVjqtpJZ
         YhLCV3jDRSAYKbfQXmHwI8TcMARGYZQfP08G0=
Received: by 10.204.151.216 with SMTP id d24mr4120084bkw.1.1266316058661;
        Tue, 16 Feb 2010 02:27:38 -0800 (PST)
Received: from localhost.localdomain (abvc76.neoplus.adsl.tpnet.pl [83.8.200.76])
        by mx.google.com with ESMTPS id 16sm3022251bwz.15.2010.02.16.02.27.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 02:27:37 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o1GAQrNu006466;
	Tue, 16 Feb 2010 11:27:03 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o1GAQKA2006454;
	Tue, 16 Feb 2010 11:26:20 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <871vgmki4f.fsf@steelpick.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140091>

Michal Sojka <sojkam1@fel.cvut.cz> writes:

> I like the simple and powerful test suite used by Git and I would like
> to use something like that in Notmuch project (http://notmuchmail.org/).
> Notmuch is licenced under GPLv3 and we think that things will be simpler
> if everything in the repository is licenced the same. You are mentioned
> as a copyright holder in test-lib.sh and t0000-basic.sh so I'd like to
> ask you: Would you mind using parts of these files under GPLv3?

Have you thought about using TAP (Test Anything Protocol) format for
your testsuite?  Its page (http://testanything.org) has a TAP-producing
bash library: http://testanything.org/wiki/index.php/Tap-functions

-- 
Jakub Narebski
Poland
ShadeHawk on #git
