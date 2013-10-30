From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v2 6/7] Documentation: put blame/log -L in sticked form
Date: Wed, 30 Oct 2013 07:29:13 +0100
Message-ID: <87bo27i85i.fsf@linux-k42r.v.cablecom.net>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
	<c41aef218951f8b0ec6a20e1dbc39712ad13afce.1383031141.git.tr@thomasrast.ch>
	<xmqqvc0fd0la.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 07:29:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbPHW-0000JO-Rd
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 07:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966Ab3J3G30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 02:29:26 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:58509 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab3J3G3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 02:29:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id E7B884D6516;
	Wed, 30 Oct 2013 07:29:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5PsGpby1WDvq; Wed, 30 Oct 2013 07:29:13 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (vpn-global-dhcp2-62.ethz.ch [129.132.209.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id A4EC84D6414;
	Wed, 30 Oct 2013 07:29:13 +0100 (CET)
In-Reply-To: <xmqqvc0fd0la.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 29 Oct 2013 18:11:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236983>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <tr@thomasrast.ch> writes:
>
>> The next patch will document gitk -L, but gitk does not understand the
>> separated form ('gitk -L :foo:bar' results in an error).  Spell
>> git-blame and git-log -L, which are supposed to be "the same" option,
>> without the spaces to prevent confusion.
>
> I agree that this patch may reduce confusion locally, but if we were
> to go in this direction, we should be consistent and enforce "stuck"
> form everywhere, not just the options you happened to have passed
> thru to gitk, but other options such as "-S <revs-file>", and also
> other commands that do not have anything to do with gitk (e.g. "git
> commit -C<commit>", not "git commit -C <commit>".  Otherwise you
> will give a wrong impression to readers as if they have to remember
> which ones need to use the stuck form and which ones do not.

Hmm.  Do you want to go there?

(I can do it, but it'll obviously touch a lot of documentation.)

-- 
Thomas Rast
tr@thomasrast.ch
