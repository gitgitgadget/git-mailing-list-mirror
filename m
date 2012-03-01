From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/5] t6300 (for-each-ref): modernize style
Date: Thu, 01 Mar 2012 07:53:11 +0100
Message-ID: <4F4F1CD7.4060403@viscovery.net>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com> <1330566326-26075-2-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 07:53:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2ztK-0006gt-Ux
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 07:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918Ab2CAGxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 01:53:17 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:59305 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab2CAGxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 01:53:16 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S2zt1-0001Wf-QG; Thu, 01 Mar 2012 07:53:11 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7BDA51660F;
	Thu,  1 Mar 2012 07:53:11 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <1330566326-26075-2-git-send-email-tmgrennan@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191901>

Am 3/1/2012 2:45, schrieb Tom Grennan:
> +	git for-each-ref --format="%(refname)" --sort=refname |
> +		test_cmp expect -

DON'T DO THIS. It loses the exit code of the git invocation.

(And it is contrary to my effort to move all test_cmp away from being used
in a pipeline because I want to use a comparator tool that does not
understand '-' as stdin.)

-- Hannes
