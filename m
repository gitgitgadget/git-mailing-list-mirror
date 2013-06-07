From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: add deprecated __git_complete_file ()
Date: Fri, 7 Jun 2013 14:31:32 -0500
Message-ID: <CAMP44s0nn_cFNmxy=GXPMYFNy92RbkZyZok7phEHnkc+HHKYfQ@mail.gmail.com>
References: <1370632168-25298-1-git-send-email-artagnon@gmail.com>
	<CAMP44s0_YkZeC_Xrd1XUo=4=yJDy=8wQKYe34uybhXVqi9bd9Q@mail.gmail.com>
	<CALkWK0mvsQC4fbfnd+Kbk6q6qRCQGgGxQ89=D4O1+EKfXgw34A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:31:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul2Nv-0000hh-AB
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756396Ab3FGTbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:31:36 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:61759 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756376Ab3FGTbe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:31:34 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so4611515lbh.35
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=igXehdIJVChKvTuRfVb/rY0lGZcrqi1lf152vqAiAp0=;
        b=SsRAd4SiVBd6ZPbYhTm1RV1wo6KqXIm+Db6DLz+DC6tDuiKAVWplDdmwz+eVfTHvEq
         2F+JdWYl/rlxS6MsKZzsH9K2buUJ1YVfAbeQIm3/C4QmwEW+PeLVeUrWRYNgSyaXj2Xl
         YStKYjODH4Q3zBzP174fRvZfVKs/tnC8j87Z819pM+4JuunsZ9JhIbzMK0sR7lXuIbdw
         DWkG0Cs/wwmg61LpqyOaVBfXCBZYdg4IeQWbl7ei2+rpst4A6NqXVE0/d30nhC3+0wRB
         7jo94GtQiHApeX0wiKPwLdB0dh085dNYXj5Q4b776iVvzqi645lYmSnA0UHX+HNcBMTK
         Rk6Q==
X-Received: by 10.112.52.97 with SMTP id s1mr1891381lbo.8.1370633492102; Fri,
 07 Jun 2013 12:31:32 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Fri, 7 Jun 2013 12:31:32 -0700 (PDT)
In-Reply-To: <CALkWK0mvsQC4fbfnd+Kbk6q6qRCQGgGxQ89=D4O1+EKfXgw34A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226684>

On Fri, Jun 7, 2013 at 2:29 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> This is fine by me, but at some point we need to decide how we should
>> prefix the functions that are supposed to be used by external scripts.
>
> Yeah, I thought __ meant "internal" :/
>
>> Also, maybe we should start adding '# TODO remove in v2.0' so we
>> remember to do that in v2.0.
>
> While at it, let's also clean up the deprecated zsh nonsense in
> git-completion.bash.

And the _git _gitk compatibility wrappers.

-- 
Felipe Contreras
