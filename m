From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2015, #03; Fri, 20)
Date: Mon, 23 Nov 2015 00:02:35 +0530
Message-ID: <CAOLa=ZRpvd-Nd9HiZMt6aZF9bi5i1MHNDZUSdUsGC9C-t+2bSg@mail.gmail.com>
References: <20151120140937.GA17079@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 22 19:33:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0ZRm-0005ZK-IM
	for gcvg-git-2@plane.gmane.org; Sun, 22 Nov 2015 19:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbbKVSdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2015 13:33:06 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35024 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbbKVSdF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2015 13:33:05 -0500
Received: by vkha189 with SMTP id a189so25287281vkh.2
        for <git@vger.kernel.org>; Sun, 22 Nov 2015 10:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+gXS4Fn9pAqh8eMlTEwmgL/a6ZcQ9iIPhMk6i1IAa3I=;
        b=rgE/eAUOlWWU0JBCWAdHotvLYe+jC7RDYATmSxOGHPgpa3qJgC2y95RxPasIez4rjX
         hl1diik1AjN58sZPC5Yedd3ncmAkSZaObqrHdVcci8M63Zmu1ayTolRCuTeASkXkq192
         xPm54G6yOELh4C+gHktzuaKJaedfXMXfcgm4avEe3B0s3klR1mqtbQ2nL4N0C6buzi4O
         iKDIecotgyMibfW0vmNIat+2JBahssLjPr/OOBvAhIIVs+XMafbo4WHvlZMIt/Uw4vjj
         ZVg0FgFrGlnv7pLUtyuVRGy/hbJ8IpSid0WKmJ0s+qUMSjyXZVAUSHozGcMZphdRtvqE
         9d1A==
X-Received: by 10.31.178.1 with SMTP id b1mr13669542vkf.46.1448217184589; Sun,
 22 Nov 2015 10:33:04 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Sun, 22 Nov 2015 10:32:35 -0800 (PST)
In-Reply-To: <20151120140937.GA17079@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281567>

>
> * kn/for-each-branch-remainder (2015-10-02) 9 commits
>  - branch: implement '--format' option
>  - branch: use ref-filter printing APIs
>  - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
>  - ref-filter: introduce format_ref_array_item()
>  - ref-filter: adopt get_head_description() from branch.c
>  - ref-filter: modify "%(objectname:short)" to take length
>  - ref-filter: add support for %(path) atom
>  - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
>  - ref-filter: implement %(if), %(then), and %(else) atoms
>
>  More unification among "branch -l", "tag -l" and "for-each-ref --format".
>
>  Expecting a reroll.
>  ($gmane/278926)
>

This series is supposed to follow this:
http://thread.gmane.org/gmane.comp.version-control.git/281180 which I
recently sent.
So replace "for-each-branch-remainder" with this in "Whats cooking"?

-- 
Regards,
Karthik Nayak
