From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: push fail
Date: Mon, 17 Mar 2014 21:58:06 -0400
Message-ID: <CAH_OBiegRbR6MXx2awuxpOkagLcPG-w4vE0zh78Z+SdUK_7vAg@mail.gmail.com>
References: <CAH_OBie+KrSjtqLinbv8sJAOCu26j8xVzBQJHdHTB44V07GsXg@mail.gmail.com>
 <loom.20140317T142900-203@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Dragos Foianu <dragos.foianu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 02:59:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPjIz-00077d-1b
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 02:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbaCRB62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 21:58:28 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:58396 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbaCRB61 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 21:58:27 -0400
Received: by mail-ve0-f172.google.com with SMTP id jx11so6427365veb.3
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 18:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Iob2WYq1VwHc752OEbCFu3QxZczfWH2yNbUS5A6Xw80=;
        b=slnsYljdC91LA/DByVlSiw9AZtgFWByx4w7k15LIdsEB89QOPiwnivom0JQwfKk1oF
         MWoAK1WgQk0kgsBDAR2Pu0WUaKZrzamiqRT7ZM2qyYYlc++Cwfo8W/v4uEwS9dZ22Y2O
         eb9Xpve4U0QpbtYVAE0N+5yqbkBjjXBwC+/VnWLFAAC9UYdyQkma7J1xk6xss8QMFJEa
         mqyRETDB8isXaQf+T+cvkcS6Y8L+osJr920LVjz+0PvYIdh0CmUxQavpsxX7rKr6hdza
         PhXZoNAVr6G9AJKc78i31AgWoE/SfRY3anlr3sBioyJL/BFyFgw9CoKjgbmy2TLXPhk9
         Gs7g==
X-Received: by 10.58.162.168 with SMTP id yb8mr1833074veb.9.1395107906845;
 Mon, 17 Mar 2014 18:58:26 -0700 (PDT)
Received: by 10.52.227.233 with HTTP; Mon, 17 Mar 2014 18:58:06 -0700 (PDT)
In-Reply-To: <loom.20140317T142900-203@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244319>

Thanks.

Yeah, I should've thought to do a pull....

On Mon, Mar 17, 2014 at 9:34 AM, Dragos Foianu <dragos.foianu@gmail.com> wrote:
> shawn wilson <ag4ve.us <at> gmail.com> writes:
>
>>
>> How do I get more info here (and hopefully resolve this)?
>>
>>  % git push
>> To ssh://server/foo/repo.git
>>  ! [rejected]        test -> test (non-fast-forward)
>> error: failed to push some refs to 'ssh://server/foo/repo.git'
>>
>
> "non-fast-forward" means that someone else pushed to branch test before you
> did and your push would end up overwriting their changes. Make sure you
> merge your local branch with the remote branch:
>
> git pull origin test
>
> It might also be a result of local destructive changes made by "git rebase".
> If you're absolutely certain you will not mess up the remote branch you can
> add the "--force" parameter when you push.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
