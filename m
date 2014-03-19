From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t5510: Do not use $(pwd) when fetching / pushing /
 pulling via rsync
Date: Wed, 19 Mar 2014 21:03:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1403192103300.14982@s15462909.onlinehome-server.info>
References: <5329F379.3010508@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	thomas.braun@byte-physics.de, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:04:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQMij-0002RS-DZ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 21:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbaCSUEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 16:04:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:59250 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121AbaCSUEH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 16:04:07 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0M3igT-1XGgO70dPN-00rFgr;
 Wed, 19 Mar 2014 21:03:58 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <5329F379.3010508@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:a9ax7pJU80d5QHOsIwxeOyrbvXzGR2KVmkrLQjXe94HuIdAu2O9
 YU3aaJjftd26U4li0WkJlu5HUJ9B+jVSUeQMbQEPzOq1+HbWklJMk28wrMXME7zl6afMpb3
 4lO5Zrq8WSyDNc7WMYsTV2V593bp4QCHpNo75IJi4vnqdsrFTkdKiIT1oc7e1f7/DmajUOA
 0yw7A0c+vEnFdsCHTLJ0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244488>

Hi Sebastian,

On Wed, 19 Mar 2014, Sebastian Schuberth wrote:

> On MINGW, "pwd" is defined as "pwd -W" in test-lib.sh. This usually is the
> right thing, but the absolute Windows path with a colon confuses rsync. We
> could use $PWD in this case to work around the issue, but in fact there is
> no need to use an absolute path in the first place, so get rid of it.
> 
> This was discovered in the context of the mingwGitDevEnv project and only
> did not surface before with msysgit because the latter does not ship
> rsync.

ACK

Ciao,
Dscho
