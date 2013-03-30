From: Phil Hord <phil.hord@gmail.com>
Subject: Re: stuck and need unstuck (git checkout)
Date: Sat, 30 Mar 2013 16:48:50 -0400
Message-ID: <CABURp0ra4znHXVmUjMK2kOjPLHe2Dys46HZ=wC=LWri_sFag0Q@mail.gmail.com>
References: <51508FFA.4080404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "J.V." <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 30 21:49:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UM2ia-00086G-LO
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 21:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab3C3UtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 16:49:12 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:59275 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337Ab3C3UtL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 16:49:11 -0400
Received: by mail-ve0-f182.google.com with SMTP id m1so1493411ves.27
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Sh2VPbTJp3R6fHdY4z4nadxoZp8+YKw4+XqinexsGSg=;
        b=esRiSpBxJyJ6uxJa39WMoj+g935qGD3vQJP9HLhPN9jsCdAa4vEaqkqxQIPK5aWzzj
         pdvIXGuonqtqT4NmQwDVR63zyDUmzQ3m1UnXCF9lvTtG64Uujv5f4YSBUB52l7IBCkoz
         jSNHmpa7RET8QJYOq7SvTwucnUY0Oe/FttIwdV8Zrj27d3vdm5NYajXaLJucTM7HS5QU
         esJ2Bt8QJONl583tkAqH7WW9jumBiFVuPNVaLRIzkjuj4OfODATk3606+XfoJkcUVl77
         DqR6pyUx378ESPI01N6DOumZ+lPQ6/MkZDwlSKMjSlhFDD7vKpE3NRoxVRy0vEoThbBm
         vlIQ==
X-Received: by 10.52.26.209 with SMTP id n17mr4628751vdg.26.1364676550884;
 Sat, 30 Mar 2013 13:49:10 -0700 (PDT)
Received: by 10.58.23.135 with HTTP; Sat, 30 Mar 2013 13:48:50 -0700 (PDT)
In-Reply-To: <51508FFA.4080404@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219596>

On Mon, Mar 25, 2013 at 1:57 PM, J.V. <jvsrvcs@gmail.com> wrote:
> I was on a branch (local tracked with remote), and I wanted to checkout a
> remote branch so did:
>     $git co myRemoteBranch
>
> and got a message that a lot of jar files were being untracked (files were
> locked).  I had a server running that had some of the jar files locked, so
> it could not update and untracked them all.
>
> What I want to do now is:
>     1. switch branches
>     2. delete this locally created branch
>     3.  re-check out again so all will be well.
>
> I cannot switch branches because it says my untracked files will be
> overwritten.  How do I switch branches? I have no commits to make and simply
> want to go back.  git reset and git stash do not get me there.

Does 'git checkout --force yourLocalBranch' help?

Phil
