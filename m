From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to ignore all .xvpics directories
Date: Mon, 03 Nov 2008 03:49:55 -0800 (PST)
Message-ID: <m3d4hdf2qp.fsf@localhost.localdomain>
References: <490ECE54.5090505@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Duelli <duelli@melosgmbh.de>
X-From: git-owner@vger.kernel.org Mon Nov 03 12:51:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwxxp-0005pr-UF
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 12:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbYKCLuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 06:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbYKCLuB
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 06:50:01 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:16676 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbYKCLuA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 06:50:00 -0500
Received: by ey-out-2122.google.com with SMTP id 6so811060eyi.37
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 03:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=bH2Ktqm7zwDkC7h/yRAh7xFo+w5qvigdG5Jp9sCyXZM=;
        b=soyqfwaDCMYwTbgEhcKfqaXv+uPvOosjSUxYJl+uRb0fz1OKOiw1moH1fy0/CQZe9W
         Ud1zBD/yX6o6IW2nOYzB//QMLYSLGIE5YElcbaOFKVzJ3gSGm3vtix+H3PvCIQRaZLic
         80dWDsUp9LMconDMjy91iu9CwSwqW0iYJKfj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Tca7Mp9wLjCbH07XTTBd8s4/fnJou40oCnUvm1ZQ1DEGHnuCDxnEP5SaTQIEyCDfUI
         J75ZbKJ6blYMEui02SPoQQHSiSP7QywKK/T+OqbEfF8gy1WrTz150TLbKfiV7O4Pg07d
         Slmrh4ng8QDllEQQ+mesZkszID+loO7Bwsykg=
Received: by 10.210.74.17 with SMTP id w17mr15660734eba.148.1225712998439;
        Mon, 03 Nov 2008 03:49:58 -0800 (PST)
Received: from localhost.localdomain (abvp247.neoplus.adsl.tpnet.pl [83.8.213.247])
        by mx.google.com with ESMTPS id 3sm9615248eyi.5.2008.11.03.03.49.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 03:49:55 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mA3BnqBq017948;
	Mon, 3 Nov 2008 12:49:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mA3BnoXC017945;
	Mon, 3 Nov 2008 12:49:50 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <490ECE54.5090505@melosgmbh.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99933>

Christoph Duelli <duelli@melosgmbh.de> writes:

> Is it possible to ignore (once and for all) that directories like
> .pics or .xvpics (that might occur all over the place where xv was
> called) should be ignored?
> 
> [ Note: some time ago this issue has already popped up:
> http://thread.gmane.org/gmane.comp.version-control.git/50504
> 
> However, adding a line with just .xvpics in the toplevel .gitignore
> does not help. Neither does /**/.xvpics

Could you reproduce the steps you tried? Because I have checked, and
putting .xvpics or .xvpics/ in top level .gitignore (or in
.git/info/excludes, or ~/.gitignore) works as expected: filename
without '/' in it is match agains _basename_.

Note that .gitignore is about contents which is not tracked (not known
to git). If you added .xvpics to commit by accident, .gitignore will
do nothing then.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
