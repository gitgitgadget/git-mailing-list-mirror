From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: [PATCH RESEND] Do not override LESS
Date: Sat, 23 Aug 2008 12:21:15 +0200
Message-ID: <8763pshw10.fsf@cup.kalibalik.dk>
References: <1219407912-32085-1-git-send-email-mail@cup.kalibalik.dk>
	<7vvdxs2t03.fsf@gitster.siamese.dyndns.org>
	<87k5e8i18c.fsf@cup.kalibalik.dk>
	<7vtzdc14k5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 12:23:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWqH3-0006r2-3x
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 12:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbYHWKVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 06:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbYHWKVT
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 06:21:19 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:34478 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbYHWKVS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 06:21:18 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id C754014062;
	Sat, 23 Aug 2008 12:21:17 +0200 (CEST)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 980C31405A;
	Sat, 23 Aug 2008 12:21:17 +0200 (CEST)
In-Reply-To: <7vtzdc14k5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 23 Aug 2008 02\:08\:58 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93455>

Junio C Hamano <gitster@pobox.com> writes:

> That's not a solution. Alice and Bob can also change their
> environment to their taste as well. Why punish existing users?

As I said, when you ask for "less", I tend to think it is correct to
get "less". Not "LESS=FSRX less", with a special case if LESS is
already defined.

> If the problem you are trying to solve is that there is no existing
> combination of the environment variables for them to do so, you can
> solve it by introducing a new configuration or environment to
> support such usage and documenting it, can't you?

I was trying to clean up things, not to make them even more confusing.
If backwards compatibility is more important to you, I can understand.


Cheers,
Anders.
