From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
Date: Sat, 27 May 2006 12:24:39 +0200
Message-ID: <20060527102439.GB26430@cip.informatik.uni-erlangen.de>
References: <4477B905.9090806@garzik.org> <Pine.LNX.4.61.0605271212210.6670@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>
X-From: git-owner@vger.kernel.org Sat May 27 12:24:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjvyR-0006N5-GN
	for gcvg-git@gmane.org; Sat, 27 May 2006 12:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWE0KYm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 06:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWE0KYm
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 06:24:42 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:31209 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1751034AbWE0KYl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 May 2006 06:24:41 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 9FB3A3061E; Sat, 27 May 2006 12:24:39 +0200 (CEST)
To: Linux Kernel <linux-kernel@vger.kernel.org>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	GIT <git@vger.kernel.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605271212210.6670@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20843>

Hello,

> #!/usr/bin/perl -i -p
> s/[ \t\r\n]+$//

perl -p -i -e 's/\s+$//' file1 file2 file3 ...

        Thomas
