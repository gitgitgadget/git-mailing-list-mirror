From: Matt Schmidt <schmidty@wsucougars.com>
Subject: Question On Hooks
Date: Fri, 24 Oct 2014 07:24:51 -0700
Message-ID: <544A6133.9040600@wsucougars.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 19:00:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhiEI-0006Ta-BJ
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 19:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825AbaJXRAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 13:00:42 -0400
Received: from imta-35.everyone.net ([216.200.145.35]:44010 "EHLO
	imta-35.everyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756103AbaJXRAl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 13:00:41 -0400
X-Greylist: delayed 9383 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Oct 2014 13:00:41 EDT
Received: from pps.filterd (omta006.sj2.proofpoint.com [127.0.0.1])
	by imta-38.everyone.net (8.14.5/8.14.5) with SMTP id s9OELjps019676
	for <git@vger.kernel.org>; Fri, 24 Oct 2014 07:24:17 -0700
X-Eon-Dm: dm0205
Received: by dm0205.mta.everyone.net (EON-AUTHRELAY2 - 17198411) id dm0205.544736d6.21dd56
	for <git@vger.kernel.org>; Fri, 24 Oct 2014 07:24:17 -0700
X-Eon-Sig: AQFhYMxUSmER4zUDjQIAAAAB,117152d0fb4a2f554ce8c071164ba7aa
X-Originating-Ip: 23.25.132.17
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.8.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.12.52,1.0.28,0.0.0000
 definitions=2014-10-24_04:2014-10-24,2014-10-24,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=1 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=7.0.1-1402240000 definitions=main-1410240122
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was curious if there was any work done on a possible Git client-side 
hook for "post-fetch"?

Not sure if this is a valid question or even the idea is valid for Git 
but my thoughts are to fire a script after a successful fetch (delta 
change) has been received for a local repository - any branch. Maybe 
have it recognized specific branches to watch? The idea would be for a 
simple database migration script.

I know there is a "post-merge" but it doesn't always fire after a "git 
pull" due to fast forwarding, I believe after testing?

I am not a C programmer but have done a little "noodling" at times, 
trying to learn. I figure this might be a good kick-starter idea?

Thanks for any help or information you might be able to provide on this 
question.


Matt Schmidt
PHP Programmer for Acronym Media
Spokane Valley, WA
