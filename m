From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 20:14:14 -0700
Message-ID: <20130416031414.GK3262@elie.Belkin>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com>
 <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr>
 <CALkWK0nqrw7DFQSnMvULYjJtBHRnadKWqCLQOAjzJH0o7USo+A@mail.gmail.com>
 <vpqwqs3lqlf.fsf@grenoble-inp.fr>
 <CALkWK0nrVZo3MSgqpPmX2+T3JJ8uP=hzH3PMv+qd4ZaqNVwEsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 05:14:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URwLh-0002GK-Vv
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 05:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849Ab3DPDOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 23:14:21 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34361 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964788Ab3DPDOU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 23:14:20 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so86450pab.38
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 20:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=I1Xjp1fY7CFVqCgQxaXNivGLypmgbSrwI5no56drCS0=;
        b=WF9/Q19nL02bRLWn/UKZoAGMV4q2x1ZZKlAyIAIbQ6cCwNrBJjRieJ31/zX12LVxVt
         DQH9PkffGn4xn9Xl+sMnvRMRPdg9qYVhX3xlEfL+S+fkK/Z7SltNxcoEheUWVm+yjjUy
         7pXVKIeCEzZILl+vDXvo3BTgKKTa1foWOIOgZPyBCL8S8o3R8PqtldoiYSCkAIjYTGxO
         u39r/aD20a0srDGYGXquIab+5NvaKW6GanYDhwDyTGNuW/24awgEa6bCHvF1oMuWdwBM
         FU3jSx1auII9EyXYqdhtvFzCa9G8lEw2Zg/WXYrBgwWz3hoFIQBLlW8T53SEti2X4qQy
         Ne7A==
X-Received: by 10.66.183.33 with SMTP id ej1mr1165156pac.8.1366082059056;
        Mon, 15 Apr 2013 20:14:19 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id b3sm163626pbw.4.2013.04.15.20.14.16
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 20:14:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nrVZo3MSgqpPmX2+T3JJ8uP=hzH3PMv+qd4ZaqNVwEsw@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221353>

Ramkumar Ramachandra wrote:
> Matthieu Moy wrote:

>> No, you don't. Just try if you're not convinced:
>
> Oh, I trusted the documentation on this one and never tried with a
> dirty worktree myself.  Please fix the documentation, if you know how
> exactly to correct it.

The manual says:

	"git pull" and "git merge" will stop without doing anything when
	local uncommitted changes overlap with files that git pull/git
	merge may need to update.

That accurately describes the behavior.

I wouldn't be surprised if there's still a documentation bug, though:
a lack of clarity, a missing hint somewhere else, something else
misleading.  That seems especially likely when you say "I trusted the
documentation on this one".  Care to point to the appropriate section,
so it can be fixed?

Thanks,
Jonathan
