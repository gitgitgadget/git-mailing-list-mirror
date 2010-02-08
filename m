From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Feb 2010, #02; Sun, 07)
Date: Mon, 08 Feb 2010 09:29:01 +0100
Message-ID: <4B6FCB4D.6070602@viscovery.net>
References: <7vhbpswju3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 09:31:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeP1c-0003yJ-Oc
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 09:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200Ab0BHI3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 03:29:09 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38005 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751066Ab0BHI3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 03:29:08 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NeOzN-0002RN-QS; Mon, 08 Feb 2010 09:29:02 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 36EBE1660F;
	Mon,  8 Feb 2010 09:29:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vhbpswju3.fsf@alter.siamese.dyndns.org>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139280>

Junio C Hamano schrieb:
> * sp/maint-push-sideband (2010-02-05) 6 commits
>  - receive-pack: Send hook output over side band #2
>  - receive-pack: Wrap status reports inside side-band-64k
>  - receive-pack: Refactor how capabilities are shown to the client
>  - send-pack: demultiplex a sideband stream with status data
>  - run-command: support custom fd-set in async
>  - run-command: Allow stderr to be a caller supplied pipe
>  (this branch is used by sp/push-sideband.)
> 
> Based on 1.6.5 maintenance track
> 
> * sp/push-sideband (2010-02-05) 0 commits
>  (this branch uses sp/maint-push-sideband.)
> 
> And my conflict resolution in #ifdef WINDOWS codepath (meaning: untested,
> please check).

The resolution is correct. I'm using this branch in my private build on
Windows; so far it works as expected.

-- Hannes
