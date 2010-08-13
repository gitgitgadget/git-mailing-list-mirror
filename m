From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 2/2] git-rebase--interactive.sh: use printf instead of echo to print commit message
Date: Fri, 13 Aug 2010 17:34:07 -0400
Message-ID: <4BE6DADC-6846-4942-B361-639DCD308F09@silverinsanity.com>
References: <D1A252AE-5D4C-4E51-9359-F4A443BB8A2E@silverinsanity.com> <vFgTzGXLhalxcMpLoOFhqi1W6sU5I3lJ9CWjrrJjoRmkMjHSswmpLXU2vVL8PS5JJNEO727l9q8@cipher.nrlssc.navy.mil>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: avarab@gmail.com, Matthieu.Moy@imag.fr, gitster@pobox.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 13 23:34:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok1tG-0000H5-PW
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 23:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634Ab0HMVeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 17:34:13 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:39865 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab0HMVeK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 17:34:10 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id CBD321FFC135; Fri, 13 Aug 2010 21:34:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id E79DB1FFC0D4;
	Fri, 13 Aug 2010 21:34:00 +0000 (UTC)
In-Reply-To: <vFgTzGXLhalxcMpLoOFhqi1W6sU5I3lJ9CWjrrJjoRmkMjHSswmpLXU2vVL8PS5JJNEO727l9q8@cipher.nrlssc.navy.mil>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153512>


On Aug 13, 2010, at 4:47 PM, Brandon Casey wrote:

> Replace the echo statements that operate on $rest with printf's to restore
> what was lost from 938791cd.  This avoids any mangling that XSI-conformant
> echo's may introduce.

ACK, this was exactly the problem.  Thanks for the quick response!

~~ Brian
