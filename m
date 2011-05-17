From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] add Android support
Date: Tue, 17 May 2011 08:44:11 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1105170842490.30333@tvnag.unkk.fr>
References: <D2F37FDB-20C2-401A-AA90-DB4A50C27123@gieschke.de> <7vzkmmjqpx.fsf@alter.siamese.dyndns.org> <D01E807D-C82C-4A8F-9678-9CEA92C413DA@gieschke.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Rafael Gieschke <rafael@gieschke.de>
X-From: git-owner@vger.kernel.org Tue May 17 08:52:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QME8Q-0003yv-Ov
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 08:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368Ab1EQGvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 02:51:12 -0400
Received: from giant.haxx.se ([80.67.6.50]:53557 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926Ab1EQGvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 02:51:09 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 May 2011 02:51:09 EDT
Received: from giant.haxx.se (giant.haxx.se [80.67.6.50])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id p4H6iBT0004308;
	Tue, 17 May 2011 08:44:11 +0200
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <D01E807D-C82C-4A8F-9678-9CEA92C413DA@gieschke.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
X-Greylist: Default is to whitelist mail, not delayed by milter-greylist-4.3.8 (giant.haxx.se [80.67.6.50]); Tue, 17 May 2011 08:44:11 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173791>

On Tue, 17 May 2011, Rafael Gieschke wrote:

> Compiling libcurl for Android should be possible with some work, though. So 
> compat/getpass.c would be used for libcurl/HTTP access, too.

(lib)curl already has a dedicated makefile in the release tarball crafted for 
building it for Android. It should not be a major obstacle.

-- 

  / daniel.haxx.se
