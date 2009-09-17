From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 3/4] reset: add option "--merge-safe" to "git reset"
Date: Thu, 17 Sep 2009 08:38:15 +0200
Message-ID: <4AB1D957.20902@viscovery.net>
References: <20090917040835.4048.51057.chriscool@tuxfamily.org> <20090917041440.4048.16353.chriscool@tuxfamily.org> <7vk4zykv7o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Sep 17 08:38:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoAdN-0007eD-Ac
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 08:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbZIQGiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 02:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754743AbZIQGiP
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 02:38:15 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:24501 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718AbZIQGiP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 02:38:15 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MoAdD-000144-Vm; Thu, 17 Sep 2009 08:38:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B7525BC81; Thu, 17 Sep 2009 08:38:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vk4zykv7o.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128716>

Junio C Hamano schrieb:
> As we established in the previous round, this is _different_ from --merge,
> but *not* in the sense that --merge is more dangerous and users should be
> using this new option instead, but in the sense that --merge perfectly
> works well for its intended use case, and this new option triggers a mode
> of operation that is meant to be used in a completely different use case,
> which is unspecified in this series without documentation.
> 
> In that light, is --merge-safe still a good name for the option, or merely
> a misleading one?

Do I understand this correctly?

(1) The intended use-case of --merge is to "reset _a_ merge".

(2) The intended use-case of --merge-safe is to point the branch head to a
different commit, but to carry the changes that currently are in the index
and wd over to the new commit, similar to checkout --merge.

I had mistaken that --merge actually performs (2) because of the striking
similarity of the option's name to checkout's --merge. So, IMHO, whatever
the new option is named that performs (2) - it introduces an
inconsistency, because --merge is already taken.

-- Hannes
