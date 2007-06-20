From: Sam Vilain <sam@vilain.net>
Subject: Re: Directory renames (was Re: blame follows renames, but log doesn't)
Date: Thu, 21 Jun 2007 08:18:22 +1200
Message-ID: <46798B8E.6040103@vilain.net>
References: <46a038f90706181810p716f914al4d9abba5bfe7eb5@mail.gmail.com> <20070619071916.GC9177@thunk.org> <4677A7EF.500@midwinter.com> <4678204C.6050409@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Steven Grimm <koreth@midwinter.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:18:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I16dX-0003om-Ko
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 22:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbXFTUSm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 16:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbXFTUSl
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 16:18:41 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:33311 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbXFTUSk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 16:18:40 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id BEA9913A4FC; Thu, 21 Jun 2007 08:18:39 +1200 (NZST)
Received: from [192.168.1.2] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 2B1C413A4F0;
	Thu, 21 Jun 2007 08:18:36 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <4678204C.6050409@midwinter.com>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50565>

Steven Grimm wrote:
> Hope that's illuminating or at least interesting to someone.

I didn't review your test cases in detail, but they seemed to suffer
from what I call "over-trivialization"; the heuristic methods don't work
very well for these non-real-world test cases because they're not long
enough.  Are you confident that these deficiencies are still there with
longer examples?

Sam.
