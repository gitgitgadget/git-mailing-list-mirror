From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git status takes 30 seconds on Windows 7. Why?
Date: Thu, 28 Mar 2013 08:19:29 +0700
Message-ID: <CACsJy8BgLpTPPzNPo9EQiUQq_s9Lru=ZsS+1B0CmU=5XjcHs-g@mail.gmail.com>
References: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jim Kinsman <jakinsman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 02:20:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UL1W6-0007Kt-Tk
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 02:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125Ab3C1BUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 21:20:04 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:51253 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822Ab3C1BUC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 21:20:02 -0400
Received: by mail-oa0-f53.google.com with SMTP id m17so7948524oag.40
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 18:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=HmNcBIQpuhPipBIxEHXstOWwNMezqJRuurXKf0etcI0=;
        b=DM831PKuuqEKMEKrNci/KuHa2CIoxbJr+t0RR7/B1CCniJ7SogoLGk2ZQ5RmQFuuKM
         msDYEiDF/AstjC3zImPiXURxeKZ3nMmF84rk17pwQ6uM4CRnoSLkEMb2pEPCukjbgOmV
         xG7eJWFyY+e7w1C4tIy83JkN92DhScNmuPxhvr8WlS4bCqhPbx9Uj0F8zoMH5tuQJaHr
         N2RSUUYeYaAnsPLs0PhvLQ2j8ocuGL6yxmdbCx0b5r7RsPMAj2vYHCFBXk5iSYoG8wPZ
         ylMrfc0fwVh4o+A3hjwMBNBk1vzH+KCIVrRV96p+Ka2mRlruv5lAlE2ZUAUCAXACqRJi
         8gLg==
X-Received: by 10.60.31.79 with SMTP id y15mr16396689oeh.123.1364433599773;
 Wed, 27 Mar 2013 18:19:59 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Wed, 27 Mar 2013 18:19:29 -0700 (PDT)
In-Reply-To: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219362>

On Wed, Mar 27, 2013 at 11:39 PM, Jim Kinsman <jakinsman@gmail.com> wrote:
> git status takes 30 seconds on Windows 7. Here are some stats:
> git ls-files | wc -l
> 27330
>
> git ls-files -o | wc -l
> 4
>
> $ git diff --name-only | xargs du -chs
> 68K     update_import_contacts.php
> 68K     total
>
> What can I do??? This is so slow it is unbearable.
> By the way i've done git gc several times and nothing changed.

You can try "status -uno" to skip showing untracked files (and may be
do without -uno before commit so you don't miss files). You may also
try core.ignoreStat (but I think it's not very convenient to use)
-- 
Duy
