From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: grafts not appearing in manual pages
Date: Thu, 27 Sep 2007 08:22:27 +0200
Message-ID: <46FB4C23.8010400@viscovery.net>
References: <20070926202441.GA31848@glandium.org> <20070926210102.GF26099@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 08:22:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iamlh-0003wq-Hr
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 08:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbXI0GWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 02:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbXI0GWb
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 02:22:31 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:33544 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbXI0GWa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 02:22:30 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IamlY-0006w5-4m; Thu, 27 Sep 2007 08:22:28 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B857F69F; Thu, 27 Sep 2007 08:22:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070926210102.GF26099@fieldses.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59269>

J. Bruce Fields schrieb:
> On Wed, Sep 26, 2007 at 10:24:41PM +0200, Mike Hommey wrote:
>> Hi,
>>
>> The only occurrence of grafts in the manual pages is in the
>> git-filter-branch one. I somehow feel this is wrong not to see it
>> described more "formally" in the manual pages.
>>
>> I wouldn't mind writing a small something, except I have no idea what
>> would be the most appropriate place to talk about it... Does anyone have
>> such an idea ?
> 
> It could go in Documentation/user-manual.txt, but I don't know where.

IMHO grafts should not be made known to a wide audience until send-pack, 
pack-objects, and prune are fixed so that you cannot corrupt your repository 
when there are grafts.

See http://thread.gmane.org/gmane.comp.version-control.git/37744
in particular http://article.gmane.org/gmane.comp.version-control.git/37866
on a sketch how to fix the issues.

-- Hannes
