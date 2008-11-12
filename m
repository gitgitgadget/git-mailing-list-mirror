From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 12 Nov 2008 15:42:00 -0800
Message-ID: <7vk5b8ldfb.fsf@gitster.siamese.dyndns.org>
References: <20081102123519.GA21251@atjola.homenet>
 <32541b130811102004n54a47331v48ba8d299039897f@mail.gmail.com>
 <20081112083353.GB3817@coredump.intra.peff.net>
 <alpine.DEB.1.00.0811121205100.30769@pacific.mpi-cbg.de>
 <20081112110629.GA20473@coredump.intra.peff.net>
 <32541b130811120739t95455d8n9b8056a8033491c3@mail.gmail.com>
 <20081112191512.GA21401@coredump.intra.peff.net>
 <7vljvooi8w.fsf@gitster.siamese.dyndns.org>
 <20081112193747.GA21567@coredump.intra.peff.net>
 <7vbpwkogxq.fsf@gitster.siamese.dyndns.org>
 <32541b130811121439tbfc54aeq2999dbebf149d5bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Bj=C3=B6r?= =?utf-8?Q?n_Steinbrink?= 
	<B.Steinbrink@gmx.de>, "David Symonds" <dsymonds@gmail.com>,
	git@vger.kernel.org, "Stephan Beyer" <s-beyer@gmx.net>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 00:44:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0PNw-0005TR-Oj
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 00:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757133AbYKLXmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 18:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754818AbYKLXmw
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 18:42:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035AbYKLXmv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 18:42:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DFE2B7CAC6;
	Wed, 12 Nov 2008 18:42:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B90527CABA; Wed,
 12 Nov 2008 18:42:07 -0500 (EST)
In-Reply-To: <32541b130811121439tbfc54aeq2999dbebf149d5bc@mail.gmail.com>
 (Avery Pennarun's message of "Wed, 12 Nov 2008 17:39:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9DAF8EF8-B113-11DD-9745-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100834>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> I assume the reason is that "git diff tree1..tree2" works with the
> differences between tree1 and tree2, much like "git log tree1..tree2"
> does.

Actually, that perception is already confused.  The analogue to "log A..B"
is expressed as "diff A...B", and not "diff A..B".

That is one of the reasons why I tend to teach against using "diff A..B"
unless you know what it is doing. I'd suggest to get out of that habit
before you confuse yourself even more ;-).

The _only_ reason diff takes A..B and A...B syntax is because the command
line parameter parser was easy to write that way.  IOW, it was an artifact
of the implementation convenience.
