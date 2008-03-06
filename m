From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: do not show local changes for bare repositories
Date: Fri, 7 Mar 2008 10:07:33 +1100
Message-ID: <18384.31029.243013.764703@cargo.ozlabs.ibm.com>
References: <64b42ab91804e670057c807fd8265fc07106792c.1204806475.git.davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:08:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXPCC-0002e7-GY
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 00:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757864AbYCFXHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 18:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757776AbYCFXHj
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 18:07:39 -0500
Received: from ozlabs.org ([203.10.76.45]:55138 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756800AbYCFXHi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 18:07:38 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9C7BEDDE3B; Fri,  7 Mar 2008 10:07:37 +1100 (EST)
In-Reply-To: <64b42ab91804e670057c807fd8265fc07106792c.1204806475.git.davvid@gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76432>

David Aguilar writes:

> +set isbare [expr {[exec git rev-parse --is-bare-repository] == "true"}]

Nice idea, but I think we should update isbare in updatecommits, in
case the user does a checkout and then presses F5.

Paul.
