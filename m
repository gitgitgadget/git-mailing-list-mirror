From: Bill Lear <rael@zopyra.com>
Subject: Re: git protocol over port-forwarding
Date: Wed, 14 Mar 2007 16:04:49 -0600
Message-ID: <17912.29057.435478.123662@lisa.zopyra.com>
References: <17912.16608.852664.321837@lisa.zopyra.com>
	<Pine.LNX.4.64.0703142057300.25422@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Mar 14 23:05:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRbap-0006Sn-Iq
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 23:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbXCNWE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 18:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbXCNWE5
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 18:04:57 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61272 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034AbXCNWE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 18:04:56 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l2EM4nL26878;
	Wed, 14 Mar 2007 16:04:49 -0600
In-Reply-To: <Pine.LNX.4.64.0703142057300.25422@beast.quantumfyre.co.uk>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42239>

On Wednesday, March 14, 2007 at 21:05:37 (+0000) Julian Phillips writes:
>...
>I don't think there is anything that needs changing with the git daemon 
>... or at least I was able to successfully clone over an SSH port forward.
>
>I did get the same error as you originally, but this was due to SSH 
>failing to setup the tunnel connection (checking the logs showed that I 
>had got the hostname in the forward wrong).

Ok, so were you doing something like this:

% git clone git://localhost:5700/project

etc.?  and not using the ssh protocol, like this:

% git clone ssh://...

?


Bill
