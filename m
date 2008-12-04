From: Junio C Hamano <gitster@pobox.com>
Subject: Re: more merge strategies : feature request
Date: Wed, 03 Dec 2008 18:15:06 -0800
Message-ID: <7vabbc7kk5.fsf@gitster.siamese.dyndns.org>
References: <ee2a733e0812021707i82049eai866035aef3386264@mail.gmail.com>
 <81bfc67a0811290848m6cb219c0y71a7266001096f2d@mail.gmail.com>
 <4933AC03.6050300@op5.se>
 <ee2a733e0812011849l1b319c96u9abbb4e8dd4f53ce@mail.gmail.com>
 <81bfc67a0812020546o79906a20jcd04bd42d18dd803@mail.gmail.com>
 <20081204062717.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Leo Razoumov" <slonik.az@gmail.com>,
	"Caleb Cushing" <xenoterracide@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 03:16:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L83ld-0005eh-LC
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 03:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbYLDCPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 21:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756535AbYLDCPT
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 21:15:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756131AbYLDCPN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 21:15:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F1D1384807;
	Wed,  3 Dec 2008 21:15:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E2E5784806; Wed,
  3 Dec 2008 21:15:07 -0500 (EST)
In-Reply-To: <20081204062717.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu, 04 Dec 2008 06:27:17 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 620F3BF4-C1A9-11DD-86B9-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102321>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Isn't what Caleb wants "-X ours/theirs" per-hunk option for merge strategy backends?
>
> It was discussed several months ago on the list and was rejected.  For details you can start here:
>
>     http://thread.gmane.org/gmane.comp.version-control.git/89010/focus=89021
>
> I still think the patch in the above link was reasonable, but the thread
> was distracted into discussing minor syntactical details of how the
> option gets passed to the backend, and the rest of the discussion to
> decide if it makes sense to add such a feature was unfortunately lost in
> the noise and never concluded.

I thought http://article.gmane.org/gmane.comp.version-control.git/89033 in
the thread (and your response to it which is 89175) pretty much concluded
the discussion.  Is Caleb adding anything new to the discussion (iow, is
there a convincing new argument why having such a merge is a good idea and
what the workflow looks like that benefits from it)?
