From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Android needs repo, Chrome needs gclient. Neither work. What does  that say about git?
Date: Fri, 20 Nov 2009 04:46:39 -0800 (PST)
Message-ID: <m3y6m1bbxg.fsf@localhost.localdomain>
References: <2d707e8c-2561-470c-beba-c81e16ac441c@k17g2000yqh.googlegroups.com>
	<65e170e70911200251q2ec5ec87rc37577dddfd3317d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adrian May <adrian.alexander.may@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 13:46:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBSsy-0004Ot-PL
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 13:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbZKTMqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 07:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbZKTMqh
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 07:46:37 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:36300 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbZKTMqg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 07:46:36 -0500
Received: by bwz27 with SMTP id 27so3280861bwz.21
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 04:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=o0BToyJstaCuc5qxTXVPbnMBGEWNgC+KdjHpxYT/8l0=;
        b=DZBS52VR3UiBCnokrvpeJalKnftm7cRt603ywXpxUQNs5E1MDNMt6LCIfQ5F2gnBb0
         Iy4oLNEMoxzXOWT6lOAvvVJw1ULBnDZuovKlMEvKWPFxtOy7uO7kD+ZQUF/3YyaxJVHv
         94P5glZO7S7nGiX/eNgiUOC1IituarpIvuN2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=T7c5LkslsMHZ2WzOtWiu2k9HW5L92fptVOGqEFEbQ/fBPQuHcCQ9/86EwBOSbDotQl
         TNl4IbDpLExFhEnfhGOuF31AeJpN8lukNNN3pRMO/FRULmmZTTL4qetoEQU2n1qmYoyj
         i9M+lIH4hUnSjv3koMje5sUawkBbzlDpR6ImY=
Received: by 10.204.25.152 with SMTP id z24mr1374993bkb.44.1258721201436;
        Fri, 20 Nov 2009 04:46:41 -0800 (PST)
Received: from localhost.localdomain (abvw68.neoplus.adsl.tpnet.pl [83.8.220.68])
        by mx.google.com with ESMTPS id 15sm411248bwz.8.2009.11.20.04.46.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 04:46:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAKClOgW021603;
	Fri, 20 Nov 2009 13:47:25 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAKClNtd021599;
	Fri, 20 Nov 2009 13:47:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <65e170e70911200251q2ec5ec87rc37577dddfd3317d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133342>

Adrian May <adrian.alexander.may@gmail.com> writes:

> Git is just plain wrong, because you can't split or merge repositories
> or pull subtrees of them. It doesn't have the kind of triggers you
> need to assert change control either, and these bolt-on scripts are
> just making life messy. Will somebody please finish git itself instead
> of working around it, or use a source control system that's up to the
> job.

Your complaing have the same sense as complaining that gcc does not
include functionality of Makefile, because you just can't manage
larger projects without it (or equivalent).

Do one thing, and do it well.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
