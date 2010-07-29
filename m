From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: finding if a commit is needed
Date: Wed, 28 Jul 2010 19:06:48 -0500
Message-ID: <20100729000647.GB29156@dert.cs.uchicago.edu>
References: <AANLkTin4o=uNBFELYMb8TDA=taGJyqpLvgxZcPFr+Pq+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 02:07:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeGeP-0003b9-WF
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 02:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170Ab0G2AGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 20:06:49 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:48916 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab0G2AGt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 20:06:49 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 6CCAFA1FC;
	Wed, 28 Jul 2010 19:06:48 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 390B76914; Wed, 28 Jul 2010 19:06:48 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <AANLkTin4o=uNBFELYMb8TDA=taGJyqpLvgxZcPFr+Pq+@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152131>

Geoff Russell wrote:

> Is there something which can test whether a commit is needed?
> 
> I define "needed" as meaning when git commit -a would make a non-identical
> commit.

Maybe "git diff --exit-code HEAD"?

Regards,
Jonathan
