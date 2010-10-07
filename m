From: David Miller <davem@davemloft.net>
Subject: Re: format-patch on permission change gives empty patch
Date: Wed, 06 Oct 2010 17:40:08 -0700 (PDT)
Message-ID: <20101006.174008.70175671.davem@davemloft.net>
References: <20101006.173714.245380201.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 02:39:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3eWX-0003Nh-If
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 02:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933018Ab0JGAjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 20:39:47 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:35132
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932573Ab0JGAjq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 20:39:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 389CB24C087
	for <git@vger.kernel.org>; Wed,  6 Oct 2010 17:40:08 -0700 (PDT)
In-Reply-To: <20101006.173714.245380201.davem@davemloft.net>
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158360>

From: David Miller <davem@davemloft.net>
Date: Wed, 06 Oct 2010 17:37:14 -0700 (PDT)

> 
> When I ask git to format-patch a commit that is just a file
> permission change, it ends up generating an empty file, not
> even the commit message is included.

Ok it turns out that the commit in question was a NOP since the file
permissions didn't change.

But even if the patch is truly empty, format-patch should still give
me the commit message shouldn't it?
