From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git and GCC
Date: Thu, 06 Dec 2007 13:02:18 -0800
Message-ID: <7vabonczad.fsf@gitster.siamese.dyndns.org>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	<20071205.202047.58135920.davem@davemloft.net>
	<4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
	<20071205.204848.227521641.davem@davemloft.net>
	<4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
	<alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
	<1196968371.18340.30.camel@ld0161-tx32>
	<7vk5nrd1yq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Berlin <dberlin@dberlin.org>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, Git List <git@vger.kernel.org>
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 22:03:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Nrv-0001qm-1J
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 22:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbXLFVC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 16:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbXLFVC3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 16:02:29 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33961 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbXLFVC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 16:02:29 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 85CC92F9;
	Thu,  6 Dec 2007 16:02:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D89ED9D801;
	Thu,  6 Dec 2007 16:02:41 -0500 (EST)
In-Reply-To: <7vk5nrd1yq.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 06 Dec 2007 12:04:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67338>

Junio C Hamano <gitster@pobox.com> writes:

> Jon Loeliger <jdl@freescale.com> writes:
>
>> I'd like to learn more about that.  Can someone point me to
>> either more documentation on it?  In the absence of that,
>> perhaps a pointer to the source code that implements it?
>
> See Documentation/technical/pack-heuristics.txt,

A somewhat funny thing about this is ...

$ git show --stat --summary b116b297
commit b116b297a80b54632256eb89dd22ea2b140de622
Author: Jon Loeliger <jdl@jdl.com>
Date:   Thu Mar 2 19:19:29 2006 -0600

    Added Packing Heursitics IRC writeup.
    
    Signed-off-by: Jon Loeliger <jdl@jdl.com>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

 Documentation/technical/pack-heuristics.txt |  466 +++++++++++++++++++++++++++
 1 files changed, 466 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/pack-heuristics.txt
