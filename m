From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: PLEASE HELP: Git for Yosemite 10.10.2
Date: Mon, 9 Mar 2015 23:06:12 +0100
Message-ID: <CAEcj5uUdoM-vdRu4tkwvRgmnrMSnPYbdNn_xyHntAttw2fdoLw@mail.gmail.com>
References: <98FA960B-4BA3-427B-8DAE-5C1AC4F6079D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Siamak Nooraei <siamaknoor@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 23:06:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV5oZ-00088U-SG
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 23:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbbCIWGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 18:06:14 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:44734 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbbCIWGN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 18:06:13 -0400
Received: by qcwr17 with SMTP id r17so6066930qcw.11
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 15:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+0PHJDbOTrD/eDhiuO07TBMpK5+ObLQnk93sVffuyVE=;
        b=R2OxVQowV6uEI2kxr6S0Z5apc/TVc4wZqYXCL4ec/+SKDO7gLwnTj1pJ2BuSCu0OYW
         LpKzmCQogh2q2s5dcHXHT/t2SVikYbRr3m1uWcYnbPlfW4BJktXPPbhgwltGbSOfoTLh
         OlU0MO4bqBYQ3G2MY7T9qgRadzf0CQ2eIv+s/3vGPVWJtA+cwMGZuxLdFKr1qzvRuPwX
         EkE1jlZOKADZKtP8ntKCbS5ZRP74cXbNJCT/bT94JweC+TohfGjSPbolmp/jgI9Rwf/q
         W2hM0N114hVm7cumYQX35tHJg6ETYg1JA++0fN/50t5FpTvDwHzW/8rWNeCAgjjT61qQ
         aFRQ==
X-Received: by 10.140.129.65 with SMTP id 62mr38807187qhb.11.1425938772731;
 Mon, 09 Mar 2015 15:06:12 -0700 (PDT)
Received: by 10.140.102.55 with HTTP; Mon, 9 Mar 2015 15:06:12 -0700 (PDT)
In-Reply-To: <98FA960B-4BA3-427B-8DAE-5C1AC4F6079D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265199>

On Mon, Mar 9, 2015 at 10:26 PM, Siamak Nooraei <siamaknoor@gmail.com> wrote:
> Hi there,
>
> I am taking an online data science  course for which I am required to download Git.
> When I go to the Git's site, I can only download Git 2.2.1 Maverick. Also, when I check in my CLI, it says "git version 1.9.3 (Apple Git-50)."

The Mac, or OS X, ships with a pre-installed version of Git. I believe
it is located in /usr/bin/git. Now if you study your $PATH variable,
you'll notice that /usr/bin comes before the path where you installed
the more recent Git 2.2.1. I may not be doing too good of a job
explaining how this works here, so please read [1] instead, or google
for more updated answers (I don't have a Mac in front of me).

> I need to download a version of Git that is compatible with Apple Yosemite 10.10.2. Please help. Thank you very much.

You should be able to use the version of Git that came installed for
most purposes. Newer is better, of course, but Git 1.9.3 is fairly
recent.

[1] https://groups.google.com/d/msg/git-users/rgRB1KkExD0/dje3ydV3qwcJ
