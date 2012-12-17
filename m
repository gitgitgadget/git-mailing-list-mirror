From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/2] Makefile: remove tracking of TCLTK_PATH
Date: Mon, 17 Dec 2012 08:22:41 +0100 (CET)
Message-ID: <20121217.082241.794967023844368825.chriscool@tuxfamily.org>
References: <20121216193850.23461.28099.chriscool@tuxfamily.org>
	<7v4njlpaet.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 17 08:23:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkV2n-0005wg-Ka
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 08:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018Ab2LQHXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 02:23:04 -0500
Received: from [194.158.122.56] ([194.158.122.56]:44674 "EHLO mail-1d.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750768Ab2LQHXD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 02:23:03 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1d.bbox.fr (Postfix) with ESMTP id 2E48EE7;
	Mon, 17 Dec 2012 08:22:42 +0100 (CET)
In-Reply-To: <7v4njlpaet.fsf@alter.siamese.dyndns.org>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211649>

From: Junio C Hamano <gitster@pobox.com>
>
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> It looks like we are tracking the value of TCLTK_PATH in the main
>> Makefile for no good reason, as this is done in git-gui too and the
>> GIT-GUI-VARS is not used in the Makefile.
> 
> This was added to the main Makefile when we slurped gitk to our
> project at the top-level, so I am not surprised if git-gui were
> not depending on it at all.
> 
> A better explanation is that t62ba514 (Move gitk to its own
> subdirectory, 2007-11-17) should have moved these lines to
> gitk-git/Makefile (and I think we should move them there in a
> separate patch).

Yeah, I just sent an updated patch series that does this.

Thanks,
Christian. 
