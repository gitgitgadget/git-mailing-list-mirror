From: Steven Drake <sdrake@xnet.co.nz>
Subject: Re: [PATCH 2/2] Use $(git rev-parse --show-toplevel) in
 cd_to_toplevel()
Date: Mon, 11 Jan 2010 22:02:04 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1001112114140.9352@vqena.qenxr.bet.am>
References: <alpine.LNX.2.00.1001102016380.2560@vqena.qenxr.bet.am> <alpine.LNX.2.00.1001112022190.8842@vqena.qenxr.bet.am> <7viqb9w0c8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 10:09:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUGG8-0004Q2-1n
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 10:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab0AKJIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 04:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315Ab0AKJIR
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 04:08:17 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:37760 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150Ab0AKJIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 04:08:16 -0500
Received: from idran.drake.org.nz (ip-118-90-54-75.xdsl.xnet.co.nz [118.90.54.75])
	by ananke.wxnz.net (Postfix) with ESMTP id AF96540083;
	Mon, 11 Jan 2010 22:08:13 +1300 (NZDT)
In-Reply-To: <7viqb9w0c8.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136624>

On Sun, 10 Jan 2010, Junio C Hamano wrote:

>  (3) Please avoid referring to external resource in the commit log message
>      whenever makes sense; the log should be understandable on its own.
>      Because the first paragraph of your message describes the issue the
>      patch addresses very well already, you don't need "See NetBSD..." and
>      URL.  If you want to have them to help the reviewers, place such
>      reference after the three-dash line, just like you wrote "This is a
>      revision..."  You would help reviewers even more if you added a
>      pointer to your earlier patch after that sentence;

Wondered wether I should have put the extra info after the three-dashes or
not, now I know.

I also made sure my second email had References and In-Reply-To headers to 
my first email.

>  (4) Sign your patch, before the three-dash line.

Opps forgot '--signoff', I've put format.signoff=ture in .gitconfig to solve
that problem. 

Perhaps a warning message from format-patch of the form:
WARNING: You have not added a "Signed-off-by:" line did you mean to!

> Please line-break immediately after &&; it makes it easier to read in
> general, and it would make "cd" stand out in this particular case, as it
> is the most important part of this particular function.

Good point, althought did you mean as a general shell script coding rule or
just in this particular case.

Thanks for the feedback.  Did you want me to resend the signed and cleaned up
patches direct to you?  

-- 
Steven
