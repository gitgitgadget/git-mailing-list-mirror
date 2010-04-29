From: santos2010 <santos.claudia2009@googlemail.com>
Subject: git daemon on Windows environment
Date: Thu, 29 Apr 2010 02:07:06 -0700 (PDT)
Message-ID: <1272532026043-4979038.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 22:09:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7wWL-0008Bu-9h
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 22:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470Ab0D3UI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 16:08:56 -0400
Received: from kuber.nabble.com ([216.139.236.158]:40380 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932505Ab0D3UIz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 16:08:55 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <santos.claudia2009@googlemail.com>)
	id 1O7Pi6-00006x-1d
	for git@vger.kernel.org; Thu, 29 Apr 2010 02:07:06 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146060>


Hello,

I tried to install git daemon on a Windows Server 2003 using cygrunsrv, but
got this error:
cygrunsrv: Error starting a service: QueryServiceStatus:  Win32 error 1062:

I googled and found a possible fix:

 " explicitly add Full Control for the SYSTEM user to

  C:\Cygwin
  C:\Cygwin\var
  C:\Cygwin\var\log "

However this didn't help as well.
Anyone has experience with this installation? Any tips?

Thanks ina advance,

Santos
-- 
View this message in context: http://git.661346.n2.nabble.com/git-daemon-on-Windows-environment-tp4979038p4979038.html
Sent from the git mailing list archive at Nabble.com.
