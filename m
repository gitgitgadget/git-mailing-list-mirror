From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] checkout: implement "-" shortcut name for last branch
Date: Thu, 15 Jan 2009 12:12:02 -0800
Message-ID: <7vhc40s50t.fsf@gitster.siamese.dyndns.org>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>
 <496EE559.3060901@viscovery.net>
 <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de>
 <200901151500.01876.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901151517190.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 21:13:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNYau-0006ar-O7
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 21:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828AbZAOUMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 15:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932789AbZAOUMM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 15:12:12 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932749AbZAOUMK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 15:12:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AB81D906FD;
	Thu, 15 Jan 2009 15:12:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AE49D906FB; Thu,
 15 Jan 2009 15:12:04 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C9F88974-E340-11DD-8F3E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105872>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 15 Jan 2009, Johannes Schindelin wrote:
>
>> [PATCH] pack-objects --all: include HEAD, which could be detached
>
> In hind sight, it would probably be better to add this to revision.c.

If you mean that "git log --all" should also include a possibly detached
HEAD in its traversal, and a patch that implements such a fix would
automatically fix "repack -a" without the patch you are responding to, I
think I agree 100%.
