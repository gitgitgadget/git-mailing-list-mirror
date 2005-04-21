From: Joel Schopp <jschopp@austin.ibm.com>
Subject: zlib version, list archives
Date: Thu, 21 Apr 2005 12:19:32 -0500
Message-ID: <4267E0A4.40506@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 21 19:16:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOfHA-0004mp-3a
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 19:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVDURTu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 13:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVDURTu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 13:19:50 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:54710 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261555AbVDURTk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 13:19:40 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j3LHJdua443492
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 13:19:39 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j3LHJc7j367236
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:19:38 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j3LHJcde026432
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:19:38 -0600
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j3LHJcJT026427
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:19:38 -0600
Received: from [127.0.0.1] (IBM-4JV1JIVB3GB.austin.ibm.com [9.53.95.184])
	by austin.ibm.com (8.12.10/8.12.10) with ESMTP id j3LHJbeT051354
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 12:19:37 -0500
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I downloaded git-pasky 0.6.2.  I cannot compile it because my zlib 
version is 1.1.4 and git-pasky relies on function deflateBound() which 
wasn't introduced until zlib version 1.2.x  Is there a patch out there 
to work around this and maybe conditionally compile based on the zlib 
version?

I apologize in advance if this has already been asked, I cannot find an 
archive of this list.  Could somebody point me to one?

