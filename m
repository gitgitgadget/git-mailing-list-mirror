From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Recording cherry-picked commits
Date: Sat, 22 Mar 2008 17:37:10 -0700
Message-ID: <7veja2gts9.fsf@gitster.siamese.dyndns.org>
References: <ae63f8b50803210533n12645fb3w9a8be601c4cc394@mail.gmail.com>
 <ae63f8b50803220937k78571fbdl1eeb60966ec7aa40@mail.gmail.com>
 <b77c1dce0803221548x3250cb90taa9a9d53464f7ea7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jean-Baptiste Quenot" <jbq@caraldi.com>, git@vger.kernel.org
To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 01:38:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdEDp-0000NV-Tf
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 01:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbYCWAhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 20:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754342AbYCWAhV
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 20:37:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234AbYCWAhU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 20:37:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 18A8C2F7E;
	Sat, 22 Mar 2008 20:37:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 817A12F7D; Sat, 22 Mar 2008 20:37:12 -0400 (EDT)
In-Reply-To: <b77c1dce0803221548x3250cb90taa9a9d53464f7ea7@mail.gmail.com>
 (Rafael Garcia-Suarez's message of "Sat, 22 Mar 2008 23:48:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77859>

"Rafael Garcia-Suarez" <rgarciasuarez@gmail.com> writes:

> Here's an alternate idea: store the original sha1 in the commit
> message, via a custom header (something like X-Cherry-Picked-From) at
> least in case of conflict, and have git-cherry recognize it.
>
> (I have the same problem as you, by the way, and would really like to
> see it solved one way or another.)

"-x"?
