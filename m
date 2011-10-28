From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: Re: Q: "git diff" using tag names
Date: Fri, 28 Oct 2011 16:59:43 +0400
Message-ID: <20111028165943.2cc8253d@ashu.dyn.rarus.ru>
References: <4EAABC15020000A100007D9D@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:59:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJm2N-0001s2-2q
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477Ab1J1M7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:59:49 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63617 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab1J1M7t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:59:49 -0400
Received: by eye27 with SMTP id 27so3487643eye.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=a4BQBFcBnMLhW+req9+d39XE+Woa23EcMEbznSkr9CM=;
        b=caUEnHfevpt0W2i+XUeHI3BBFAwTHZxT1ofkpOOCAqfjiUPt9XQ7gcu4iHuRbUxzW0
         9kbs/NAutazDgZf4OhP2cdXj0L3dVUTWOYOQ2mMUiSldaornfk9sGmQ+mQB6+JnhfX0j
         Jxr8I4PYhYB+62cWQmZjXoZxGkQtUhtbVPBRI=
Received: by 10.14.12.73 with SMTP id 49mr250803eey.219.1319806786904;
        Fri, 28 Oct 2011 05:59:46 -0700 (PDT)
Received: from ashu.dyn.rarus.ru (mail.rarus.ru. [213.247.194.83])
        by mx.google.com with ESMTPS id x45sm24406046eeh.11.2011.10.28.05.59.45
        (version=SSLv3 cipher=OTHER);
        Fri, 28 Oct 2011 05:59:46 -0700 (PDT)
In-Reply-To: <4EAABC15020000A100007D9D@gwsmtp1.uni-regensburg.de>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184404>

Tag is a pointer to a commit (if to say simply)

e.g. in my repo
$ git show-ref --tags --abbrev=7
-->8--
676f194 refs/tags/v2.6.7
b23c481 refs/tags/v2.6.8
-->8--

so

$ git diff v2.6.7..v2.6.8
is equivalent to
$ git diff 676f194..b23c481

etc
> Hi,
> 
> when using a somewhat older git (of SLES11 SP1 SDK), I could not find
> a way to "git diff" between two tag names; I can only diff between
> two commit numbers. I can display a changeset using "git show", but
> that's not what I wanted. Is it possible to get the diff I want using
> older versions, and is such a feature implemented in the current
> version? If so, since when?
> 
> As I'm not subscribed to the list, I'd appreciate CC'ed replies.
> Thank you.
> 
> Greeting
> Ulrich
> 
> 
