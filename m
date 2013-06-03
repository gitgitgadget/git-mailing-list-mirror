From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #01; Sun, 2)
Date: Mon, 3 Jun 2013 08:35:35 +0800
Message-ID: <CANYiYbHkw1hQpscFFEyx8za9bniHtBriKb=C1CFSpjKntshVHQ@mail.gmail.com>
References: <7vfvx0kqtn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 02:35:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjIkP-0005mP-V8
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 02:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423Ab3FCAfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 20:35:38 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:50578 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730Ab3FCAfh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 20:35:37 -0400
Received: by mail-wi0-f175.google.com with SMTP id hn14so2178146wib.8
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 17:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2H9rHMabbGnXJNylPsk4m0tZDzyrOfOxOtjdcEuTGKw=;
        b=OP90B5qTVSvRkxTRY50tnUUpAptL3nvNr/nFZPDcuRsx8SXaP0dZ3EkJua5dWuMf/h
         N92HmUL69NcmiGi/Mbyo01zpyp+tmxSI3tvcJUG+4W6T9bzM2An1iGLQIiZuOOdtDnhp
         JqkvVjroagGQHgTc9Ks1lTJ+8UAXVz99oNV4oJTNH5PPaRHhrJZ2Kg7cghkj7Wq7Kk5p
         noK5QuExCOxY2VOTsA44TwKWPM1HhE/QeHm3gRF2vv8J2rpxX9I+J/Do17IdN5lMAc9F
         lyQBJ51DXGcNd0pbYUVPt9cmkdLbmRWWGgSP78zRAZgfiPPq5/zRuo2ZZkR/0RNzZl7N
         lWSQ==
X-Received: by 10.194.59.72 with SMTP id x8mr16754643wjq.49.1370219735905;
 Sun, 02 Jun 2013 17:35:35 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Sun, 2 Jun 2013 17:35:35 -0700 (PDT)
In-Reply-To: <7vfvx0kqtn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226201>

2013/6/3 Junio C Hamano <gitster@pobox.com>:
>
> * jx/clean-interactive (2013-05-22) 15 commits
>  - test: add t7301 for git-clean--interactive
>  - git-clean: add documentation for interactive git-clean
>  - git-clean: add ask each interactive action
>  - git-clean: add select by numbers interactive action
>  - git-clean: add filter by pattern interactive action
>  - git-clean: use a git-add-interactive compatible UI
>  - git-clean: add colors to interactive git-clean
>  - git-clean: show items of del_list in columns
>  - git-clean: add support for -i/--interactive
>  - git-clean: refactor git-clean into two phases
>  - Refactor write_name_quoted_relative, remove unused params
>  - Refactor quote_path_relative, remove unused params
>  - quote.c: remove path_relative, use relative_path instead
>  - path.c: refactor relative_path(), not only strip prefix
>  - test: add test cases for relative_path
>
>  Still under discussion, e.g. $gmane/225139.
>

I have updated the patch in the new reply for this thread, and it need
some feedbacks:

http://thread.gmane.org/gmane.comp.version-control.git/225139/focus=225934


-- 
Jiang Xin
