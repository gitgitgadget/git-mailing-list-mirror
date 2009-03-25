From: Mike Gaffney <mr.gaffo@gmail.com>
Subject: Question: Is it possible to host a writable git repo over both http
 and ssh?
Date: Wed, 25 Mar 2009 12:29:59 -0500
Message-ID: <49CA6A17.6050903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 18:52:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXHV-00066K-HK
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 18:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035AbZCYRvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 13:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754873AbZCYRvS
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 13:51:18 -0400
Received: from pp0.asolutions.com ([66.236.120.143]:44458 "EHLO
	pp0.asolutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885AbZCYRvR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 13:51:17 -0400
X-Greylist: delayed 1264 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2009 13:51:17 EDT
Received: from acews3.asolutions.com (acews3.asolutions.com [192.168.2.179])
	by pp0.asolutions.com (8.14.1/8.14.1) with ESMTP id n2PHU8MB018174
	for <git@vger.kernel.org>; Wed, 25 Mar 2009 12:30:08 -0500
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7400:2.4.4,1.2.40,4.0.166 definitions=2009-03-25_08:2009-03-25,2009-03-25,2009-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0811170000 definitions=main-0903250100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114628>

I am trying to setup a git repo internally at my work. I would like to 
make the repo accessable via https for both read and write so that we 
may access it from customer locations which don't allow anything but 
https. I would also like to host it via SSH because that protocol is 
much faster. I know that when you push with http it runs 'git 
update-server-info', would I have to make the ssh pushes do the same? 
Will this even work?

Thanks, 
    Mike Gaffney
