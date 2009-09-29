From: Yakup Akbay <yakbay@ubicom.com>
Subject: Compact view of history in gitk
Date: Tue, 29 Sep 2009 14:49:09 +0300
Message-ID: <4AC1F435.4030802@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 13:58:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsbM0-0007R3-AL
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 13:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbZI2L4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 07:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbZI2L4p
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 07:56:45 -0400
Received: from server70.appriver.com ([69.20.119.203]:2194 "EHLO
	server70.appriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZI2L4o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 07:56:44 -0400
X-Policy: GLOBAL - ubicom.com
X-Primary: yakbay@ubicom.com
X-Note: This Email was scanned by AppRiver SecureTide
X-Virus-Scan: V-
X-Note: TCH-CT/SI:0-90/SG:2 9/29/2009 7:56:34 AM
X-GBUdb-Analysis: 0, 216.112.109.98, Ugly c=0.729425 p=-0.903879 Source Normal
X-Signature-Violations: 0-0-0-2392-c
X-Note: Spam Tests Failed: 
X-Country-Path: PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 216.112.109.98
X-Note-Reverse-DNS: 216.112.109.98.ptr.us.xo.net
X-Note-WHTLIST: yakbay@ubicom.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 115 116 117 118 122 123 220 
X-Note: Mail Class: VALID
X-Note: Headers Injected
Received: from [216.112.109.98] (HELO stork.scenix.com)
  by server70.appriver.com (CommuniGate Pro SMTP 5.2.16)
  with ESMTP id 103835158 for git@vger.kernel.org; Tue, 29 Sep 2009 07:56:40 -0400
Received: from [172.18.200.172] ([172.18.200.172]) by stork.scenix.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 29 Sep 2009 04:46:22 -0700
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-OriginalArrivalTime: 29 Sep 2009 11:46:23.0093 (UTC) FILETIME=[77E44250:01CA40FA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129295>

Hi,

imagine a git history with many branches and many many commits in it,

which you cannot have a bird's eye view to the whole git history
(consider linux kernel). What I'm looking for is to see is a graphical
history representation with only the tip of all branches plus all merge
bases drwan like a molecul shape, where all intermediate commits are
replaced by a single symbol like '~'. 

Think of the gitk version of the history below:

                  E-*-*-*-F
                 /
A-*-*-*-*-*-*-B-C-*-*-*-D
               \
                G-*-*-H-*-*-*-I
                       \
                        J-*-*-*-*-*-K


I want an output like this:

        E-~-F
       /
A-~-B-C-~-D
     \
      G-~-H-~-I
           \
            J-~-K

Is there an option in gitk (or in any other tool) to get such a view? 

Yakup
