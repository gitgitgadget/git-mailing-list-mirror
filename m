From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Sun, 22 Feb 2009 14:12:42 -0800 (PST)
Message-ID: <m3bpsurui3.fsf@localhost.localdomain>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
	<7vtz6m1knv.fsf@gitster.siamese.dyndns.org>
	<94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
	<7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
	<94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
	<alpine.LFD.2.00.0902221225080.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 22 23:14:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbMaU-0001yT-1i
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 23:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbZBVWMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 17:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbZBVWMq
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 17:12:46 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:36672 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbZBVWMp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 17:12:45 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2582117fgg.17
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 14:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=zHencfYSABIfkVMcvUD4CkXhadZzd+G+7jwdvPOwiaU=;
        b=MrshShOSGtI7nx/rxShvue77LkPjuC7PEGS74gfGVHYndwfsy7bcStt5n20vaOimZ9
         icNH99Mt9TDSrWvlkgk9QuGtLTnBC9t0UU/+zTZxFNHShum9jA3Kkhxrf0gCnnJwOfLA
         CoaB9ZNie+8MVmaMudlC8DQa/SnD00XVT1AA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=rWWqxlDJ4+Qibm7e9k+YvBgwqbmk/VtYCk/YpyEW19X0ul/XD/dTpDuuCmmfZeSy4B
         iGrl7NNL37fbl3ZALGof6jwJ2Ev/tF6d2hdZ45d4zOPGzFYS2vPnJuCNlWG+rUjCYTdk
         PBcJXbEFKADFewArqCRQttezmYb6ZUP6DpG/o=
Received: by 10.86.95.20 with SMTP id s20mr2504988fgb.40.1235340763508;
        Sun, 22 Feb 2009 14:12:43 -0800 (PST)
Received: from localhost.localdomain (abvl123.neoplus.adsl.tpnet.pl [83.8.209.123])
        by mx.google.com with ESMTPS id e11sm1851121fga.20.2009.02.22.14.12.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 14:12:42 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1MMChhg031890;
	Sun, 22 Feb 2009 23:12:43 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1MMCa3H031887;
	Sun, 22 Feb 2009 23:12:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.2.00.0902221225080.3111@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111062>

Linus Torvalds <torvalds@linux-foundation.org> writes:

[...]

> and then for extra bonus points, make "shortlog" work as a format too.

Well, shortlog is a bit different as it reorders and summarizes log
information.  But if --stat is format of diff, then I guess shortlog
(future log --format=summary) is a format for log...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
