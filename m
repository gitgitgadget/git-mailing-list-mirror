From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Let format-patch and rebase ignore trivial merges.
Date: Wed, 16 Dec 2009 17:53:00 +0100
Message-ID: <4B29106C.1040501@viscovery.net>
References: <20091216164553.GA22471@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brlink@debian.org>
X-From: git-owner@vger.kernel.org Wed Dec 16 17:53:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKx7g-0000Sg-MY
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 17:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761312AbZLPQxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 11:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760335AbZLPQxH
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 11:53:07 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5858 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757222AbZLPQxE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 11:53:04 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NKx7V-000551-7d; Wed, 16 Dec 2009 17:53:01 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E46B81660F;
	Wed, 16 Dec 2009 17:53:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091216164553.GA22471@pcpool00.mathematik.uni-freiburg.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135334>

Please do not set Mail-Followup-To (and use reply-to-all to keep the Cc list).

Bernhard R. Link schrieb:
> --prune-tree makes rev-list without paths equivalent to
> "git rev-list $options -- ." (or .. or ../.. and so on,
> if you are in some subdirectory).
> This is the new default for format-patch and rebase

Why do you need a new option when you can just add "-- ." to the rev-list
invocation?

-- Hannes
