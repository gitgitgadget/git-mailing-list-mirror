From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: push.default=upstream doesn't play nicely with remote.pushdefault/branch.*.pushremote
Date: Tue, 10 Sep 2013 19:38:20 -0500
Message-ID: <CAMP44s0ZnGAhMv0a4HbVkZ6voRzxrXW-4T6Dj=H3Lb3kGFsOHA@mail.gmail.com>
References: <522F1A61.3010805@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ximin Luo <infinity0@gmx.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 02:38:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJYRt-0001l8-TW
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 02:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab3IKAiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 20:38:22 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:48032 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab3IKAiV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 20:38:21 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so6791975lab.20
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 17:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Q40b0oc/poj9QxOVbZvyJJgcCXm1mUIOJyYj665NjJk=;
        b=KlGIpcRVkjMGzSCZWU40ubZTU/JOeaDZPoZxmJqUksp/TCFewIkkBQGLJtRzn2eLR2
         eEn+eyptHgV0ffo+IXOfg146dE6cjfzwm4XA/2sxo+J2b+N638wgccM8pTbSJBCjhkEN
         QyncBnCG2ANaZnCUDjacG1DfSYvOaswN5YCvgGtuHLnB8ivXHkuul5jjTnzdPOVUpbEs
         JpWMO+8UWpqdlKSBZ3UQ/8sSmKOLYY9YIq82NRgO74cxrqNKzeM9jkIdLhj3QbcULBU8
         GdfGUXJIY+2vcdNb4xqAYWZLv7AMNtcwUrIVyJv4G5oLBypicbcCAChJOcaVJtNeLlec
         dDwA==
X-Received: by 10.112.0.242 with SMTP id 18mr422831lbh.18.1378859900404; Tue,
 10 Sep 2013 17:38:20 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Tue, 10 Sep 2013 17:38:20 -0700 (PDT)
In-Reply-To: <522F1A61.3010805@gmx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234517>

On Tue, Sep 10, 2013 at 8:10 AM, Ximin Luo <infinity0@gmx.com> wrote:
> (Please CC me as I am not subscribed.)

No need to say that, Git mailing list is sane and doesn't do reply-to munging.

> The question here then is, what remote branch should git push to - since pushremote only specifies a repo? I can suggest two options:
>
> - A: push to branch.*.merge if it's defined; otherwise push to <current branch> (like push.default=current)
> - B: push to <current branch> regardless

Or C: introduce the concept of a publish branch to complement pushremote:

http://article.gmane.org/gmane.comp.version-control.git/233572

-- 
Felipe Contreras
