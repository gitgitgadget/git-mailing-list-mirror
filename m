From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Two RPM building improvements
Date: Fri, 27 Mar 2009 06:50:36 -0700 (PDT)
Message-ID: <m3k56b2hy2.fsf@localhost.localdomain>
References: <1238157134-27558-1-git-send-email-Niels@Basjes.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Niels Basjes <Niels@Basjes.nl>
X-From: git-owner@vger.kernel.org Fri Mar 27 14:53:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnCUe-0007Yg-JT
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 14:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757523AbZC0Nun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 09:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757427AbZC0Num
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 09:50:42 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:24143 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362AbZC0Nul (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 09:50:41 -0400
Received: by wa-out-1112.google.com with SMTP id j5so687951wah.21
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=jEZw0we48McPiU3Vdt4eLE/Brmjbp+DOlwmKUt9s2uw=;
        b=pBJMuVgJ2hZAviOBl4yTqvdDh00tDyqBU43aDLntpCZ9wUFw3+COzbPQFCoQTpytkr
         vxbmBYTlMdN+MCpNIVxyTK5RW1rHXkRi24nul80LXUk8uumhkv8v3HDcywibpDSqg/nN
         hjOSjH5RzJgQ6/PxG33H9SX5NgSAa+AwHea4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=l7oNUu8NgBQOrPuL9cbRAQeT2oz1uhAKHxNKzSQioTLX3DQmeVybBP7EHM0vfbpCn4
         F23q8r8BChX/MBRqlCzjwcJpJ4QpEDCWKNPgoLUsGPth4Pb/yrLEajOFq2wnXBOshjjj
         ZhJWuUQbdVPz8zd6O9CfgOdxlJ7vfRoP012GQ=
Received: by 10.114.183.1 with SMTP id g1mr1442692waf.140.1238161837830;
        Fri, 27 Mar 2009 06:50:37 -0700 (PDT)
Received: from localhost.localdomain (abvq19.neoplus.adsl.tpnet.pl [83.8.214.19])
        by mx.google.com with ESMTPS id q20sm6763841pog.8.2009.03.27.06.50.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 06:50:36 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n2RDoVps007961;
	Fri, 27 Mar 2009 14:50:31 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n2RDoTNS007958;
	Fri, 27 Mar 2009 14:50:29 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1238157134-27558-1-git-send-email-Niels@Basjes.nl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114894>

Niels Basjes <Niels@Basjes.nl> writes:

> Two RPM building improvements:

Two _unrelated_ RPM building improvements squashed in one commit.

>   - Building the RPMs can now be done by a non-root user.

It was always possible, you only have to configure rpm / rpmbuild,
namely put path to where you want your RPM_BUILDING directory in
~/.rpmmacros as %_topdir, for example:

  $ cat ~/.rpmmacros
  %_topdir        /home/local/builddir

Please RTFM first, before going to solve non-problem in (ugh) fairly
complicated way.

>   - The additional target all-rpms now builds the RPMs for a multitude of target platforms.

Please wrap commit messages at 72-76 columns, at most at 80 columns.
No such overly long lines, please.

But the all-rpms target looks like a good idea

-- 
Jakub Narebski
Poland
ShadeHawk on #git
