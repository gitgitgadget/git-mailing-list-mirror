From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 22:26:54 -0700
Message-ID: <20130416052654.GA14567@elie.Belkin>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com>
 <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr>
 <CALkWK0nqrw7DFQSnMvULYjJtBHRnadKWqCLQOAjzJH0o7USo+A@mail.gmail.com>
 <vpqwqs3lqlf.fsf@grenoble-inp.fr>
 <CALkWK0nrVZo3MSgqpPmX2+T3JJ8uP=hzH3PMv+qd4ZaqNVwEsw@mail.gmail.com>
 <20130416031414.GK3262@elie.Belkin>
 <CALkWK0=PemnwYkLg5X3YXA5kKE+K5rbbWvS+DR9xpTqAuq+QCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 07:27:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URyQ9-0000qN-VH
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 07:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203Ab3DPF1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 01:27:05 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:47012 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab3DPF1D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 01:27:03 -0400
Received: by mail-pd0-f169.google.com with SMTP id 10so90103pdc.28
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 22:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=PfK8QDLTP8sPmIENg7KkifMiZp+STjyH2EhutLlmH3E=;
        b=drtR9mSES7uJiCCUtQ0PF66XakNu1MsDv+3sMpW05Ecwu5rlw1HvTan84v6lPbXVTB
         8e/JYsCerk0gxcyb4jKNTg0+ou4DmFvCSxOAAIwo/bk65ujbq7QW63xsndW7LuQR7F/P
         mpKLWWn5e2XFlKqvSbcYWL3B3j3RzWgIMSvkpK/KQAHQUG60VfIOt1BopZg3/UJABtZe
         gRSvrzAG0P8iOigprEcQUTbaAbSRKDGOGNqJJX4s1h5Q0xDY+xU2o26Pok3y3tlnN7HV
         Xg0DvYEOijqYEWooiIFmL2B76bmJ0Slf75PMaUyuVkvFF1TdZD7mzYiFEPaDeGpRXjey
         THWw==
X-Received: by 10.68.58.103 with SMTP id p7mr972966pbq.156.1366090022755;
        Mon, 15 Apr 2013 22:27:02 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id dr4sm605432pbb.19.2013.04.15.22.27.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 22:27:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=PemnwYkLg5X3YXA5kKE+K5rbbWvS+DR9xpTqAuq+QCg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221366>

Ramkumar Ramachandra wrote:

> "If there were uncommitted worktree changes present when the merge
> started, git merge --abort will in some cases be unable to reconstruct
> these changes. It is therefore recommended to always commit or stash
> your changes before running git merge."
>
> Matthieu (and probably others) run git merge with a dirty worktree
> most of the time, while I never do (because I read this section).

The above says "in some cases".  It's presumably referring to the
case "One exception is when the changed index entries are in the state
that would result from the merge already" described in the
"PRE-MERGE CHECKS" section.

Improved wording welcome.

Ciao,
Jonathan
