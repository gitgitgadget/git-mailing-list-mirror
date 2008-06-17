From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Guided merge with override
Date: Tue, 17 Jun 2008 08:16:14 +0200
Message-ID: <485756AE.9050904@viscovery.net>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com>	 <20080616092554.GB29404@genesis.frugalware.org>	 <48563D6C.8060704@viscovery.net> <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Geoff Russell <geoffrey.russell@gmail.com>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jun 17 08:18:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8UWP-0005Za-2F
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 08:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbYFQGQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 02:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754902AbYFQGQq
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 02:16:46 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:61671 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452AbYFQGQS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 02:16:18 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K8UUJ-0002Kl-L5; Tue, 17 Jun 2008 08:16:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 53BF86B7; Tue, 17 Jun 2008 08:16:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85261>

Sverre Rabbelier schrieb:
> On Mon, Jun 16, 2008 at 12:16 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> The solution depends on whether *all* files in B should be taken, or only
>> those files in B where there's a merge conflict. I don't know an easy way
>> to do the former, but the latter I'd do like this:
>>
>>        $ git diff --name-only | xargs git checkout B --
> 
> Wouldn't something similar work but do a 'git ls-files' and filter it
> on files that have a merge conflict?

Well, you could 'git ls-files --unmerged', but that prints the whole index
entry, not just the name, and then you need a more complicated pipeline.

-- Hannes
