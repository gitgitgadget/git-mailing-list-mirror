From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Equivalent of "fixup" for git filter-branch
Date: Fri, 11 May 2012 15:45:50 +0200
Message-ID: <m2d36aompd.fsf@igel.home>
References: <CAGK7Mr5D0WQn-Tc1B5=F7+3OgZd1uy54Be-ZrbyFv0CP8JY5bw@mail.gmail.com>
	<m21umsylz8.fsf@igel.home>
	<CAGK7Mr7qdTwfha8aUdXE4FeXjA0rW3JL0q=a9kHArirjv5bygg@mail.gmail.com>
	<m2havmop75.fsf@igel.home>
	<CAGK7Mr6Z44iJqATgiWHXeutOHJM-vXauYeyYB0Z6c+mGYCr1Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 15:45:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSqAQ-00018N-2F
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 15:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759970Ab2EKNpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 09:45:53 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:60225 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759925Ab2EKNpw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 09:45:52 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VpsyQ68wFz4Kn8S;
	Fri, 11 May 2012 15:45:50 +0200 (CEST)
Received: from igel.home (ppp-93-104-149-188.dynamic.mnet-online.de [93.104.149.188])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VpsyQ5g4yz4KK5M;
	Fri, 11 May 2012 15:45:50 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 81EA3CA29F; Fri, 11 May 2012 15:45:50 +0200 (CEST)
X-Yow: CALIFORNIA is where people from IOWA or NEW YORK go to subscribe to
 CABLE TELEVISION!!
In-Reply-To: <CAGK7Mr6Z44iJqATgiWHXeutOHJM-vXauYeyYB0Z6c+mGYCr1Cg@mail.gmail.com>
	(Philippe Vaucher's message of "Fri, 11 May 2012 15:04:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197675>

Philippe Vaucher <philippe.vaucher@gmail.com> writes:

> I was also thinking maybe I could use --parent-filter: when I find a
> fixup commit, I set its parent to its parent's parent?

This will keep the attributes of the fixup commit, discarding the
parent's ones.  In git rebase, a fixup keeps the attributes of the
parent, discarding the ones of the fixup.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
