From: Sam Vilain <sam@vilain.net>
Subject: Re: blame follows renames, but log doesn't
Date: Tue, 19 Jun 2007 13:34:22 +1200
Message-ID: <4677329E.3050903@vilain.net>
References: <46a038f90706181810p716f914al4d9abba5bfe7eb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 03:34:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Sc4-0004qK-V4
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 03:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbXFSBeb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 21:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755853AbXFSBeb
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 21:34:31 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:43288 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242AbXFSBea (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 21:34:30 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 16F2413A4F0; Tue, 19 Jun 2007 13:34:28 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 871B113A342;
	Tue, 19 Jun 2007 13:34:24 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <46a038f90706181810p716f914al4d9abba5bfe7eb5@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50438>

Martin Langhoff wrote:
> And I kind of hate having to reply to things like these
> 
>     http://www.markshuttleworth.com/archives/125

I think that there should be clear conventions for how to place such
breadcrumbs in the commit log, that can be suitably ignored or honoured.

At least these two things fit into this category:

  1. renaming.  A comment on a changelog entry saying "I moved this file
     from A to B in this commit".  With all of the user friendliness and
     limitations this implies (oh, you got the information wrong or
     didn't put it in?  oh well, now history is b0rked forever, HAND)

  2. cherry picking.  bzr uses patch UUIDs, with all of the user
     friendliness and limitations this implies (oh, you merged that
     patch and accidentally didn't pick any changes?  whoops, it's
     in your history anyway so never try to merge that again).

Perhaps also there should be other conventions for how to encode other
strange data out of the namespace of the filesystem ("in a different
dimension", perhaps) like "file attributes".

Sam.
