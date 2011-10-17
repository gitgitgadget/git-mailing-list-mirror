From: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: add the ability to show side-by-side diff on commitdiff.
Date: Mon, 17 Oct 2011 10:15:07 +0900
Message-ID: <CAFo4x0+_Uy=yjbO61qj8krS0-iovzC5WnBE8-1n5OzxgGeg6JA@mail.gmail.com>
References: <CAFo4x0Kb651CyxoP8wxR36aDe5=Md2UV3qjh+HPo4ad6NB=Emg@mail.gmail.com>
 <7vobxgpixo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 03:16:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFboD-0003O8-4q
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 03:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553Ab1JQBPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 21:15:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43242 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab1JQBP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 21:15:28 -0400
Received: by bkbzt19 with SMTP id zt19so3031152bkb.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 18:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dK3l7KvAHMtJCG0eHb8WtlYQg33JBi0SJ0/suWQqGNk=;
        b=WxIfUTWq4U7CFQEYseiMXa6KwfxWNLEea8ZLOxOLaF6cDNdrqjURaEs679hMg5aMTn
         CIyX/dMOwaVS2OH4YGkEF+25WmuCtCrDfOZEEXZDOA/Su+XqaH/PHyt29k/lI37aOuxz
         IuX7+2qVxSNPZsBCZ7GB2w+t9pg+azt/v3NCc=
Received: by 10.204.15.194 with SMTP id l2mr12529323bka.83.1318814127179; Sun,
 16 Oct 2011 18:15:27 -0700 (PDT)
Received: by 10.204.36.132 with HTTP; Sun, 16 Oct 2011 18:15:07 -0700 (PDT)
In-Reply-To: <7vobxgpixo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183747>

On Mon, Oct 17, 2011 at 9:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> What are these changes for, except perhaps to make the patch larger than
> necesssary to make it harder to review?
>
> It would leave an unnecessary SP like 'class="diff "' when all the arms of
> if/elsif cascade fall off and $diff_class is left empty. It isn't a major
> issue (I suspect that such a case might even be an error), and I even
> think the code after the above patch would be easier to read and more
> sensible, but shouldn't that kind of "style fix" be in a separate clean-up
> patch that does not introduce any new feature?
>

Sorry. I will separate my patch into two or three commits. Probably like:

- format_diff_line returns a class with an line.
- remove trailing space from the class.
- add side-by-side feature and CSS.
- add form.

Thank you for your correction!

-- 
Kato Kazuyoshi
