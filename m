From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature Request: Branch Annotations
Date: Wed, 08 Oct 2008 16:12:26 -0700
Message-ID: <7vwsgiptph.fsf@gitster.siamese.dyndns.org>
References: <d2115f4f0810080341m27c4ca9bv9b1e9b66704ef3fa@mail.gmail.com>
 <d2115f4f0810080348t62e18b14x1dfe798974332b05@mail.gmail.com>
 <d2115f4f0810080349o30b6bc2labc2745b8d981e0d@mail.gmail.com>
 <48ECB5CB.4010703@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rotem Yaari <vmalloc@gmail.com>, git@vger.kernel.org
To: David Soria Parra <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Thu Oct 09 01:14:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KniET-0005zd-86
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 01:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757110AbYJHXMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 19:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757054AbYJHXMj
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 19:12:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756965AbYJHXMh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 19:12:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DB9096BCF7;
	Wed,  8 Oct 2008 19:12:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 317A06BCF6; Wed,  8 Oct 2008 19:12:27 -0400 (EDT)
In-Reply-To: <48ECB5CB.4010703@gmx.net> (David Soria Parra's message of "Wed,
 08 Oct 2008 15:29:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 97FD95EA-958E-11DD-BD3A-9364E785EAEE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97808>

David Soria Parra <sn_@gmx.net> writes:

>> Any opinions on this?
>
> would be great to have something like that build in git-core like
>
> git branch -i 'Fix bla' ds/fix next
> git branch -i
>  ds/fix (Fix Bla)

Haven't people watched Linus on google tech talk?  Here is an excerpt from
the transcript (http://git.or.cz/gitwiki/LinusTalk200705Transcript):

    ... well actually you shouldn't call it "test", you should basically
    name your branches the way you name your functions, you should call
    them something short and sweet and to the point -- What is that branch
    doing.

IOW, why did you name the branch "ds/fix" and not "ds/fix-bla"?
