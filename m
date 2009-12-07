From: Yakup Akbay <yakbay@ubicom.com>
Subject: [BUG] git config does not reuse section name
Date: Mon, 07 Dec 2009 19:06:19 +0200
Message-ID: <4B1D360B.4070203@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 20:10:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHiyq-0005er-Kl
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 20:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbZLGTKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 14:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbZLGTKG
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 14:10:06 -0500
Received: from server70.appriver.com ([69.20.119.203]:2018 "EHLO
	server70.appriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244AbZLGTKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 14:10:05 -0500
X-Greylist: delayed 7201 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2009 14:10:05 EST
X-Policy: GLOBAL - ubicom.com
X-Primary: yakbay@ubicom.com
X-Note: This Email was scanned by AppRiver SecureTide
X-Virus-Scan: V-
X-Note: TCH-CT/SI:0-126/SG:2 12/7/2009 12:10:15 PM
X-GBUdb-Analysis: 0, 216.112.109.98, Ugly c=0.662751 p=-0.838969 Source Normal
X-Signature-Violations: 0-0-0-1582-c
X-Note: Spam Tests Failed: 
X-Country-Path: PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 216.112.109.98
X-Note-Reverse-DNS: 216.112.109.98.ptr.us.xo.net
X-Note-WHTLIST: yakbay@ubicom.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 115 116 117 118 122 123 221 
X-Note: Mail Class: VALID
X-Note: Headers Injected
Received: from [216.112.109.98] (HELO stork.scenix.com)
  by server70.appriver.com (CommuniGate Pro SMTP 5.3c2)
  with ESMTP id 108701875 for git@vger.kernel.org; Mon, 07 Dec 2009 12:10:16 -0500
Received: from [172.18.200.148] ([172.18.200.148]) by stork.scenix.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 7 Dec 2009 09:02:47 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-OriginalArrivalTime: 07 Dec 2009 17:02:47.0906 (UTC) FILETIME=[1A399420:01CA775F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134773>

When I repeat the following n times

    $ git config color.ui always
    $ git config --unset color.ui


it ends up the section name [color] n times in the .git/config file.



like this for n=4:

    [color]
    [color]
    [color]
    [color]


Using git version 1.6.5.3 (I don't know whether this is already fixed in 
in later versions)

Yakup
