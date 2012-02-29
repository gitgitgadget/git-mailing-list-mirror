From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 1 Mar 2012 03:07:41 +0530
Message-ID: <CAMK1S_j0gx_OYzvaKim-JrBxAPhJnHSLvLH8_yU5kLkqo9bfJg@mail.gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: opticyclic <opticyclic@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 22:37:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2rDY-0001ci-NF
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 22:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185Ab2B2Vhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 16:37:43 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:55023 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932158Ab2B2Vhm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 16:37:42 -0500
Received: by obbta14 with SMTP id ta14so462887obb.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 13:37:42 -0800 (PST)
Received-SPF: pass (google.com: domain of sitaramc@gmail.com designates 10.182.51.73 as permitted sender) client-ip=10.182.51.73;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sitaramc@gmail.com designates 10.182.51.73 as permitted sender) smtp.mail=sitaramc@gmail.com; dkim=pass header.i=sitaramc@gmail.com
Received: from mr.google.com ([10.182.51.73])
        by 10.182.51.73 with SMTP id i9mr890199obo.17.1330551462177 (num_hops = 1);
        Wed, 29 Feb 2012 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZBc0X2aaOsWe72abhaKwOF5h1dGqa1IodE5XAjsKxh0=;
        b=Jm8pQjmgc2SOVCDXA/ianXlH+Mwr0IjtCmVMCUZqEONn6kEU6Wa00Hy/s/qiIGE0zj
         2xAtpSxRabbUqeBkiL0g2d3+K9aFcgZm2r1B7HyLE7LRO989cjVYFNEsy44PuO8xJheU
         o/6TA2sYYszHx/LYPj54gCi6SPd4GjHKod0e4=
Received: by 10.182.51.73 with SMTP id i9mr763677obo.17.1330551462081; Wed, 29
 Feb 2012 13:37:42 -0800 (PST)
Received: by 10.182.76.100 with HTTP; Wed, 29 Feb 2012 13:37:41 -0800 (PST)
In-Reply-To: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191858>

On Wed, Feb 29, 2012 at 10:49 PM, opticyclic <opticyclic@gmail.com> wrote:

> I'm sure I don't have to tell you that GitHub has discussions on pull
> requests, which are easier to view than the mailing list archives.

For some definition of "easier".  Personally, I loathe the interface.

You don't seem to realise that using that will force everyone to use
that same interface, rather than their choice of email clients.

I run a project that is mainly hosted on github, but I absolutely
positively refuse to use their web interface for anything.  Logging in
to check, instead of just reacting to email as usual, is a pain but
that is not all.

The issues system does have an email interface, but it is not a
substitute for email. I can't cc anyone else when I want to, for
instance (well I can, but any response the original requester then
makes using the website will not get cc-d to the person I cc-d, which
kinda defeats the whole purpose).

The pull system forces a --no-ff even if the merge is at the top of my
branch and doesn't need one. It also gives me no chance to fix up
minor typos, add any more text to the commit message, etc. (I can do
that afterward, but this forces a "push -f" or a trivial "typofix"
commit).

I want everything in *one* interface, and I want it just the way *I*
want it, and it shouldn't (necessarily) dictate how *you* should work.
 Email is just that.

sitaram
