From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] git-fetch: Avoid reading packed refs over and over again
Date: Sat, 30 Dec 2006 20:04:23 +0100
Message-ID: <4596B837.8030108@xs4all.nl>
References: <Pine.LNX.4.63.0612172048331.3635@wbgn013.biozentrum.uni-wuerzburg.de> <7vslfe3r4d.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612181329480.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 30 20:04:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0jVM-0006Iy-E0
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 20:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWL3TEZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 14:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWL3TEZ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 14:04:25 -0500
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:2102 "EHLO
	smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030299AbWL3TEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 14:04:25 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
	(authenticated bits=0)
	by smtp-vbr2.xs4all.nl (8.13.8/8.13.8) with ESMTP id kBUJ4Mkg035761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 30 Dec 2006 20:04:22 +0100 (CET)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
Newsgroups: gmane.comp.version-control.git
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612181329480.3635@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35626>

Johannes Schindelin escreveu:
> 
> Here you have to check first, if len > 3. Strictly speaking, there should 
> not be any line coming in which is shorter than 42 bytes. But I was 
> recentely bitten by such an assuption...
> 
> Overall, I like it. I even have the impression that this could actually 
> open a way to build in fetch instead of relying on a POSIX conformant and 
> fast shell for such a central part of git.

is there any chance of this going in GIT 1.5.0 ? It's not in the rc0 release.


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
