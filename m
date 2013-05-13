From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] git-prompt.sh: strip unnecessary space in prompt string
Date: Mon, 13 May 2013 13:10:26 +0530
Message-ID: <CALkWK0m0dT-sX=nu5jaDj=y1oOSo0cRKQ=2K_S-yepnsm8ny7A@mail.gmail.com>
References: <1368289513-8700-1-git-send-email-artagnon@gmail.com>
 <1368289513-8700-2-git-send-email-artagnon@gmail.com> <7v61ynsci8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 09:41:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbnNi-0002ni-AZ
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 09:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331Ab3EMHlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 03:41:09 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:65182 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab3EMHlI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 03:41:08 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so2298595bkc.0
        for <git@vger.kernel.org>; Mon, 13 May 2013 00:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DZwVznE359nO2f14BClwQjwI4IOY1fIB+itUqsM7bZ8=;
        b=FGYX5n+Hs2zNTLFKTqF5Q0i0/dzCvNB9XSPD3ntwTp8DLizOAfEitnmk4JMbvQvXxQ
         68MtQM05zoDiAlsMk4riUvr/pL147WVM7qack+41yn1UtwMt0H2vyPklFYrEZIh7U3UJ
         dKGK34cACp8KZZZ2c+dD9vYzPYcOkuqiOJkeAeYM6gk41lLtzDRO7f6U5rdStNPVZ1U2
         KXJoFfjeQZBRp8Lnqu31/ofGLAphIuFuKbDlhA+L9r6VUubwWGIdHOQisB4s1lku3Efc
         AvRPbs3JJw0owMF2ejAvj3EAFxHJ/vsfOlslyZNXSsx5qEeoiIdmGbDqvfO/gGw2JEQD
         uwcA==
X-Received: by 10.205.38.195 with SMTP id tj3mr5160635bkb.67.1368430867165;
 Mon, 13 May 2013 00:41:07 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Mon, 13 May 2013 00:40:26 -0700 (PDT)
In-Reply-To: <7v61ynsci8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224101>

Junio C Hamano wrote:
> It is like asking why typeset a space after a sentence a tad wider
> than a space after each word:

Not at all.  The prompt has nothing to do with sentences.

> grouping related things together, and
> separating groups of different kind apart, to make it more readable.

You could argue that the colors are not very well thought-out
(branch-name has the same color as +), but I really don't see the
problem otherwise.  How is this more readable:

    artagnon|master *=:~/src/git$

than:

    artagnon|master*=:~/src/git$

(where master is green, * is red, and = is white)?

Looking at what we've done so far, I would argue that we're not
thinking about the usability of the prompt enough: it currently
screams I AM DOING REBASE-i! (and similarly for other operations in
progress).  I intend to fix these things in future patches.

Thanks.
