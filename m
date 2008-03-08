From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: do not show local changes for bare repositories
Date: Sat, 8 Mar 2008 22:14:44 +1100
Message-ID: <18386.29988.380116.517508@cargo.ozlabs.ibm.com>
References: <64b42ab91804e670057c807fd8265fc07106792c.1204806475.git.davvid@gmail.com>
	<8875845cb2c0c3a1ac515b8f71e6be77f3266479.1204879048.git.davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 02:41:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYX1C-00008j-1n
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 02:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbYCJBkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 21:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753296AbYCJBkd
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 21:40:33 -0400
Received: from ozlabs.org ([203.10.76.45]:48826 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237AbYCJBkc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 21:40:32 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 73450DDDF9; Mon, 10 Mar 2008 12:40:31 +1100 (EST)
In-Reply-To: <8875845cb2c0c3a1ac515b8f71e6be77f3266479.1204879048.git.davvid@gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76689>

David Aguilar writes:

> @@ -407,6 +408,7 @@ proc updatecommits {} {
>      foreach vid [array names idpending "$n,*"] {
>  	unset idpending($vid)
>      }
> +    set isbare [expr {[exec git rev-parse --is-bare-repository] == "true"}]

Sorry, I meant do that in updatecommits as well as at startup.  You
still need that line in the startup code.

Paul.
