From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Pushing everything
Date: Sun, 31 Oct 2010 14:43:26 +0800
Message-ID: <AANLkTikG5yTPwkjmnSv8yg2QRNNjDu_JxBdHzLBjO1RP@mail.gmail.com>
References: <loom.20101031T064406-734@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Sun Oct 31 07:43:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCRdd-00050L-4q
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 07:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab0JaGn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 02:43:28 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41627 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab0JaGn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 02:43:27 -0400
Received: by pzk3 with SMTP id 3so309391pzk.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=5NtgwjFRLsLkl3PjzTqFyn3RrFwHoAaA5ce7TiKtxlA=;
        b=Tp0atZ5qFnHETS2SbAzYNhXZAIqFoTWigFHLK3fKoxXuKov+O+6BxRnr4Fn0IuslGC
         j2KmggPtR7GTcidt3oJD8YvYl/PRns58maJjGuNevSwTo0lSP9jeOM//xrjAEdsya8pW
         KXOjq6GvOU8lxKv4PSQYPQ5BIMP4ifRlBJVY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=waaMum4tj0L9FM6HiJabph6WG7ERH2uAWU20BCQwavjf9Xpl2GBfL8XdH2PsZhLwha
         8Km8GI8dYpzP1YFd+vdl+z2tCWfEZfwR4ORyXhN8Mm8thu+MYUULsXVFhptVFBJ0CTie
         qc3DKufeRWv43gtHqJu5TXrm8OE67+D3qL3gY=
Received: by 10.142.157.21 with SMTP id f21mr2528355wfe.5.1288507406866; Sat,
 30 Oct 2010 23:43:26 -0700 (PDT)
Received: by 10.142.13.5 with HTTP; Sat, 30 Oct 2010 23:43:26 -0700 (PDT)
In-Reply-To: <loom.20101031T064406-734@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160418>

On Sun, Oct 31, 2010 at 1:47 PM, Maaartin <grajcar1@seznam.cz> wrote:
> I'd like to push all my branches and tags to the server, but for whatever reason
> "--all" ignores tags and is incompatible with "--tags". I could imagine there's
> a reason I'm not experienced enough to see?

You can spell the refs explicitly, like this:

  $ git push refs/heads/* refs/tags/*

Modify the glob to taste.

-- 
Cheers,
Ray Chuan
