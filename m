From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 17/17] Documentation: add documentation for 'git interpret-trailers'
Date: Sun, 2 Feb 2014 06:22:14 -0500
Message-ID: <CAPig+cRJ3yVVooJymc5m=wHGrdn06A9wE-4GOa0xODz5Pmg1+A@mail.gmail.com>
References: <20140126165018.24291.47716.chriscool@tuxfamily.org>
	<20140126170011.24291.26146.chriscool@tuxfamily.org>
	<CAPig+cQgq_2h+n8OeDsrmk_NqAA4RDNzkBAtNCNjOAGMrFN4jg@mail.gmail.com>
	<20140127.213344.212708599170084659.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Feb 02 12:22:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9v81-0005g3-5S
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 12:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbaBBLWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 06:22:16 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:52369 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbaBBLWP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 06:22:15 -0500
Received: by mail-yk0-f174.google.com with SMTP id 10so33040398ykt.5
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 03:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=unH1MWO5kf4WJQtBAwXca18mFZZJ2jlv61p6klMZDT0=;
        b=R1qBXQ+Ye+kmPceCornl4ic/tob0M4Jpt+woyWm6e2i5VcEGjiAdLLYEUR/AoWiiQt
         afPrabipie6b8nVK+ZDkGGeIEgTcEY/LdW+6IKjib3T3nkwEBIsYGvJIn2ri2NYOXHin
         871B62NxUM5FJ3vbcZ1z89RfV+PZHxbwRum1bCHhxllZVUyqqWJHuIZcsIqQy03QaG7o
         qWwdLP8myDw4ooF6E0NLogMhERqICTu05V+k6KJ2rgElQkTwOrdRRRgL+vzU1Vxcu2+y
         KLcJpuelMZSvPMc7pb0n/PMUvbBOYTe3luPIiFLrvQ34ZiWQymp7XkXBB0CMiZzyNvUA
         v3+g==
X-Received: by 10.236.46.18 with SMTP id q18mr27843485yhb.21.1391340134636;
 Sun, 02 Feb 2014 03:22:14 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Sun, 2 Feb 2014 03:22:14 -0800 (PST)
In-Reply-To: <20140127.213344.212708599170084659.chriscool@tuxfamily.org>
X-Google-Sender-Auth: EMifpdZaj3to-QnZyfcin-SHUdg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241362>

Patch 17/17 of v4 failed to arrive in my inbox for some reason, so
I'll just reply to v3 since there's another error I noticed which is
still present in v4, plus a comment specific to v4 (see below).

On Mon, Jan 27, 2014 at 3:33 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
>> On Sun, Jan 26, 2014 at 12:00 PM, Christian Couder
>> <chriscool@tuxfamily.org> wrote:
>>> +By default, a 'token=value' or 'token:value' argument will be added
>>> +only if no trailer with the same (token, value) pair is already in the
>>> +message. The 'token' and 'value' parts will be trimmed to remove
>>> +starting and trailing white spaces, and the resulting trimmed 'token'
>>
>> Other git documentation uniformly spells it as "whitespace" rather
>> than "white spaces".
>
> You are right I will change that.

The rest of git documentation consistently spells it "whitespace", but
v4 uses "whitespaces".

>>> +----infile=file::
>>> +       Read the commit message from `file` instead of the standard
>>> +       input.

I didn't notice this when reviewing v3, and the same text appears in
v4. There are a couple extra hyphens before 'infile', and you want <
and > around "file", so:

s/----infile=file/--infile=<file>/
