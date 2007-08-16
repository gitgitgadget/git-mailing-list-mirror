From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [MinGW PATCH] Fixed error 'fatal: Not a git repository' on Vista
Date: Thu, 16 Aug 2007 10:37:07 +0200
Organization: eudaptics software gmbh
Message-ID: <46C40CB3.5415D888@eudaptics.com>
References: <DE6EEF3D318C4051827B95DF26D97BE7@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 10:37:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILarT-0000X5-AN
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 10:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934669AbXHPIhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 04:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934701AbXHPIhC
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 04:37:02 -0400
Received: from main.gmane.org ([80.91.229.2]:36720 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934630AbXHPIg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 04:36:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ILaqP-0000qS-Rs
	for git@vger.kernel.org; Thu, 16 Aug 2007 10:36:42 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 10:36:41 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 10:36:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55993>

Dmitry Kakurin wrote:
> - COMPAT_CFLAGS
> += -DNO_ETC_PASSWD -DNO_ST_BLOCKS -DSTRIP_EXTENSION=\".exe\" -I compat
> + COMPAT_CFLAGS
> += -DNO_ETC_PASSWD -DNO_ST_BLOCKS -DSTRIP_EXTENSION=\".exe\" -D__USE_MINGW_ACCESS

I don't see how this could make a difference: __USE_MINGW_ACCESS appears
in none of the mingw header files nor in the mingw.git sources.

Is my build environment outdated?

-- Hannes
