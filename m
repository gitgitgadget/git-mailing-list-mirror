From: Sam Vilain <sam@vilain.net>
Subject: Re: post-update script to update wc - version 2
Date: Wed, 27 Jun 2007 14:06:56 +1200
Message-ID: <4681C640.6060408@vilain.net>
References: <E1I3MuE-0005eO-00@www.watts.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sam Vilain <samv@utsl.gen.nz>
X-From: git-owner@vger.kernel.org Wed Jun 27 04:07:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Mvz-0008U3-9m
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 04:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbXF0CHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 22:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbXF0CHF
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 22:07:05 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:36674 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbXF0CHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 22:07:04 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id BB6E41574C1; Wed, 27 Jun 2007 14:07:02 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 3446413A4F6;
	Wed, 27 Jun 2007 14:06:59 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <E1I3MuE-0005eO-00@www.watts.utsl.gen.nz>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51006>

Sam Vilain wrote:
>         this_tree=`git-cat-file commit $commit | awk '/^tree/ { print $2; exit }'`

Of course on newer git, `git-rev-parse $commit:` will do that.

Sam.
