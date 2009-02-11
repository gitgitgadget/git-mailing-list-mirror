From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make 'remote show' distinguish between merged and
 rebased remote branches
Date: Wed, 11 Feb 2009 09:35:13 -0800
Message-ID: <7vab8sg9m6.fsf@gitster.siamese.dyndns.org>
References: <20090210202046.8EBEC3360AC@rincewind>
 <7v3aemm1po.fsf@gitster.siamese.dyndns.org> <4991FA18.1040200@xiplink.com>
 <76718490902101513i504e515ocb4a2d789ba520f0@mail.gmail.com>
 <499303E8.6030000@xiplink.com> <499306F7.8050404@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 18:36:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJ10-0003yM-T2
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 18:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbZBKRfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 12:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754785AbZBKRfY
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 12:35:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378AbZBKRfX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 12:35:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 699222AE9E;
	Wed, 11 Feb 2009 12:35:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 638DD2AE7F; Wed,
 11 Feb 2009 12:35:15 -0500 (EST)
In-Reply-To: <499306F7.8050404@viscovery.net> (Johannes Sixt's message of
 "Wed, 11 Feb 2009 18:12:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5BF3A792-F862-11DD-A147-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109453>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Marc Branchaud schrieb:
>> Jay Soffian wrote:
>>> * remote origin
>>>   URL: git://git.kernel.org/pub/scm/git/git.git
>>>   Remote branches:
>>>     html      Not tracked
>>>     maint     Tracked
>>>     man       Tracked
>>>     master    Tracked
>>>     next      Tracked
>>>     pu        Tracked
>>>     todo      Not tracked
>>>     old-next  Stale (would prune)
>>>   Local branches configured to pull from this remote:
>>>     master           upstream is master (merges)
>>>     wip/remote-HEAD  upstream is next   (rebases)
>
> I find this form more useful than the one below because of the clear
> separation into remote an local branchs.

Good point.
