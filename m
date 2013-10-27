From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: git-completion.bash error
Date: Sun, 27 Oct 2013 18:34:10 -0400
Message-ID: <CAPig+cQuh0QEbmDxNMHgvhmJ7AFgvP70qvJhfVw3fz6YxaME7w@mail.gmail.com>
References: <CAGvuA0iGrF5jrUSCjT7-SR85i2OhBwQHfjj4+krAFfz5wnxx8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Gabriel <gabriel.so@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 27 23:34:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaYuX-0003Sq-ET
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 23:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab3J0WeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 18:34:12 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:52854 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab3J0WeM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 18:34:12 -0400
Received: by mail-la0-f46.google.com with SMTP id hp15so4622996lab.33
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PpLtRsNGCRE8o5eYFQOn5dKr6Gfxxr8m1Jaf/CP1M84=;
        b=dDLizXJ1W/ggpUPamLee7XyVNReVT8Zuk9YkSIPwcDjciOfF6S7h2icA880mt3KyhC
         qLfDOyR/eICpajRtSjDNCNdDvGZcagszq/QLn7z78tkX/vvBDbo+YkpA9CfvBlASO6ne
         Gm50LpVAOyuOcPyipW0L8MJlh92qO86sNlvP5GED3PL33Hk/GGQUbAWfzIoMl/AUXr2Q
         Tz3rFAdRdg6kDGIy4sl+iX7B7qfHwTiqdRj+n1masu7P+HL91rUmZEkUQGJkSsAnAgaO
         dZnee2nA1akB8MKuIgHQvD/zi30yQgLiBJUcONiIDalgmu+PcIQgHbWqKEv48Yphd8X8
         Aw9Q==
X-Received: by 10.152.120.73 with SMTP id la9mr12370752lab.3.1382913250709;
 Sun, 27 Oct 2013 15:34:10 -0700 (PDT)
Received: by 10.114.200.180 with HTTP; Sun, 27 Oct 2013 15:34:10 -0700 (PDT)
In-Reply-To: <CAGvuA0iGrF5jrUSCjT7-SR85i2OhBwQHfjj4+krAFfz5wnxx8w@mail.gmail.com>
X-Google-Sender-Auth: i72Y1JD8TFYPFtf5vYw2qk0Y_cU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236814>

On Sun, Oct 27, 2013 at 4:59 PM, Gabriel <gabriel.so@gmail.com> wrote:
> I've just made a clean install of OS X Mavericks and installed Git via
> Homebrew, which obviously includes the contrib files.
>
> I sourced the git-completion.bash into my profile and I get stuck on a
> error every time I try to use the autocomplete. The error outputted
> is:
>
> egrep: ^ [a-zA-Z0-9]: No such file or directory
>
> I believe this is related to this line (this commands outputs the same
> error when entered directly):
> https://github.com/git/git/blob/master/contrib/completion/git-completion.bash#L614

Unable to reproduce on Mavericks either via the completion script or
manual entry.

> I don't know if this issue is directly related to OS X Mavericks or
> anything else.
