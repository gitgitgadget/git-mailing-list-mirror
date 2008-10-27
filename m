From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: Some hooks turned on by default in FreeBSD 4
Date: Mon, 27 Oct 2008 20:23:48 +0100
Message-ID: <A770E0EA-EE98-47CA-9710-48DA6314AFED@ai.rug.nl>
References: <435624390810271214s16b964cbo131772ea4a760ef7@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Robert Boone <robo4288@gmail.com>,
	Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 27 20:25:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuXiB-00070y-8y
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 20:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbYJ0TX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 15:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbYJ0TX5
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 15:23:57 -0400
Received: from frim.nl ([87.230.85.232]:52175 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751099AbYJ0TX4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Oct 2008 15:23:56 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1KuXgw-0002xp-PZ; Mon, 27 Oct 2008 20:23:54 +0100
In-Reply-To: <435624390810271214s16b964cbo131772ea4a760ef7@mail.gmail.com>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99253>


On 27 okt 2008, at 20:14, Robert Boone wrote:

> [root@user /usr/local/cpanel.git]# ls -l .git/hooks/
> total 52
> -rw-r--r--  1 root  wheel   441 Oct 27 10:14 applypatch-msg
> -rwxr-xr-x  1 root  wheel   452 Oct 27 10:14 applypatch-msg.sample

You probably installed the new git over an older one? The old files in  
the templates weren't deleted, so now you have both the old version  
without .sample and the new ones in your template folder.
