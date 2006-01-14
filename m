From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: My first git success [not quite]
Date: 14 Jan 2006 09:48:24 -0800
Message-ID: <86acdyu2dz.fsf@blue.stonehenge.com>
References: <dq8epd$k28$1@sea.gmane.org>
	<Pine.LNX.4.64.0601130909290.3535@g5.osdl.org>
	<dqb5vg$a09$1@sea.gmane.org>
	<BAYC1-PASMTP10B423DC1B2FC1F8C9992BAE190@CEZ.ICE>
	<dqbbo9$s49$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 18:48:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExpVx-0001w2-RE
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 18:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWANRsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 12:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWANRsa
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 12:48:30 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:49446 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750725AbWANRs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 12:48:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 016028EBC4;
	Sat, 14 Jan 2006 09:48:25 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 23230-01-5; Sat, 14 Jan 2006 09:48:24 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 792ED8EBD4; Sat, 14 Jan 2006 09:48:24 -0800 (PST)
To: walt <wa1ter@myrealbox.com>
x-mayan-date: Long count = 12.19.12.17.7; tzolkin = 6 Manik; haab = 5 Muan
In-Reply-To: <dqbbo9$s49$1@sea.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14670>

>>>>> "walt" == walt  <wa1ter@myrealbox.com> writes:

walt> I suppose the underlying problem is that I don't think like
walt> a developer.

Well, I'm a developer and *I* also had that problem while working
on my "ajax" branch.

Maybe git-checkout should by default *warn* when it is leaving
things in the tree that are indexed but not updated in the index
(committed?).  And you'd have to add a --no-warn thingy to turn
that off.  Then beginners wouldn't be quite as confused.  I'm not
talking about things that are .gitignore'd... just things like
walt's example.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
