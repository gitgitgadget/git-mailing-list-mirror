From: "Robin Rosenberg" <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH] Add tests for handling of parsing errors in OpenSshConfig
Date: Thu, 25 Sep 2008 11:33:14 +0000
Message-ID: <tQAHDMR4.1222342394.9002900.roro@localhost>
References: <20080925083934.GB10273@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"sverre@rabbelier.nl" <sverre@rabbelier.nl>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Jonas Fonseca" <fonseca@diku.dk>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 13:34:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kip7J-00082g-MV
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 13:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbYIYLdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 07:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbYIYLdc
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 07:33:32 -0400
Received: from [83.140.172.130] ([83.140.172.130]:3165 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753062AbYIYLdb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2008 07:33:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E0FA5800252;
	Thu, 25 Sep 2008 13:33:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPHPaZE235rc; Thu, 25 Sep 2008 13:33:15 +0200 (CEST)
Received: from dewire.com (torino.dewire.com [10.1.2.98])
	by dewire.com (Postfix) with SMTP id E638F80008B;
	Thu, 25 Sep 2008 13:33:14 +0200 (CEST)
Received: from 194.68.56.35 (auth. user roro@localhost)
          by dewire.com with HTTP; Thu, 25 Sep 2008 11:33:14 +0000
X-Mailer: IlohaMail/0.8.14 (On: dewire.com)
In-Reply-To: <20080925083934.GB10273@diku.dk>
Bounce-To: "Robin Rosenberg" <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96749>

Den 9/25/2008, skrev "Jonas Fonseca" <fonseca@diku.dk>:

>Badly quoted entries are now ignored similar to how bad port number are
>currently ignored. A check for negative port numbers is now performed
>so that they also will be ignored.

Nooo. We should really give some feedback on bad entries. OpenSSH
(version 5.1) complains and refuses to connect if I give it a bad port
number or hostname. It complains about "missing parameter" and bad
port number for these cases. OpenSSH doesn't simply ignore them.

HostName=bad"
Port=hubba

Even if openssh would ignore them I'd think it would be bad if we did,
unless there was some serious compatibility issue here.

-- robin
