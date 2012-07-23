From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [PATCH] Solve git-submodule issues with detached work trees
Date: Mon, 23 Jul 2012 20:25:21 +0200
Message-ID: <CAD77+gSa7FJuQSBRC02CqEPakbc9cNJDRWxCrYX8ZjB0wL_Syw@mail.gmail.com>
References: <CAHCkQtNfz8Kbn810LgXEQ_rkyk4qn5amGgHQsv2uR6H38sTSrg@mail.gmail.com>
 <7vsjcjnjvj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:25:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNKF-00067r-UN
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580Ab2GWSZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:25:43 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38853 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab2GWSZm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:25:42 -0400
Received: by vbbff1 with SMTP id ff1so4975934vbb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Q3uxOB953zkRP+Y2vZJdqI26+VyLO6HDQ5sY9dOTUDs=;
        b=VFmgqlsJVrLONg9zFaC3uGbl45LTBXrMDj8522dVqL7hXa5Y10bz4Hb+SbKo4MYz30
         +aIFiiC+4e0IDeTAQR6+6pVxQLg2pqaYw5DHrBalg8UwWwldwGX+VqcUVmuVbCt5qMEC
         Q7GAE7wD2ZuqymEPAN0QmdBNLzDfFZIWHrhZnJL9vzVyZ9rrg97ZjXbSxp1nwypBdcob
         1GJiUp3LS7XvcOVzGmDjMcXr7kLI7VtX1Ek9rE1Cuxt9Gilmcnc80faXir5CwWZPoEIw
         eur1XWdDCtaPfnaKwyTFN7d1RUAU/kwG9ztWoIRulzHSSScydS12LCsbBMabT7clbIED
         /1Fg==
Received: by 10.52.35.233 with SMTP id l9mr11645181vdj.7.1343067941894; Mon,
 23 Jul 2012 11:25:41 -0700 (PDT)
Received: by 10.220.152.18 with HTTP; Mon, 23 Jul 2012 11:25:21 -0700 (PDT)
In-Reply-To: <7vsjcjnjvj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201949>

On Mon, Jul 23, 2012 at 7:09 AM, Junio C Hamano <gitster@pobox.com> wrote:

> I think this is in line with what we discussed earlier on list when
> the interaction between GIT_DIR/GIT_WORK_TREE and submodules came up
> the last time.  Jens?

Yes, it is.

I still have your email marked as TODO to get back to you as I am
still unsure how to solve this whole mess in a way that works with
vcsh[1].


Richard

PS: Thanks for being so dedicated you all. I really do appreciate this
more than you most likely suspect.

[1] vcsh
