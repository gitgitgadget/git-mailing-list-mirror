From: Mike Berry <mrberry@lanl.gov>
Subject: configure failed to detect no asciidoc
Date: Tue, 02 Dec 2014 16:32:56 -0700
Message-ID: <547E4C28.7050407@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 00:57:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvxKD-0000x1-93
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 00:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933483AbaLBX5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 18:57:41 -0500
Received: from proofpoint5.lanl.gov ([204.121.3.53]:47473 "EHLO
	proofpoint5.lanl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933309AbaLBX5l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 18:57:41 -0500
X-Greylist: delayed 1483 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Dec 2014 18:57:40 EST
Received: from mailrelay1.lanl.gov (mailrelay1.lanl.gov [128.165.4.101])
	by mailgate5.lanl.gov (8.14.7/8.14.7) with ESMTP id sB2NWu1P027398
	for <git@vger.kernel.org>; Tue, 2 Dec 2014 16:32:56 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailrelay1.lanl.gov (Postfix) with ESMTP id B3C6A137314D
	for <git@vger.kernel.org>; Tue,  2 Dec 2014 16:32:56 -0700 (MST)
X-NIE-2-Virus-Scanner: amavisd-new at mailrelay1.lanl.gov
Received: from kudu.lanl.gov (kudu.lanl.gov [128.165.45.183])
	by mailrelay1.lanl.gov (Postfix) with ESMTP id A4A2F1373155
	for <git@vger.kernel.org>; Tue,  2 Dec 2014 16:32:56 -0700 (MST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.13.68,1.0.33,0.0.0000
 definitions=2014-12-03_01:2014-12-02,2014-12-02,1970-01-01 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260601>


I just downloaded the latest git, and tried to build with:

 > make configure
 > ./configure
 > make all doc

build failed while "building" doc, asciidoc not found

I would have thought the configure would have detected that.....


I downloaded, built, and installed asciidoc, and re-built git, things 
are mostly good.

The documentation is still causing me trouble as my firewall doesn't 
like the html in Documentation/docbook.xsl, but that's probably a 
firewall issue.  Is there documentation method, not requiring active web 
access?



Mike
