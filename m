From: Mike Gaffney <mr.gaffo@gmail.com>
Subject: Re: Question: Is it possible to host a writable git repo over both
 http and ssh?
Date: Wed, 25 Mar 2009 23:55:29 -0500
Message-ID: <49CB0AC1.2070006@gmail.com>
References: <49CA6A17.6050903@gmail.com> <20090326021259.GA5835@coredump.intra.peff.net> <49CAF607.1020905@gmail.com> <20090326033623.GA8031@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 05:56:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmhe7-0003Vv-Ni
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 05:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbZCZEzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 00:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbZCZEzO
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 00:55:14 -0400
Received: from pp0.asolutions.com ([66.236.120.143]:50904 "EHLO
	pp0.asolutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbZCZEzO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 00:55:14 -0400
Received: from [192.168.132.157] (vpn-mikegaffney.asolutions.com [192.168.132.157])
	by pp0.asolutions.com (8.14.1/8.14.1) with ESMTP id n2Q4t3gt032087;
	Wed, 25 Mar 2009 23:55:04 -0500
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090326033623.GA8031@coredump.intra.peff.net>
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7400:2.4.4,1.2.40,4.0.166 definitions=2009-03-26_01:2009-03-25,2009-03-25,2009-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0811170000 definitions=main-0903250200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114724>

I'm actually trying to take what Sean did with gerrit and extract a full Java/MinaSSHD based server that doesn't require a real user account and is configurable by spring. So yes, I'm using JGit on the server.

-Mike

Jeff King wrote:
> On Wed, Mar 25, 2009 at 10:27:03PM -0500, Mike Gaffney wrote:
> 
>> Does this go for JGit as well?
> 
> The hook must be enabled on the server side; are you running JGit on the
> server, or regular git?
> 
> -Peff

-- 
-Mike Gaffney (http://rdocul.us)
