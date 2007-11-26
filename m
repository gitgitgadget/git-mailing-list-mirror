From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Reordering lines in "git-rebase -i" task sheet
Date: Mon, 26 Nov 2007 13:14:02 +0000
Message-ID: <fiegqq$kq5$1@ger.gmane.org>
References: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org> <fi64ge$u1g$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 14:14:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwdnS-0006EE-Ra
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 14:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbXKZNOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 08:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbXKZNOX
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 08:14:23 -0500
Received: from main.gmane.org ([80.91.229.2]:51913 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbXKZNOW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 08:14:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iwdmp-0005dD-RI
	for git@vger.kernel.org; Mon, 26 Nov 2007 13:14:07 +0000
Received: from 194.70.53.227 ([194.70.53.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 13:14:07 +0000
Received: from andyparkins by 194.70.53.227 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 13:14:07 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 194.70.53.227
User-Agent: KNode/0.10.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66070>

Andy Parkins wrote:

> I'm not convinced that this is a great idea.

I've just tried it and (for me) I don't like it.

 - It's now harder to find the commits I want to edit, the cursor still
   doesn't start in the right place, but now I can't get to the right place
   quickly (the right place being the bottom of the list) because the
   interesting bits are neither at the top nor at the bottom
 - vim no longer automatically loads a reasonable syntax highlighting mode
   making the comment lines appear the same as the pick lines.
 - On a long rebase list the important message explaining what I'm looking
   at isn't on screen.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
