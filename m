From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2009, #06; Sun, 30)
Date: Tue, 01 Sep 2009 09:47:11 -0700 (PDT)
Message-ID: <m37hwili5q.fsf@localhost.localdomain>
References: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 18:47:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiWWF-0006QS-Fr
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 18:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbZIAQrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 12:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbZIAQrL
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 12:47:11 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:36899 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbZIAQrK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 12:47:10 -0400
Received: by bwz19 with SMTP id 19so120650bwz.37
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=9nlJQ+XEKR1toeio38HoQZ5oU6FUoR5obAMNM/2+HHk=;
        b=OnkBt5k8+pzE4vNGsCifedxcsMwyftsKHyLNQEjnjPSQ+V7pmX5ATEzKJyKL2y54uo
         prwxwTeJ33ikW871vhJKiI+vmVXP1NRp2zwBpdWV/JPiDvyTpvmmRS+90vWZjB4lGEtW
         kcqypR2VUwsrPz7VKLRDfTyOb5ttAi/T7CUEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=w46knfMSybgJCvTFO+NPCSP+ZRsbeO9nljtYOGBoAzBC4/wKrjdtNbOye+cUxfdUAk
         8CdCuU1hESalAHXvVloFFQw1iZRPpOmsz4vMl3ZtfsI8LJI9VbWoGX2iS+D4C/IcbM6+
         VHvxCXZFQZmEPANOA1qWnzLHREAglvNmMXwZM=
Received: by 10.102.12.1 with SMTP id 1mr3063105mul.63.1251823631845;
        Tue, 01 Sep 2009 09:47:11 -0700 (PDT)
Received: from localhost.localdomain (abwo59.neoplus.adsl.tpnet.pl [83.8.238.59])
        by mx.google.com with ESMTPS id 23sm179658mun.13.2009.09.01.09.47.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Sep 2009 09:47:11 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n81GsgAS009620;
	Tue, 1 Sep 2009 18:54:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n81Gsfne009617;
	Tue, 1 Sep 2009 18:54:41 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127543>

Junio C Hamano <gitster@pobox.com> writes:

> * jn/gitweb-blame (2009-08-06) 3 commits
>  - gitweb: Create links leading to 'blame_incremental' using JavaScript
>  - gitweb: Incremental blame (WIP)
>  - gitweb: Add optional "time to generate page" info in footer
> 
> Ajax-y blame WIP

There is replacement series sent to git mailing list a little while
ago.  

The replacements for "time to generate page" and 'blame_incremental'
are IMVHO out of WIP (but more testing, in different web browsers
would be good).

The part that actualy creates links that lead to 'blame_incremental'
view is still work in progress, and needs ideas how to correctly
implement it.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
