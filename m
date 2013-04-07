From: Thomas Koch <thomas@koch.ro>
Subject: Re: Advice and repo setup
Date: Sun, 7 Apr 2013 08:12:15 +0200
Message-ID: <201304070812.18797.thomas@koch.ro>
References: <CAKtB=OAot3y8fMjAf+Vh-=wOeX5b=F_N6_BLjK0fhGxGCg3Txg@mail.gmail.com>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Campbell <michael.campbell@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 08:30:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOj7u-0002hX-P1
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 08:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab3DGGat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 02:30:49 -0400
Received: from koch.ro ([88.198.2.104]:54864 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087Ab3DGGas (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 02:30:48 -0400
X-Greylist: delayed 1104 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Apr 2013 02:30:48 EDT
Received: from 44-25.106-92.cust.bluewin.ch ([92.106.25.44] helo=x121e.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <thomas@koch.ro>)
	id 1UOipw-000274-5e; Sun, 07 Apr 2013 08:12:20 +0200
User-Agent: KMail/1.13.7 (Linux/3.8-trunk-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <CAKtB=OAot3y8fMjAf+Vh-=wOeX5b=F_N6_BLjK0fhGxGCg3Txg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220280>

Michael Campbell:
> So one plan is to have multiple repos, and then a mirror of those for
> the remote devs.  The other plan is to say "sod it" and have one local
> and one remote and just suffer through possible non-requirements of
> varying authorization profiles.

You could also use Gerrit[1]. It's not only a code review server (and any team 
should have code review). It also hosts git repositories and you can write 
submit rules to reflect any possible write rule your company might have[2].

[1] http://en.wikipedia.org/wiki/Gerrit_%28software%29
[2] https://gerrit-review.googlesource.com/Documentation/prolog-cookbook.html

Regards,

Thomas Koch, http://www.koch.ro
