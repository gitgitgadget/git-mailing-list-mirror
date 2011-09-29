From: "Theo Niessink" <niessink@martinic.com>
Subject: What's cooking in git.git (Sep 2011, #08; Wed, 28)
Date: Thu, 29 Sep 2011 13:56:58 +0200
Organization: Martinic
Message-ID: <3264C8D485BD4E73B05667AC8B0FC619@martinic.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 14:09:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9FQQ-0002DM-1k
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 14:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab1I2MJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 08:09:08 -0400
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:1220 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751000Ab1I2MJH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 08:09:07 -0400
X-Greylist: delayed 725 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Sep 2011 08:09:07 EDT
Received: from cpsps-ews14.kpnxchange.com ([10.94.84.181]) by cpsmtpb-ews04.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 29 Sep 2011 13:55:30 +0200
Received: from CPSMTPM-CMT102.kpnxchange.com ([195.121.3.18]) by cpsps-ews14.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Thu, 29 Sep 2011 13:55:30 +0200
Received: from ntserver.martinic.local ([77.168.115.212]) by CPSMTPM-CMT102.kpnxchange.com with Microsoft SMTPSVC(7.0.6002.18264);
	 Thu, 29 Sep 2011 13:56:59 +0200
Received: from pc0003 ([192.168.87.16])
	by ntserver.martinic.local
	; Thu, 29 Sep 2011 13:56:58 +0200
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Acx+nuQVBWFl31DpQquld4KboH4g0w==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
X-OriginalArrivalTime: 29 Sep 2011 11:57:00.0024 (UTC) FILETIME=[E515B780:01CC7E9E]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182394>

Junio C Hamano wrote:
> * po/cygwin-backslash (2011-08-05) 2 commits
>  - On Cygwin support both UNIX and DOS style path-names
>  - git-compat-util: add generic find_last_dir_sep that respects is_dir_sep
> 
> Incomplete with respect to backslash processing in prefix_filename(), and
> also loses the ability to escape glob specials. Perhaps drop?

Yeah, I guess.

BTW, the git-compat-util commit might still be useful, should anyone ever want to reuse MinGW's find_last_dir_sep.
