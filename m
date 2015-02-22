From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange reachability inconsistency (apparently, at least...)
Date: Sun, 22 Feb 2015 15:30:11 -0800
Message-ID: <CAPc5daW=OeNmPVMVWQvp3rfYzfV7z6c1=26E26y0SaRQH7JooA@mail.gmail.com>
References: <144640746.551672305.1424355582540.JavaMail.root@zimbra39-e7.priv.proxad.net>
 <324985759.551780546.1424358217833.JavaMail.root@zimbra39-e7.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>, dirson@bertin.fr, poulot@bertin.fr
To: ydirson@free.fr
X-From: git-owner@vger.kernel.org Mon Feb 23 00:30:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPfyu-0003jU-Rr
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 00:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbbBVXac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2015 18:30:32 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:51938 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbbBVXac (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2015 18:30:32 -0500
Received: by mail-ob0-f182.google.com with SMTP id nt9so32767401obb.13
        for <git@vger.kernel.org>; Sun, 22 Feb 2015 15:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=eAun/pWEfu+0IBfZtNvuOfyjPvBRl5ZkgRjnCQadY2U=;
        b=uULe97BMs5eBowJX4XNz2Ew5qEDm3O1F06L4/udjVbLGd2pOscKRI7p2JILQm3MvRx
         hQ8ReltdqT2k12wCUHdQqRCH4m+4zM5oKG7yDbVXrxky2Xi1B6FQJQwmL6qHRkbwbonr
         b5QFoMic9g1lF7vIO4zdIEvrGQ9MIwhIcoRB9HTLZ1lLVGlViEfsauoP45etZovS6qq6
         eg48U5I4wx540R3RTFE5c1S8UdC5/ln3PPOVvA/p3W7sn3uVbHLvjg4ow4NuD/BUeTOY
         aNELWlpsdTBVf/1F6o2yfs779afla//6Wk5rJ+einPfo3AAVbt5l1weDC57t+GNVoKv/
         WA1w==
X-Received: by 10.182.43.129 with SMTP id w1mr5693543obl.86.1424647831472;
 Sun, 22 Feb 2015 15:30:31 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Sun, 22 Feb 2015 15:30:11 -0800 (PST)
In-Reply-To: <324985759.551780546.1424358217833.JavaMail.root@zimbra39-e7.priv.proxad.net>
X-Google-Sender-Auth: AsMQa-5-nkOsS5M3wH9HZmpMexA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264241>

On Thu, Feb 19, 2015 at 7:03 AM,  <ydirson@free.fr> wrote:
> I have a (fsck-clean) git tree in which for 2 commits A and B:
>
> * "git merge-base --is-ancestor A B" returns 0
> * "git log B..A" returns a non-empty set of commits
>
> I get this behaviour with 2.3.0 as well as with 2.1.3 and 1.7.12.
>
> Is that a real bug or am I just misinterpreting something ?

Sounds strange. Is it possible to share the repository (or an
anonymised copy of it)?
