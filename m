From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] git-fetch: Avoid reading packed refs over and over again
Date: Sat, 30 Dec 2006 21:02:30 +0100
Message-ID: <4596C5D6.701@xs4all.nl>
References: <Pine.LNX.4.63.0612172048331.3635@wbgn013.biozentrum.uni-wuerzburg.de> <7vslfe3r4d.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612181329480.3635@wbgn013.biozentrum.uni-wuerzburg.de> <4596B837.8030108@xs4all.nl> <Pine.LNX.4.63.0612302020060.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 30 21:02:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0kPd-0003b1-7u
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 21:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWL3UCe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 15:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbWL3UCe
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 15:02:34 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:3774 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030329AbWL3UCd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 15:02:33 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
	(authenticated bits=0)
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id kBUK2Vr3050459
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 30 Dec 2006 21:02:31 +0100 (CET)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
Newsgroups: gmane.comp.version-control.git
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612302020060.19693@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35631>

Johannes Schindelin escreveu:

> $ git grep -e exclude-existing v1.5.0-rc0
> v1.5.0-rc0:builtin-show-ref.c:          if (!strcmp(arg, "--exclude-existing"))
> v1.5.0-rc0:builtin-show-ref.c:          if (!strncmp(arg, "--exclude-existing=", 19))
> v1.5.0-rc0:git-fetch.sh:                git-show-ref --exclude-existing=refs/tags/ |
> 
> The last line means that it _is_ in v1.5.0-rc0. (BTW it is the commit 
> tags/v1.5.0-rc0~84, which I found by "git log v1.5.0-rc0 git-fetch.sh | 
> git name-rev --tags --stdin | less".)

oh, oops. I was looking for the commit  message of the patch you originally 
sent me. Cool.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
