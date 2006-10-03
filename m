From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] http/ftp: optionally ask curl to not use EPSV command
Date: Tue, 03 Oct 2006 11:11:08 +0200
Organization: At home
Message-ID: <eft9eg$un0$4@sea.gmane.org>
References: <20060928192605.GD10617@sashak.voltaire.com> <7vejtvu1ja.fsf@assigned-by-dhcp.cox.net> <20060929000754.GK10617@sashak.voltaire.com> <20060929001044.GL10617@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 03 11:20:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUgRe-0000LV-Md
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 11:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWJCJUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 05:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWJCJUF
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 05:20:05 -0400
Received: from main.gmane.org ([80.91.229.2]:54476 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030272AbWJCJUE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 05:20:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GUgRV-0000J8-VJ
	for git@vger.kernel.org; Tue, 03 Oct 2006 11:20:02 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 11:20:01 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 11:20:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28260>

Sasha Khapyorsky wrote:

> If http.noEPSV config variable is defined and true, or if
> GIT_CURL_FTP_NO_EPSV environment variable is defined, disable using
> of EPSV ftp command (PASV will be used instead). This is helpful with
> some "poor" ftp servers which does not support EPSV mode.

Why the name is http.noEPSV, not ftp.noEPSV (or curl.noEPSV)?
Just curious.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
