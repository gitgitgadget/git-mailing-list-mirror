From: Elijah Newren <newren@gmail.com>
Subject: Re: Thoughts on gitk's memory footprint over linux-2.6.git
Date: Mon, 26 Sep 2011 16:02:05 -0600
Message-ID: <CABPp-BHo5qKQVFRzFpoyt6dZZ3=UqVAtSjVy0uRDWnA+ASsBPw@mail.gmail.com>
References: <CACPiFC+T1EZ1CSakQxsYZhsnHc-ZsN1-=tpoi-NaQSdpU5Yxkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 00:02:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8JFd-00026j-L6
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 00:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab1IZWCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 18:02:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48659 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab1IZWCH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 18:02:07 -0400
Received: by fxe4 with SMTP id 4so6500856fxe.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jkmJK2qgLLuM1AL2BqyCg7t17/QRLHexYtDXQqXBWps=;
        b=ty22VpfFvgYHPE0HuSt9EVngWgA/YUs5uuaNvICYC7qrQZ95RCfWZiEDAVRqrjFeOJ
         sDyxE1NwBMEqee6QCxROQpJX+PAo5Ly9dfpbxecb1KgPL7qoCxU9Wto+zdYvBbjTt4DW
         t918j9HYasMIaEkQqdpkAGlLAmQiVxVh/J97c=
Received: by 10.223.23.197 with SMTP id s5mr3025990fab.22.1317074525491; Mon,
 26 Sep 2011 15:02:05 -0700 (PDT)
Received: by 10.223.58.131 with HTTP; Mon, 26 Sep 2011 15:02:05 -0700 (PDT)
In-Reply-To: <CACPiFC+T1EZ1CSakQxsYZhsnHc-ZsN1-=tpoi-NaQSdpU5Yxkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182174>

On Mon, Sep 26, 2011 at 1:38 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> In an odd turn of affairs, I am managing a bit of kernel development,
> and even writing the odd patch myself. As usual, gitk is excellent to
> visualize what's new in the tree when developers in the team commit
> and push new stuff.
>
> However, I find it extremely annoying over the kernel tree, due to its
> memory footprint. It is not the only thing I am running, (Chrome
> Browser, Gnome3, Firefox, many gnome Terminal windows, emacs), and
> given that I am looking at "just a couple of commits" I don't feel
> opening a few gitk instances should be problematic... except that it
> is.

If you only want to look at a couple commits, you could tell gitk that:
  gitk -N
where N is some small integer -- or even 10000, as you suggest.  Or
use other rev-list arguments, such as
  gitk v2.6.38..master

gitk and 'git log' accept basically the same arguments, so look at the
help for git log if you want to find other example ways to slice and
dice what pieces of history to view.


Hope that helps,
Elijah
