From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [RFC,PATCH] git-amend -- darcs like amend-record for git
Date: Mon, 1 Mar 2010 17:16:24 +0800
Message-ID: <be6fef0d1003010116p443985b3ib71f229a1978f831@mail.gmail.com>
References: <1267107365-2973-1-git-send-email-kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Mon Mar 01 10:16:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm1js-0006dB-WB
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 10:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812Ab0CAJQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 04:16:25 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:57554 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab0CAJQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 04:16:25 -0500
Received: by iwn12 with SMTP id 12so2205495iwn.21
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 01:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=6ogUrOx24qqBs8ayVZLdD5QZLMiNDrmggrs7LF+oV5g=;
        b=CUdxOxdTd0iyjN6LPSXDVXGGZyU589IB8h+4x7QyKzdFQaHDwJ6nFvQK1hXBcF7GTA
         yIykq7RyF/0phd3+QGP1xutvywvQoTFZDX5QirjINXC3qfyucfPY+y9UbNHBDKxdlBuy
         SU+EDG9KIl6QcrYyl3XwkMK+J8i5wrt9fZKz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=H7xMgnciIX+tBc1ll+NlDCNPmgDfKxBnwKknbTiMn5mtzna0v6Qu+lSjbJb9ux8HZp
         odDxa+QwkAdVguxLogaxfY4jAWiGGzaekSbo8A3X6DYJUlzEzcsxB7BMfbpNFP8KNFcf
         SlJZiraxeCyRyaSpQG91wRtUIWC0BZELynVdY=
Received: by 10.231.145.196 with SMTP id e4mr228863ibv.54.1267434984231; Mon, 
	01 Mar 2010 01:16:24 -0800 (PST)
In-Reply-To: <1267107365-2973-1-git-send-email-kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141309>

Hi,

On Thu, Feb 25, 2010 at 10:16 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> Ever wanted to type `git commit --amend HEAD~3` ? But had to fall back to commit
> and interactive rebase with fixup? And was tired by a lot of typing? And also
> rebase works only on clean worktree, so stash save and stash pop have to be
> used...
>
> Forget it.
>
> Now one can just do `git add ...` to prepare index, and then
> `git amend <commit>` to merge that changes from index into <commit>.

this may be a little late, but I'd like to indicate my interest in
such a feature.

A suggestion: I believe this could be better advertised as git-rebase
--interactive --edit. After all, you do replay the intervening commits
(which is closer to git-rebase than git-commit).

-- 
Cheers,
Ray Chuan
