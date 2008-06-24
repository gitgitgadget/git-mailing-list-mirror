From: Reini Urban <rurban@x-ray.at>
Subject: Re: [TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 18:54:13 +0200
Message-ID: <486126B5.1090909@x-ray.at>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <20080624163810.GA4654@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 19:00:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBBsm-00064O-GD
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 19:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbYFXQ7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 12:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbYFXQ7o
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 12:59:44 -0400
Received: from mailbackup.inode.at ([213.229.60.24]:35983 "EHLO
	mailbackup.inode.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbYFXQ7n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 12:59:43 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jun 2008 12:59:43 EDT
Received: from [62.99.145.5] (port=51247 helo=mx.inode.at)
	by mailbackup.inode.at with esmtp (Exim 4.67)
	(envelope-from <rurban@x-ray.at>)
	id 1KBBml-0007Lv-Gj
	for git@vger.kernel.org; Tue, 24 Jun 2008 18:54:27 +0200
Received: from [212.183.60.88] (port=4929 helo=[10.0.0.5])
	by smartmx-05.inode.at with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KBBli-0008Up-1N
	for git@vger.kernel.org; Tue, 24 Jun 2008 18:53:22 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.1.13) Gecko/20080313 SeaMonkey/1.1.9
In-Reply-To: <20080624163810.GA4654@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86085>

Jeff King schrieb:
> On Tue, Jun 24, 2008 at 03:17:18PM +0100, Johannes Schindelin wrote:
> 
>> When you look for a fix instead of a regression, it can be quite hard
>> to twist your brain into choosing the correct bisect command between
>> 'git bisect bad' and 'git bisect good'.
>>
>> So introduce the commands 'git bisect fixed' and 'git bisect unfixed'.
> 
> Thanks. This just bit me the other day, and I thought of the same
> solution. I think it might be worth a "non-toy" patch.

Maybe "notfixed" is a better wording than "unfixed".
