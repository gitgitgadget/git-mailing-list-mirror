From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-bisect annoyances
Date: Thu, 10 Apr 2008 22:56:42 -0700
Message-ID: <7vhce9szmt.fsf@gitster.siamese.dyndns.org>
References: <20080409101428.GA2637@elte.hu> <20080410114739.GA15229@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Apr 11 07:58:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkCH1-0003fk-Hl
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 07:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbYDKF5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 01:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753199AbYDKF5I
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 01:57:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbYDKF5H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 01:57:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 614C62F36;
	Fri, 11 Apr 2008 01:57:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BA1932F35; Fri, 11 Apr 2008 01:57:03 -0400 (EDT)
In-Reply-To: <20080410114739.GA15229@elte.hu> (Ingo Molnar's message of "Thu,
 10 Apr 2008 13:47:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79266>

Ingo Molnar <mingo@elte.hu> writes:

>  dione:~/linux-tmp4> git-bisect start
>  fatal: ref HEAD is not a symbolic ref
>  won't bisect on seeked tree
>
>  #
>  # Hm. It's not a symbolic ref, and git-bisect just wont do it.

Enough people were unhappy with this historical wart and we stopped
refusing to "bisect on seeked tree" since b577bb9 (Eliminate confusing
"won't bisect on seeked tree" failure, 2008-02-23); you should find it as
part of the 1.5.5 release.

The disturbing "fatal: ref HEAD not a symref" is still there even though
it should be harmless.  The message should be squelched.
