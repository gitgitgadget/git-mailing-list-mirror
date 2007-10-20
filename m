From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: add check for required tcl version >= 8.4
Date: Sat, 20 Oct 2007 21:19:11 +1000
Message-ID: <18201.58415.361214.601377@cargo.ozlabs.ibm.com>
References: <7vlkaplsu1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 13:28:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IjCVH-0001HG-KU
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 13:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979AbXJTLVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 07:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbXJTLVM
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 07:21:12 -0400
Received: from ozlabs.org ([203.10.76.45]:55179 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807AbXJTLVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 07:21:11 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 038E5DDEB6; Sat, 20 Oct 2007 21:21:11 +1000 (EST)
In-Reply-To: <7vlkaplsu1.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61819>

Junio C Hamano writes:

> From: Steffen Prohaska <prohaska@zib.de>
> Date: Fri, 28 Sep 2007 22:57:22 +0200
> 
> gitk requires tcl version >= 8.4 to work flawlessly. So let's
> check the tcl version and quit if it's too low.
> 
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
> 
>  * I do not have a ready access to older tcl/tk myself, so I
>    cannot judge if this is sensible or not.  Just forwarding in
>    case you missed it.

Thanks for the patch.  I have put in something similar using the
package require command, and using show_error to display the error in
a window.

Paul.
