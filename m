From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 00/12] add --ff option to cherry-pick
Date: Mon, 01 Mar 2010 09:20:11 +0100
Message-ID: <4B8B78BB.8050008@viscovery.net>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Mar 01 09:20:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm0rb-0005BB-OM
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 09:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab0CAIUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 03:20:20 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55946 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab0CAIUS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 03:20:18 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nm0rL-0005Qj-NX; Mon, 01 Mar 2010 09:20:11 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 691581660F;
	Mon,  1 Mar 2010 09:20:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100228222038.2260.25016.chriscool@tuxfamily.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141302>

Christian Couder schrieb:
> The goal of this patch series is to make it possible for "git cherry-pick"
> to fast forward instead of creating a new commit if the cherry picked commit
> has the same parent as the one we are cherry-picking on.

Why don't you just divert to 'git merge --ff' in this case?

-- Hannes

(PS: Please _do_not_ Cc me if/when you resend this series.)
