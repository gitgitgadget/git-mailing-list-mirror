From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Sun, 06 Jul 2008 13:04:18 -0700
Message-ID: <7vprpqdbjx.fsf@gitster.siamese.dyndns.org>
References: <20080620082034.GA24913@elte.hu>
 <m3d4mcmq20.fsf@localhost.localdomain>
 <37fcd2780807060916h7d8c4e6mba7f30570d527dc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>, "Ingo Molnar" <mingo@elte.hu>,
	git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 22:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFaUM-0008GE-06
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 22:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbYGFUEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 16:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbYGFUEj
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 16:04:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbYGFUEj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 16:04:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E9551ECBA;
	Sun,  6 Jul 2008 16:04:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AF28A1ECB9; Sun,  6 Jul 2008 16:04:25 -0400 (EDT)
In-Reply-To: <37fcd2780807060916h7d8c4e6mba7f30570d527dc3@mail.gmail.com>
 (Dmitry Potapov's message of "Sun, 6 Jul 2008 20:16:31 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BFB41010-4B96-11DD-906C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87549>

"Dmitry Potapov" <dpotapov@gmail.com> writes:

> On Fri, Jun 20, 2008 at 2:05 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> There is shortcut for rev^..rev, namely rev^! (I'm not sure if it is
>> documented anywhere, though),
>
> The latter is not exactly a shortcut for the former.  You can try it at any
> merge commit, and you will see different log. For instance, in Git repo:
> ...
> So, I believe, rev^! means --first-parent rev^..rev

Not quite.  From Documentation/git-rev-parse.txt:

    SPECIFYING RANGES
    -----------------

    Two other shorthands for naming a set that is formed by a commit
    and its parent commits exists.  `r1{caret}@` notation means all
    parents of `r1`.  `r1{caret}!` includes commit `r1` but excludes
    its all parents.
