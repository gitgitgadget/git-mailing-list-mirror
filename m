From: Timur Tabi <timur@freescale.com>
Subject: Re: git-clone does not work if run in /temp
Date: Thu, 28 Sep 2006 13:48:39 -0500
Organization: Freescale
Message-ID: <451C1907.4090104@freescale.com>
References: <451C1635.9090608@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 28 20:48:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT0wA-0003mw-0i
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 20:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWI1Ssm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 14:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWI1Ssm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 14:48:42 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:1176 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1030364AbWI1Ssl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 14:48:41 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id k8SJ1b53019683
	for <git@vger.kernel.org>; Thu, 28 Sep 2006 12:01:37 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8SImduU005908
	for <git@vger.kernel.org>; Thu, 28 Sep 2006 13:48:40 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <451C1635.9090608@freescale.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28032>

Timur Tabi wrote:
> If the current directory is '/temp', then git-clone fails:

Update: I just noticed I have a directory called "http:" (yes, with the colon) in my /temp directory, and that was causing the problem.

I still think this is a bug in git, though.  If I have time, I'll try to fix it myself.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
