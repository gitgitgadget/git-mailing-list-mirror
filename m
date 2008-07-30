From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH v3] Advertise the ability to abort a commit
Date: Wed, 30 Jul 2008 15:01:02 -0400
Message-ID: <E2809CE9-1DEB-48DA-8E42-8BEAB376FED2@silverinsanity.com>
References: <20080730051059.GA4497@sigill.intra.peff.net> <1217440391-13259-1-git-send-email-mail@cup.kalibalik.dk>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:03:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOGw3-0004ZR-D0
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 21:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbYG3TBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 15:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753952AbYG3TBG
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 15:01:06 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:46686 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbYG3TBF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 15:01:05 -0400
Received: from [192.168.1.109] (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 239361FFC02D;
	Wed, 30 Jul 2008 19:00:58 +0000 (UTC)
In-Reply-To: <1217440391-13259-1-git-send-email-mail@cup.kalibalik.dk>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90834>


On Jul 30, 2008, at 1:53 PM, Anders Melchiorsen wrote:

> An empty commit message is now treated as a normal situation, not an  
> error.
>
> Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
> ---
>
> So, I decided that I find it wrong to promote functionality
> that results in an error. The error is now changed into a
> normal exit (with status code 1.)

'git commit' should return with an error any time it does not commit.   
Otherwise scripts could get confused, thinking everything went fine  
when nothing actually got done.  Here, the user decided something was  
in error and canceled out, the same way using using ^C causes a non- 
zero return status.

~~ Brian
