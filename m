From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: how to fetch entire heirarchy of refs from a remote?
Date: Thu, 7 Jan 2016 15:36:30 -0800
Message-ID: <CA+P7+xra4hjskOLg=VhLMGazTSDH=ky8H+fj2VMCw+HoY2Frrg@mail.gmail.com>
References: <CA+P7+xqexsOma5c9NfS5ma333UJV=5i1a4GhnwZuU75eaxRd=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 00:36:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHK6w-00045i-Q6
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 00:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbcAGXgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 18:36:51 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:36202 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbcAGXgu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 18:36:50 -0500
Received: by mail-io0-f179.google.com with SMTP id g73so72124259ioe.3
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 15:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=9nzPn3A/0OWRPVfCldG0M19GOG3MR04Z1VjiAAaSZBo=;
        b=XuFH2uiDHHG+JX1XkC0F6fmneDFHmsEuQ5TxU01jOm5RN9R+zcWyDS1ODEpY4hXrUd
         06koRdBnwsloyPY5+/+RHsPg2qD6R8uSO38kLMCixgvmNaTjs6wY6ZadxAElHNxIq6Xc
         pwbtJGD9kfJfJyvo2MXYR1FZaocMpH2LrAotbvXi+AWEywP1GaYtaHctmmZK9HbqN4pH
         MLir9FEwN4Yg2FUw4hON6lmKT/+UVAQ+JPi3LHdV3B7s9N+KsdclTzLL5OWp4Rr6tgip
         oM6AURFozgGwHQ7esk2WmSAxiJmVoFFiQu/1jTWOGMD84k+JKtCgj5qFPP7z5eG29E7l
         PWXA==
X-Received: by 10.107.170.67 with SMTP id t64mr61096473ioe.71.1452209810192;
 Thu, 07 Jan 2016 15:36:50 -0800 (PST)
Received: by 10.107.63.130 with HTTP; Thu, 7 Jan 2016 15:36:30 -0800 (PST)
In-Reply-To: <CA+P7+xqexsOma5c9NfS5ma333UJV=5i1a4GhnwZuU75eaxRd=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283518>

On Thu, Jan 7, 2016 at 3:06 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>
> But, git clone --mirror and git fetch have failed to pull every ref,
> and only end up with heads and tags.
>
> Regards,
> Jake

It turns out that it *does* pull the refs, but they don't appear to
show up inside the "refs" folder.. is there a reason for this?

ie:

ls .git/refs/changes

shows nothing,but

git ls-remote file:///path/to/repo

does show them? Any particular reason for why this is? I am confused
why refs aren't showing up inside the refs folder...

Regards,
Jake
