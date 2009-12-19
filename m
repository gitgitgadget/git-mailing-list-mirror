From: Joey Korkames <joey+lists@kidfixit.com>
Subject: Re: Feature suggestion: support arguments for GIT_PROXY_COMMAND &
         core.gitproxy
Date: Fri, 18 Dec 2009 17:58:29 -0700
Message-ID: <cone.1261184309.999283.4033.1000@toolshiner.phx1.kidfixit.com>
References: <cone.1261179562.490491.4033.1000@toolshiner.phx1.kidfixit.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 02:17:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLnwp-00051K-LD
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 02:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549AbZLSBR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 20:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754937AbZLSBR0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 20:17:26 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36860 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbZLSBR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 20:17:26 -0500
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.8.00.01.00 201-2244-105-20090324) with ESMTP
          id <20091219011725.GIDQ4995.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>
          for <git@vger.kernel.org>; Fri, 18 Dec 2009 20:17:25 -0500
Received: from mail.phx1.kidfixit.com ([68.110.127.170])
	by fed1rmimpo03.cox.net with bizsmtp
	id JpHR1d0033gixDg04pHRbC; Fri, 18 Dec 2009 20:17:25 -0500
X-VR-Score: 0.00
X-Authority-Analysis: v=1.1 cv=hxRkenI+XOLoHPjz51PhBd6+pm8nOe1puOOeXS7yE/Y=
 c=1 sm=1 a=0dQ4UOXiEK4A:10 a=wuBMPUXIKj/V06tqseGGQw==:17
 a=J6aRYqNtmxyQIVABWkAA:9 a=ArDO02R7s6GVfc-Z805GZS6v-NIA:4
 a=wuBMPUXIKj/V06tqseGGQw==:117
X-CM-Score: 0.00
Received: from toolshiner.phx1.kidfixit.com (unknown [10.1.0.2])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.phx1.kidfixit.com (Postfix) with ESMTP id 446E6808D8B6
	for <git@vger.kernel.org>; Sat, 19 Dec 2009 00:58:30 +0000 (UTC)
X-Mailer: http://www.courier-mta.org/cone/
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135453>

I forgot to mention that this all applies to ENV[GIT_SSH] as well, which 
has no correspondgin git-config option, currently.

I see there's some hardcoding of Tortoise and PuTTY's plink
argument-handling in connect.c . I think a tokenable core.sshproxy option in 
~/.gitconfig would be way less hinky, IMHO.

I just played with the man options in git config and I really liked how that 
worked; maybe that's a good part of the codebase to copy-paste from? I'm no 
C hacker, otherwise I'd be shutting up and sending a patch...

-joey
