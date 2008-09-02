From: Junio C Hamano <gitster@pobox.com>
Subject: Re: non-monotonic index error
Date: Tue, 02 Sep 2008 13:53:12 -0700
Message-ID: <7vbpz6jmmf.fsf@gitster.siamese.dyndns.org>
References: <9e4733910809021257v3012ec89l64b2bb412ac1ebbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 22:54:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KactO-0003ir-Ag
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 22:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbYIBUxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 16:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbYIBUxT
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 16:53:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbYIBUxT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 16:53:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2EF425ABEE;
	Tue,  2 Sep 2008 16:53:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 946E15ABED; Tue,  2 Sep 2008 16:53:14 -0400 (EDT)
In-Reply-To: <9e4733910809021257v3012ec89l64b2bb412ac1ebbd@mail.gmail.com>
 (Jon Smirl's message of "Tue, 2 Sep 2008 15:57:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2B89D348-7931-11DD-A5E3-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94712>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> I pulled from linus, did stg rebase linus/master, git push digispeaker
> and got these errors.
>
> Where's the problem, at my local machine or the digispeaker one? How
> do I fix this?
>
> jonsmirl@terra:~/fs$ stg --version
> Stacked GIT 0.14.3.195.g36a0
> git version 1.5.6.GIT
> Python version 2.5.2 (r252:60911, Jul 31 2008, 17:31:22)
> [GCC 4.2.3 (Ubuntu 4.2.3-2ubuntu7)]
> jonsmirl@terra:~/fs$
>
> [digispeaker]$ git --version
> git version 1.4.4.4

It is a bit fishy that stg reports 1.5.6.GIT; does it come with its own
copy of git which is newer than what you have?
