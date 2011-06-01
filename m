From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: unable to get type of object
Date: Wed, 01 Jun 2011 20:18:07 +0200
Message-ID: <4DE6825F.9040608@dbservice.com>
References: <4DE5E60B.2030903@garrigos.cat> <20110601160447.GA7132@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robert Garrigos <robert@garrigos.cat>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 20:51:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRqW0-0007vz-5l
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 20:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661Ab1FASva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 14:51:30 -0400
Received: from static.133.192.47.78.clients.your-server.de ([78.47.192.133]:49784
	"EHLO office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab1FASv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 14:51:29 -0400
X-Greylist: delayed 1991 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Jun 2011 14:51:29 EDT
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.089,BAYES_00: -1.665,TOTAL_SCORE: -1.576,autolearn=ham
X-Spam-Level: 
Received: from calvin.local ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Wed, 1 Jun 2011 20:16:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110601160447.GA7132@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174890>

On 6/1/11 6:04 PM, Jeff King wrote:
> On Wed, Jun 01, 2011 at 09:11:07AM +0200, Robert Garrigos wrote:
>> Besides that I'm running git 1.2.4 and that the git command for that
>> version is fsck-objects, I'm not having any result at all.
> Wow, that's pretty ancient by git standards.

When looking through the last git survey I was wondering why there were 
people still using pre 1.3.x versions. Here we finally meet one of them :)

v1.2.4 was released March 1, 2006. It has about 48k lines of code, while 
master today has ~287k (counted using sloccount).

tom
