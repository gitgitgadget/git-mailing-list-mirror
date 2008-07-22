From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Computing the number of patches in linux-next tree
Date: Tue, 22 Jul 2008 10:04:52 -0700
Message-ID: <7vabg9n93f.fsf@gitster.siamese.dyndns.org>
References: <12c511ca0807220919q4db6ee1fr33dc70fe35c58efe@mail.gmail.com>
 <alpine.DEB.1.00.0807221727210.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tony Luck <tony.luck@intel.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 19:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLLJI-0008On-J2
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 19:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbYGVRFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 13:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbYGVRFA
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 13:05:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYGVRE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 13:04:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 529BF4081D;
	Tue, 22 Jul 2008 13:04:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id ADDFF4081A; Tue, 22 Jul 2008 13:04:54 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807221727210.8986@racer> (Johannes
 Schindelin's message of "Tue, 22 Jul 2008 17:28:17 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 50708F68-5810-11DD-BD06-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89502>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 22 Jul 2008, Tony Luck wrote:
>
>> git tag | grep next- | sort | while read tag
>
> This should not be necessary... AFAICT "git tag" sorts its output already.
>
>> What does the "git-where-did-this-tag-branch-from-linus" command look like?
>
> git merge-base --all <branch1> <branch2>
>
> Be warned: there might be multiple merge bases.

I do not think that approach applies to linux-next, which is constantly
rewound to the then-tip-of-linus and merge remaining bits.  The question
is "where does this branch begin", which does not have an answer in git.
