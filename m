From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/7] test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
Date: Mon, 11 Nov 2013 13:31:58 -0600
Message-ID: <CAMP44s1phHVjiETB3fK3FwjOcJ4+6YYCYt5pvOWJL+RM37QLfw@mail.gmail.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
	<1384142712-2936-4-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 20:32:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfxDQ-0006A9-Lc
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 20:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470Ab3KKTcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 14:32:00 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51911 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132Ab3KKTb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 14:31:59 -0500
Received: by mail-lb0-f174.google.com with SMTP id l4so1343074lbv.33
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 11:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YgbGWkr1Y7CNDX7t3+kJvsdH+RsR0Ulc9GuLZEZaMpI=;
        b=OchuDEClI6EEb2GZ/jWRY3W9UOTJs7gD/t6uy7GmcSldJppAG8rF8XxRr+g6cmzI6f
         ZqH+UXTyLf6kZNnhLO8hla9GQpp9yxmk8GHe8oOhA5HOntIpYHVELhD4mdYK71g4aYOE
         eqd7IwLe2DFK01L4ql33WfHWjYwRTjhGZCIjZSrUCumM4zCUbJ7/dw9wd3WefHaKMxWH
         nu9gva/y1ykg2QyIy6RrN5uGindNmwb/tJMFyh4eRfEBkR0zIL450eAHD0O/dBqcqM/z
         HDvnYhOqO4+UubMtp5Hf6g2+1S1mRVkmB783R4WtB504ctcVb2hANlL70Fv/rvVd7kdY
         67kg==
X-Received: by 10.152.29.38 with SMTP id g6mr6832267lah.25.1384198318367; Mon,
 11 Nov 2013 11:31:58 -0800 (PST)
Received: by 10.114.201.69 with HTTP; Mon, 11 Nov 2013 11:31:58 -0800 (PST)
In-Reply-To: <1384142712-2936-4-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237639>

On Sun, Nov 10, 2013 at 10:05 PM, Richard Hansen <rhansen@bbn.com> wrote:

> @@ -379,7 +382,7 @@ test_expect_success 'export utf-8 authors' '
>         git add content &&
>         git commit -m one &&
>         git remote add bzr "bzr::../bzrrepo" &&
> -       git push bzr
> +       git push -u bzr master
>         ) &&

Actually, why -u? Isn't 'git push bzr master' enough?

-- 
Felipe Contreras
