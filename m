From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Does CVS has a easy way to compare file with its previous version?
Date: Tue, 30 Jun 2009 05:36:04 -0700 (PDT)
Message-ID: <m3hbxxx5jk.fsf@localhost.localdomain>
References: <1e56aa11-735a-47f7-a273-5b6bf611f528@n11g2000yqb.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: dtletmn <dtletmedn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 14:47:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward1.uio.no ([129.240.10.70])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLchg-0008GM-MN
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 14:44:52 +0200
Received: from exim by mail-out1.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLcZP-0004lZ-3w
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 14:36:19 +0200
Received: from mail-mx6.uio.no ([129.240.10.47])
	by mail-out1.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLcZP-0004lW-2p
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 14:36:19 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx6.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLcZO-0001d0-57
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 14:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbZF3MgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 08:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbZF3MgE
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 08:36:04 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:36481 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbZF3MgD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 08:36:03 -0400
Received: by bwz9 with SMTP id 9so94715bwz.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 05:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=LM4uaGtP3I9Ys+XrclNpzZdhBiXfi2sUjaD+bYWavec=;
        b=S5l6CopTa1STO5pexb7O7g+7HKrDoDuPx34cWM6bc2y/tNDoDdPSg6TcNGUXQK3DxD
         V1N3iOV/VhuSDTgbTW2B5Kb8OqE69tXwDJCfez9h3j9t9ADSSnVyGjZ3LQI8ShS9ObbU
         tPQT1oJSMbO5VgtE/Aoxxy4y/3WmYsFQqpzGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=SyDjlor4uKSImyaW37oEwLEcG6MPn/T/d6MtiD0btnoHqGcqwmkT6hf0QKqmvQv7q0
         t5pk0RErL1ICvji1lnsaBnMZ8YeU16bY4wZ+JY5G1rXyLFZqpFSYjdVuYlsx0PEGW0PB
         XMXCje+K+x1CqsvqruGq2g75aWYas8Hbqp2KA=
Received: by 10.103.168.5 with SMTP id v5mr4769245muo.77.1246365365253;
        Tue, 30 Jun 2009 05:36:05 -0700 (PDT)
Received: from localhost.localdomain (abvk72.neoplus.adsl.tpnet.pl [83.8.208.72])
        by mx.google.com with ESMTPS id u26sm36697024mug.52.2009.06.30.05.36.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 05:36:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5UCa1Uo025973;
	Tue, 30 Jun 2009 14:36:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5UCa0EL025970;
	Tue, 30 Jun 2009 14:36:00 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1e56aa11-735a-47f7-a273-5b6bf611f528@n11g2000yqb.googlegroups.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3,URIBL_BLACK=1.961, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: 40E79FACB259BE46BC94DB5C6EE42FF3292A7695
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 100 total 2547507 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122511>

dtletmn <dtletmedn@gmail.com> writes:

> Hi,All,
> 
>      I am wondering if cvs has an easy way to compare a file with its
> previous version.
> 
>      In clearcase,I can use  :
>        cleartool diff -pred file.cc
> 
>      how can I acheive it in CVS?
>      any help would be highly appreciated!

In CVS or in Git?

In CVS: "cvs diff -r <previous revision> <file>".
In Git: "git diff HEAD^ -- <file>".

Both assume that you want to compare with version from previous
commit.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
