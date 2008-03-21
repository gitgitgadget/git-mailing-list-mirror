From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [SoC RFC] git statistics - information about commits
Date: Fri, 21 Mar 2008 02:24:28 -0700
Message-ID: <7vmyospgz7.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0803210152o529f3b4fi15c515f5385d8f88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "alturin marlinon" <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 10:25:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcdVD-0001Hy-CW
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 10:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbYCUJYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 05:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753071AbYCUJYu
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 05:24:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbYCUJYt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 05:24:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 635DD2CBF;
	Fri, 21 Mar 2008 05:24:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9F7632CBE; Fri, 21 Mar 2008 05:24:39 -0400 (EDT)
In-Reply-To: <bd6139dc0803210152o529f3b4fi15c515f5385d8f88@mail.gmail.com>
 (alturin marlinon's message of "Fri, 21 Mar 2008 09:52:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77733>

"alturin marlinon" <alturin@gmail.com> writes:

> My plan for this summer is to create a 'statistics' feature for git.
>
> It would provide the following functionality:
> * Show how many commits a specific user made.
> * Show the (average) size of their changes (in lines for example).
> * Show a 'total diff', that is, take the difference between the source
> with, and without their changes, including its size (with for example
> a -c switch).
> * Show which contributors have contributed to the part of the code
> that a patch modifies.
> * Show what part of the code a maintainer is working on the most.
> * Define an output format for this information that can be used by
> other tools (such as gitk and git-web)
> * (Optional) Integrate all this information with gitk and git-web.

* Within reasonable amount of time suitable for interactive use, if you
  intend it to work with gitk.

What's the ballpack performance goal for e.g. post 2.6.12 kernel history
which is about 85k commits, 3800 authors, 24k files?

* Who contributed the most code that needed the many fix-ups on top?

* Which part of the codebase had the most commits that had "oops, screwed
  up, I am fixing this but this is a tricky code" fixes?
