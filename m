From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Better cooperation between checkouts and stashing
Date: Mon, 01 Mar 2010 11:50:25 +0100
Message-ID: <4B8B9BF1.10408@web.de>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 11:50:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm3Cp-0004eh-IV
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 11:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956Ab0CAKu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 05:50:26 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:55115 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab0CAKuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 05:50:25 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 8D4CC14107C7D;
	Mon,  1 Mar 2010 11:50:24 +0100 (CET)
Received: from [78.48.194.16] (helo=[192.168.1.202])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Nm3Ci-00077d-00; Mon, 01 Mar 2010 11:50:24 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <7vr5o6s5xf.fsf@alter.siamese.dyndns.org>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+2d2yT+1wVhNlrLfbb7n1GGUP6l1k2Ipf6sBIh
	dqevLBfPxRGc9SvBnDW3AD0ywQNUsGIqVxJ5y7d1YlSTuJYl9W
	b9wWk5LABT3Q7TfY5C3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141313>

>  - The branch you happen to have checked out was 'next', but the solution
>    is a bugfix, and should go to 'maint'.
> 
> Now, at this point, you want to checkout 'maint' without losing your local
> change.  The paths you touched with your quick fix are often not different
> between the two branches, and "checkout maint" will checkout the branch
> while keeping your local changes intact.

Does the wording in the manual fit to the mentioned software development practice?

"When <paths> are not given, this command switches branches by updating the
index, working tree, and HEAD to reflect the specified branch."

I see a need for further clarifications of the involved details.
- Only the focus will be set on the specified branch.
- Would it be useful if it will become configurable if the corresponding
contents will also be automatically restored by a checkout?

Regards,
Markus
