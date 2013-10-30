From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v2 1/7] gitk: support -G option from the command line
Date: Wed, 30 Oct 2013 07:30:23 +0100
Message-ID: <8738nji83k.fsf@linux-k42r.v.cablecom.net>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
	<72ba9e0cd862a2fb014d0633802f9afbb0bea27d.1383031141.git.tr@thomasrast.ch>
	<xmqqzjprd1ge.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 07:30:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbPIf-0000XO-3X
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 07:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797Ab3J3Gag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 02:30:36 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:58527 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583Ab3J3Gaf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 02:30:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id BD4B44D6516;
	Wed, 30 Oct 2013 07:30:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xf_EEgxEwJaG; Wed, 30 Oct 2013 07:30:23 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (vpn-global-dhcp2-62.ethz.ch [129.132.209.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 446AC4D6414;
	Wed, 30 Oct 2013 07:30:23 +0100 (CET)
In-Reply-To: <xmqqzjprd1ge.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 29 Oct 2013 17:52:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236984>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <tr@thomasrast.ch> writes:
>
>> From: Thomas Rast <trast@inf.ethz.ch>
>>
>> The -G option's usage is exactly analogous to that of -S, so
>> supporting it is easy.
>>
>> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
>> ---
>>  gitk-git/gitk | 2 +-
>
> You CC'ed Paul, which is absolutely the right thing to do, but
> please make patches against his tree, which does not have gitk-git/
> directory at the top-level.

I figured this was easier on potential testers.  As outlined in the
cover letter, I'll do the splitting and rebasing later.

-- 
Thomas Rast
tr@thomasrast.ch
