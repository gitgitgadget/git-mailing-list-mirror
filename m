From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-ls-files --added?
Date: Sun, 24 May 2009 01:37:11 -0700 (PDT)
Message-ID: <m3fxeudhho.fsf@localhost.localdomain>
References: <2cfc40320905240054j2c08da8bt4df95c6f1bc9e254@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 10:37:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M89D4-0000hk-IB
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 10:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbZEXIhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 04:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbZEXIhN
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 04:37:13 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:64066 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbZEXIhL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 04:37:11 -0400
Received: by fxm12 with SMTP id 12so687654fxm.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 01:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=h2GRVa5ER8MmK7BLRtA8a0IHcx8G1V2MC8OMJWBs6Yk=;
        b=Ly1zkU46d5TgsP4ltIWg28mKoEi/ahqi1qTHaQR/QSjfvyPS4UTM6hIYAjLNi/c/+o
         krv61Ag/SoJRMrxBpQv3Z5Q1MXcXi9LaI3uYdn6Y/+gRYYhStOFHqIMDxIzZr+zS1ipR
         gYikpmcsnHVMINypIzb0daI9KQjr/62CaGXXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=cakp6HHUZY5rmn93zuDAPBYwgmPvH3KP5LmZB0N51fawATzWpdl1iGakDWkPYHRqh+
         EtA+fWsefnz/ghzGhz+BrqHrenzhH2baUKnw2LhpouX5aTtcJW2yaOBDW6sHVXczbmTh
         8rMWsTwuVu85wZ3XpZ6ywJ6EbP9bQcvZlFvu0=
Received: by 10.86.98.10 with SMTP id v10mr4591378fgb.36.1243154232070;
        Sun, 24 May 2009 01:37:12 -0700 (PDT)
Received: from localhost.localdomain (abva98.neoplus.adsl.tpnet.pl [83.8.198.98])
        by mx.google.com with ESMTPS id l19sm3648877fgb.7.2009.05.24.01.37.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 01:37:11 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4O8b9LN031874;
	Sun, 24 May 2009 10:37:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4O8b7lj031871;
	Sun, 24 May 2009 10:37:07 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2cfc40320905240054j2c08da8bt4df95c6f1bc9e254@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119815>

Jon Seymour <jon.seymour@gmail.com> writes:

> Is there a reason why git-ls-files does not have an --added option?
> 
> I'd like to get a list of new files, due to be committed. Currently, I
> have to parse the output of git status to get that, but it seems like
> a reasonable function for git-ls-files.

You can use git-diff-* with --name-only and --diff-filter=A for
that; you shouldn't parse result of porcelain git-status.

And there is also contrib/examples/git-commit.sh as a guideline...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
