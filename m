From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH gitk 0/4] gitk support for git log -L
Date: Sun, 13 Oct 2013 08:31:20 +0200
Message-ID: <87k3hhadhj.fsf@linux-k42r.v.cablecom.net>
References: <cover.1370806329.git.trast@inf.ethz.ch>
	<874nblpamj.fsf@linux-k42r.v.cablecom.net>
	<874nbdnomj.fsf@hexa.v.cablecom.net> <51F6CB7D.1070806@web.de>
	<87siyu98cq.fsf@linux-k42r.v.cablecom.net>
	<20130818115456.GA6772@iris.ozlabs.ibm.com>
	<874namay5p.fsf@linux-k42r.v.cablecom.net>
	<xmqq61v18u5s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 13 08:43:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVFOE-00054R-AI
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 08:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781Ab3JMGmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 02:42:40 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:50531 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab3JMGmj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 02:42:39 -0400
X-Greylist: delayed 665 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Oct 2013 02:42:39 EDT
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 2149C4D6531;
	Sun, 13 Oct 2013 08:31:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mZp66J2XVk21; Sun, 13 Oct 2013 08:31:23 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net.ethz.ch (unknown [213.55.184.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 71E024D64C1;
	Sun, 13 Oct 2013 08:31:22 +0200 (CEST)
In-Reply-To: <xmqq61v18u5s.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 19 Aug 2013 10:30:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236063>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> Whether the option value is a separate argument in argv, or directly
>> stuck to the option.
>>
>> stuck:   gitk -L:foo:main.c
>> unstuck: gitk -L :foo:main.c
>>
>> Existing gitk chokes on 'gitk -S foo', but works with 'git -Sfoo'.
>
> I somehow thought that we encourage the "stuck/sticked" form, to
> reduce things the users need to remember to cope better with options
> with optional value.

I just looked into this again, to get it rolling.

Am I reading you correctly as saying that any support for the unstuck
form is entirely coincidental, and it's okay to support only the stuck
version in new gitk?

Note that the support for 'git log -L' supports both, and it irks me
that the user can't switch back and forth between using 'gitk' and 'git
log' while leaving the rest of the command intact.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
