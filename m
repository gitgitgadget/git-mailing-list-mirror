From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn and hierarchal branches.
Date: Tue, 02 Oct 2007 00:45:37 +1300
Message-ID: <4700DDE1.2000906@vilain.net>
References: <20070930070754.GA10264@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 13:45:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcJih-0002fF-GH
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 13:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbXJALpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 07:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbXJALpo
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 07:45:44 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:56489 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbXJALpn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 07:45:43 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id C8E3421CFEA; Mon,  1 Oct 2007 23:45:41 +1200 (NZST)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 42AFC21CFE8;
	Mon,  1 Oct 2007 23:45:36 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <20070930070754.GA10264@old.davidb.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59604>

David Brown wrote:
> I'm trying to use git-svn to track the 'Tango' SVN repository
> <http://www.dsource.org/projects/tango/wiki/Download>
>
> Their layout is mostly standard, except that they have an extra hierarchy
> in the branch directory (branch/user1, branch/user2, branch/D1_0 for a
> release).
>
> Is this something I can easily track with git-svn, or am I best trying to
> do it manually?

Track each branch with a separate git-svn remote.

Sam.
