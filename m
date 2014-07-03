From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: Show containing branches in log?
Date: Thu, 3 Jul 2014 21:41:04 +0200
Message-ID: <CAA787rm=Pjy-GGzxCcy=NQNLUOCrTt4hYWS9iND8EAxxs67SuQ@mail.gmail.com>
References: <CAHd499A78BRVawWSHNnzJcD1Ca7RfFeEnJf0SB7py1MD5qwL0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 21:41:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2msb-0002uS-1E
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 21:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbaGCTlI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2014 15:41:08 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:39775 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932384AbaGCTlH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2014 15:41:07 -0400
Received: by mail-la0-f50.google.com with SMTP id pv20so521864lab.9
        for <git@vger.kernel.org>; Thu, 03 Jul 2014 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=E3vnms8LnQGjdoKNoYx0Uw/GQZUR581KLRBo65zwDR0=;
        b=KMI26V/HC5qQFj++1jT1TJax4n+NVTSPAjC1CIVb/+JJWRR7n40Ym10jB4opynug6B
         RwP1eOjpIL/HjNeSShwYRcpfH1yKsoogwVO6fZ/ebYy+Kw20GMsUcQTXp0iKGRPFYldZ
         1IqIkiujQaHj5WJHPX9R8yddY4UkB5WLYTARkQHln4X2xpvCoL+/cFcbR/bJGbr1Wm81
         5u7GDJzpwPxRz/cXa6u9a8pYTltBf08HwxhX/UyD9+K+DT/l7Ii4Afd8Ly+1M0vFBZFa
         QI0gcE/iUXi3hjkXCK+hV7Bg8DL4F/flfRLM0svTpC+s53+xAZyLfpbsb1SkRnP4+RD5
         f6Cw==
X-Received: by 10.112.155.129 with SMTP id vw1mr4565665lbb.7.1404416464691;
 Thu, 03 Jul 2014 12:41:04 -0700 (PDT)
Received: by 10.112.142.7 with HTTP; Thu, 3 Jul 2014 12:41:04 -0700 (PDT)
In-Reply-To: <CAHd499A78BRVawWSHNnzJcD1Ca7RfFeEnJf0SB7py1MD5qwL0g@mail.gmail.com>
X-Google-Sender-Auth: YX42WJsKhFKOah-UzeXHPdNK8yI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252876>

On 2 July 2014 16:50, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> I know that with the `git branch` command I can determine which
> branches contain a commit. Is there a way to represent this
> graphically with `git log`? Sometimes I just have a commit, and I nee=
d
> to find out what branch contains that commit. The reason why `git
> branch --contains` doesn't solve this problem for me is that it names
> almost all branches because of merge commits. Too much ancestry has
> been built since this commit, so there is no way to find the "closest=
"
> branch that contains that commit.
>
> Is there a way to graphically see what is the "nearest" named ref to
> the specified commit in the logs?

I have created a script for just this functionality which I use very
often, and have created a gist with the files at
<https://gist.github.com/sunny256/2eb583f21e0ffcfe994f>, I think it
should solve your problem. It contains these files:

  git-wn

"wn" means "What's New" and will create a visual graph of all commits
which has a specified ref as ancestor. It also needs the following
script, just put it into your $PATH somewhere:

  git-lc

"lc" means "List branches Containing this commit" and generates a list
of all branches containing a specified ref.

The files originates from <https://github.com/sunny256/utils>, but
I've modified them in the gist to make your life easier. :)

Hope that helps,
=C3=98yvind
