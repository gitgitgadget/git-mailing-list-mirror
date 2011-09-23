From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's The Right Way to Do This?
Date: Fri, 23 Sep 2011 05:08:40 +0000
Message-ID: <CAMOZ1BtTi7GxwTvPTEtHoV-GspAZKJiLauXfkwBFJk+RZJT_7A@mail.gmail.com>
References: <loom.20110923T064720-366@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 07:09:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6y0j-0007UT-3v
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 07:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab1IWFJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 01:09:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36058 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1IWFJK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 01:09:10 -0400
Received: by mail-iy0-f174.google.com with SMTP id q3so3525178iaq.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 22:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TQtlYgrRfq/5IIIWH85Vk0gt5kDrL0XiaU8qd6JmEvs=;
        b=wCd+kx02mBqaNhfWw2BsLlqhcH+xruEAoNjZksem+7A2qsK0FnsHMnKYw5BVpxGzP6
         439UWBZ7Y8kS8M7r1GHwXz9hDJnt6GRkMVEnoTL/96sn22+DluM8C/QOdK01q1FfJ7mE
         QI3wGt9DmEdyz8GZrBpf5b7oBulcn+WWT4ebA=
Received: by 10.42.156.138 with SMTP id z10mr3612879icw.193.1316754550079;
 Thu, 22 Sep 2011 22:09:10 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Thu, 22 Sep 2011 22:08:40 -0700 (PDT)
In-Reply-To: <loom.20110923T064720-366@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181943>

On Fri, Sep 23, 2011 at 04:48, Jon Forrest <nobozo@gmail.com> wrote:

> ... So, I tried to revert using various methods I found by
> googling "git revert"...
> ...
> ...this experience left me wondering what I should have
> done in the first place.

What you should have done in the first place is RTFM; while
not fantastic, there is a decent amount of official git
documentation.

> What happened was that when I tried to revert back to the
> commit before the one I made, the files I had modified
> *and* the files that apparently were modified by other
> people in #3 above were reverted. This wasn't what
> I wanted. I only wanted to revert the changes I had made.

It would be a good idea to reproduce the unexpected behavior
you are experiencing by means of a minimal set of commands
that you can post here for others to try.

> With the help of someone more experienced than me we were
> able to get things back to normal... There's a chance I'm
> going to have to go through all this again as I try to fix
> the problem with my changes.

Why don't you ask that person about it?
