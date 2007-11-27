From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Replace misleading message during interactive rebasing
Date: Tue, 27 Nov 2007 09:31:06 +0100
Message-ID: <474BD5CA.7050407@viscovery.net>
References: <1196111891-18518-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, tsuna@lrde.epita.fr,
	Johannes.Schindelin@gmx.de, mcostalba@gmail.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 09:31:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwvqw-0004QA-2z
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 09:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbXK0IbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 03:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbXK0IbP
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 03:31:15 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35027 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbXK0IbO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 03:31:14 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iwvpr-0002D1-KY; Tue, 27 Nov 2007 09:30:27 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E8AFF6EF; Tue, 27 Nov 2007 09:31:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1196111891-18518-1-git-send-email-win@wincent.com>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2, UPPERCASE_25_50=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66171>

Wincent Colaiuta schrieb:
> +		export _GIT_CHERRY_PICK_HELP="run 'git rebase --continue'"

Isn't this a bashism? Should be:

		_GIT_CHERRY_PICK_HELP="run 'git rebase --continue'"
		export _GIT_CHERRY_PICK_HELP

(and the second instance of this as well, of course)

-- Hannes
