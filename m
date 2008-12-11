From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3 (edit v2)] gitweb: Cache $parent_commit info in
 git_blame()
Date: Wed, 10 Dec 2008 20:18:12 -0800
Message-ID: <7v8wqnwdiz.fsf@gitster.siamese.dyndns.org>
References: <200812110133.33124.jnareb@gmail.com>
 <506479.53667.qm@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: ltuikov@yahoo.com
X-From: git-owner@vger.kernel.org Thu Dec 11 05:19:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAd1b-0002WW-NL
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 05:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbYLKES0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 23:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbYLKES0
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 23:18:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbYLKES0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 23:18:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C6CB486751;
	Wed, 10 Dec 2008 23:18:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B0FA28674F; Wed,
 10 Dec 2008 23:18:14 -0500 (EST)
In-Reply-To: <506479.53667.qm@web31812.mail.mud.yahoo.com> (Luben Tuikov's
 message of "Wed, 10 Dec 2008 20:08:25 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BDD7305E-C73A-11DD-86F8-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102774>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- On Wed, 12/10/08, Jakub Narebski <jnareb@gmail.com> wrote:
>> Acked-by: Luben Tuikov <ltuikov@yahoo.com>
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>
> I've always seen "Acked-by:" follows "Signed-off-by:".  Junio, has this
> changed?

I think the order is supposed to show the order of things happened.  Jakub
signs off the patch, you Ack, and I see the patch and append my sign-off.

You saw the exact same patch text, said that looked Ok to you, and Jakub
updated the log message to present the change better and signed off the
whole thing again.  You could say that there should be another, original,
sign off by Jakub before your Ack, but I do not think it adds anything of
value.

In any case, the change will be queued to 'pu'.  It is great that it is a
trivial change that gives us great performance boost, and I wish all our
patches are like that ;-).
