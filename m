From: David Miller <davem@davemloft.net>
Subject: Re: setup_path()
Date: Wed, 13 Feb 2008 17:54:05 -0800 (PST)
Message-ID: <20080213.175405.10792562.davem@davemloft.net>
References: <20080213.044915.123319879.davem@davemloft.net>
	<7v3arwpqxj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 14 02:54:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPTIk-000288-H5
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 02:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbYBNBxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 20:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbYBNBxe
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 20:53:34 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42985
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751018AbYBNBxd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Feb 2008 20:53:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id B1B51C8C199;
	Wed, 13 Feb 2008 17:54:05 -0800 (PST)
In-Reply-To: <7v3arwpqxj.fsf@gitster.siamese.dyndns.org>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73840>

From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 13 Feb 2008 12:00:40 -0800

> Yeah, Johannes Sixt had a patch to do exactly that earlier
> 
> 	Message-ID: <47B182C1.60006@viscovery.net>
> 	http://news.gmane.org/gmane.comp.version-control.git/73651
> 
> and I think it is a good idea to apply it.

Me too.

In fact people can easily end up unintentionally using different
versions of GIT.  For example in my case I had the distribution's GIT
installed in /usr/bin/git et al., then I installed the current
upstream version of GIT in my home directory.

A different version of GIT gets used when you run things locally
vs. doing things remotely over SSH.  And I didn't notice this until I
uninstalled the git-core package on my system.
