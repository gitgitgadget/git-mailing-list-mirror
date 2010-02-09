From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: What should I do to display the diff of even a simple merge 
	commit?
Date: Wed, 10 Feb 2010 00:46:57 +0100
Message-ID: <46d6db661002091546r1372836cs5dc47d54ae8eb19e@mail.gmail.com>
References: <46d6db661002091545j74f625ffr74ca70a0474948fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 00:47:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeznM-000207-N9
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 00:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab0BIXq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 18:46:59 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:59789 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab0BIXq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 18:46:58 -0500
Received: by bwz23 with SMTP id 23so780978bwz.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 15:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=6SpOsj8/4zP3oPIvawFYEv3aHH6emeSeC9tjwB4kxw4=;
        b=DIUBIio7ad/R/LWbS7TIjYTz57YrJuJH+N7MgrgYMU/kK4hdO59q4qhSS0mvBXiypg
         ydXYeBTl9P0aN4wQapXxmn0PjALxiLk//auN/U7bFcRlmqZLrk0UedfNLkZVu0nkwjCv
         WilngR+yGDgBOFaDNEw1fA3mlpbHfJb9VbDr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=oPJB4VRGSwCl3yR9g3bI9/U7BRDch20qwdTLbBq6uKahbSyW1YJDT+SLg1nW6cj2R+
         HIVY4SFbclWoXjSeImXoUUV8C/bVCr+mFB8JjpMw9ULNSG/6lAugvb1h6lU1lbR9ar4N
         VV9mALiGRHeBNeyCQ54Z+d6yei8iNiqeFTCB4=
Received: by 10.204.150.81 with SMTP id x17mr1802228bkv.200.1265759217131; 
	Tue, 09 Feb 2010 15:46:57 -0800 (PST)
In-Reply-To: <46d6db661002091545j74f625ffr74ca70a0474948fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139461>

On Wed, Feb 10, 2010 at 12:45 AM, Christian MICHON
<christian.michon@gmail.com> wrote:
> Hi list,
>
> I'm performing many merges between developpers branches these days,
> most of them not yielding into conflicts. (understand: simple merges)
>
> All is good, but sometimes, I would like to really like what has been changed.

I meant << I would really like to see what has been changed. >>

>
> As I do not systematically do this "git merge --no-commit --stat
> <list_to_merge>" and then fire "git gui" to inspect the diffs before
> the real commit, I'm wondering: how could I do this using some
> plumbing ?
>
> Right now, I've tried the obvious git log -c -p, git show -u --cc, but
> since the merge are simple merges, I cannot get any diff output. I
> believe this is by construction.
>
> Any hints ?
>
> Thanks in advance.
>

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
