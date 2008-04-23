From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow cherry-pick (and revert) to add signoff line
Date: Tue, 22 Apr 2008 22:08:07 -0700
Message-ID: <7vabjlupjc.fsf@gitster.siamese.dyndns.org>
References: <1208714585-4053-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 07:09:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoXEA-0002mJ-HX
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 07:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbYDWFIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 01:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbYDWFIU
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 01:08:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33160 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbYDWFIU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 01:08:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 820331958;
	Wed, 23 Apr 2008 01:08:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 975571954; Wed, 23 Apr 2008 01:08:14 -0400 (EDT)
In-Reply-To: <1208714585-4053-1-git-send-email-dpmcgee@gmail.com> (Dan
 McGee's message of "Sun, 20 Apr 2008 13:03:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80186>

Dan McGee <dpmcgee@gmail.com> writes:

> I often find myself pulling patches off of other peoples trees using
> cherry-pick, and following it with an immediate 'git commit --amend -s'
> command. Eliminate the need for a double commit by allowing signoff on a
> cherry-pick or revert.
>
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> ---
>
> This is something I have done in my workflow for a long time, and it seems
> like a weird omission to me. Signoffs can be done on git-am without having
> a second commit, and I often have a workflow where I am picking patches from
> other users' topic branches and have reviewed the patch and would like to
> signoff when I pull it into my tree.

Yeah, when your workflow is heavily rely on cherry-picking, I can see how
this would be handy.

I see there was some improvement suggestion suggested on the list, so I
will wait until the dust settles and I see an appliable final submission.

Thanks.
