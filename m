From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: [PATCH] Add --recursive flag to git bash completion script.
Date: Mon, 9 Mar 2015 11:43:53 +0100
Message-ID: <CAEcj5uVCudOV3a9BaWnwY=dvAOGmPfYfBeFBS9y2vyrzBBZbOQ@mail.gmail.com>
References: <1425859216.8244.40.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: James <purpleidea@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 11:44:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUvAF-0008Sl-3R
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbbCIKnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 06:43:55 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:40882 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbbCIKny (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:43:54 -0400
Received: by qgdq107 with SMTP id q107so27128480qgd.7
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GPuXCsp77sGxOgdqw96Q+aAHxtN2K/ASiiZco0xx+MM=;
        b=NCvH81waLhL0UmecvxsiUcnoQwv6cxBIikh6uJZ19qPhiWDyyrh6kfbteQ2vNMdbvX
         LOgp6NEreIvBa9PZzuAll/FScftBwX1HruE2VCpG6Gy6qviCzgr3/behnOev5KcbjNYj
         gA6OvHnhqNKUTf0JZDmTF2AAVDIOslD14+lNYTfjpibjfYbTX4m8pm1nVg0j2aUtImd9
         bysKSfw3wdSw4na0+++ZNLRuR29vcTSGhD9+HHc79zIFDVlOFGKeFLUYIF6GtnZjuC/U
         004uUTRqg2+ZKonPx2Fqk752kpBZoBXOMBus34WjnDzHJAFUXKhzolF7IImSVoEJMq+H
         am7g==
X-Received: by 10.140.148.195 with SMTP id 186mr34445503qhu.60.1425897833774;
 Mon, 09 Mar 2015 03:43:53 -0700 (PDT)
Received: by 10.140.102.55 with HTTP; Mon, 9 Mar 2015 03:43:53 -0700 (PDT)
In-Reply-To: <1425859216.8244.40.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265159>

On Mon, Mar 9, 2015 at 1:00 AM, James <purpleidea@gmail.com> wrote:
> This is a patch to add a much needed option to the bash completion
> script. I'm not subscribed to this list, so please include me in your
> reply if you'd like me to see your response.

Please read the guide on how to submit patches [1].

Although the change is trivial, some immediate problems I see are:

* The patch is attached rather than being inlined.
* The fix should also be made for the other shells (zsh and tcsh)
* The commit message contains an unnecessary smiley, personal
digression, and a period in the first line.
* The change or the problem it is solving is not clearly described. I
think it would be better if you write something like this in the first
line:

"completion: add --recursive flag to git clone"

And for good measure, add another sentence below explaining why this
should be available for completion.

Do a `git log --grep completion` to see how others have formulated
changes in the same place in the past. You want to be consistent with
them.

[1] https://raw.githubusercontent.com/git/git/master/Documentation/SubmittingPatches
