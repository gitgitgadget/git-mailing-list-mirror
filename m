From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ':/<oneline prefix>' notation doesn't support full file syntax
Date: Thu, 03 Jul 2008 01:34:16 -0700
Message-ID: <7vfxqr2won.fsf@gitster.siamese.dyndns.org>
References: <279b37b20807022242q69ad2fcbwb8c11a9d6165272d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 14:23:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KENq5-0002ud-B3
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087AbYGCMJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752665AbYGCMJ3
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:09:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016AbYGCMJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:09:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7EE5DD012;
	Thu,  3 Jul 2008 04:34:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BDAE5D005; Thu,  3 Jul 2008 04:34:23 -0400 (EDT)
In-Reply-To: <279b37b20807022242q69ad2fcbwb8c11a9d6165272d@mail.gmail.com>
 (Eric Raible's message of "Wed, 2 Jul 2008 22:42:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DA648AF2-48DA-11DD-A175-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87271>

"Eric Raible" <raible@gmail.com> writes:

> % git rev-parse ":/object name":sha1_name.c
> :/object name:sha1_name.c
> fatal: ambiguous argument ':/object name:sha1_name.c': unknown
> revision or path not in the working tree.
> Use '--' to separate paths from revisions
>
> A quick look at int sha1_name.c:get_sha1() shows that it doesn't
> even try to make this work.  Is this worth fixing?

Is there anything to fix?  In that example, you are looking for a commit
that talks about "object name:sha1_name.c" in the comment.
