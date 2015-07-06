From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Draft of Git Rev News edition 5
Date: Mon, 06 Jul 2015 09:38:20 -0700
Message-ID: <xmqqa8v92qdf.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
	<20150705191101.GB9815@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <npaolucci@atlassian.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 18:38:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC9Pp-00007P-0P
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 18:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbbGFQid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 12:38:33 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33959 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696AbbGFQiX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 12:38:23 -0400
Received: by igcsj18 with SMTP id sj18so239005380igc.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+uW+yoW36PwigK32xBuTjyiTbZauaOO7MbqXArUjEg8=;
        b=LmQd/MeEr1tUuBdYTRuRNyVdCyOrHjO6+pNTn8Nlutq+IZeL+fCaMwHL5adWWc/0Jx
         WveI3kQsFHdW2cja0C6m8veP/owSpn0NT9FzwVBmYIRgQVD+N5vWWUoBVFnKX6YHx+cY
         kJ1hcznDGP+inOCNU5s9bDr+cyNu69kAR6R1OQcIGAff/N5LwQyqu26+cccdcfDf6hj9
         yt6AVewjZAiPv8cAvEIiHXYcFKJwo8OKsezT6odqe1uP1dNcTC9rgjr27qzT0XW1hCiA
         b2FsntpFTakLpmoJJFddTIZndun6tq6/HiJ9p7oJzj4IrU5Bti60GPi6nYc9Qop+sTM6
         4tPQ==
X-Received: by 10.107.137.41 with SMTP id l41mr62741535iod.60.1436200702348;
        Mon, 06 Jul 2015 09:38:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id v40sm3462157ioi.37.2015.07.06.09.38.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 09:38:21 -0700 (PDT)
In-Reply-To: <20150705191101.GB9815@flurp.local> (Eric Sunshine's message of
	"Sun, 5 Jul 2015 15:11:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273402>

Eric Sunshine <sunshine@sunshineco.com> writes:

> I'm not familiar with the criteria for deciding what merits mention
> in the newsletter. Is the recent introduction of git-worktree and the
> attendant relocation of "add" and "prune" functionality worthy? If
> so, perhaps the following write-up would be suitable?

One issue I had with this text was that it was not immediately clear
what the end-game UI of the feature was.  Is "checkout --to" they
way the user is expected to trigger this?  It appears in the very
early part of the multi-paragraph description and I suspect that the
majority of the users would think that way, not with "worktree add"
that appears a lot later.
