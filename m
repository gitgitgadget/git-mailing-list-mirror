From: Sam Vilain <sam@vilain.net>
Subject: Re: post-update script to update wc - version 2
Date: Thu, 28 Jun 2007 10:45:52 +1200
Message-ID: <4682E8A0.8050205@vilain.net>
References: <E1I3MuE-0005eO-00@www.watts.utsl.gen.nz>	 <4681C640.6060408@vilain.net> <81b0412b0706270221y40bac0a7gf6b73eda9f1e4bb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 00:46:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3gH4-0000DO-TJ
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 00:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758839AbXF0WqH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 18:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758017AbXF0WqF
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 18:46:05 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:49850 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbXF0WqE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 18:46:04 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 9F0A013A3E1; Thu, 28 Jun 2007 10:45:59 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id DFCC713A303;
	Thu, 28 Jun 2007 10:45:54 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <81b0412b0706270221y40bac0a7gf6b73eda9f1e4bb0@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51065>

Alex Riesen wrote:
> On 6/27/07, Sam Vilain <sam@vilain.net> wrote:
>> Sam Vilain wrote:
>>>         this_tree=`git-cat-file commit $commit | awk '/^tree/ { print $2; exit }'`
>> Of course on newer git, `git-rev-parse $commit:` will do that.
> Are you sure? Maybe you mean git-rev-parse "$commit"^{tree}?

Ah, I missed that on the git-rev-parse man page.  Much better!

Sam.
