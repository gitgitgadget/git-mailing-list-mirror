From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 4/6] worktree: new config file hierarchy
Date: Mon, 1 Feb 2016 12:09:54 +0700
Message-ID: <CACsJy8AZYjQJ0rP0nF3xkOuvRzP_sX9Dp6bxS4abUEYQJ8kmnQ@mail.gmail.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com> <1453808685-21235-5-git-send-email-pclouds@gmail.com>
 <xmqq7fiu7je7.fsf@gitster.mtv.corp.google.com> <CACsJy8C3wXL-nE1TfS7V8BFNwaQTjMtkQibCswycpX_teaATpQ@mail.gmail.com>
 <xmqqsi1hilug.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	"Max A.K." <max@max630.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 06:10:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ6kw-0005l1-JD
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 06:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbcBAFK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 00:10:26 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33018 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbcBAFKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 00:10:25 -0500
Received: by mail-lf0-f67.google.com with SMTP id e36so2954643lfi.0
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 21:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kbevDj9rs0YCj88osNDxLmOVg3ZIPEsd+q+0LgNzspI=;
        b=t5wA3EBrAblsBbHw7zmO3fjlZHsmXdlibzyiMCylVsXPnPK1olfSV8dUN/612Udwr4
         VvZGbr2ENCs07rXLqcWyaXlJMUQSBvoz5SLfc2bkl3QF7hQy1LatklNi2qO74cqxBSni
         va9vXLD2VVpuqo5FVtiaTrtoTkUsvs6BsKoDBD+61R7aZ3r2T0OOK0uTkbtQgcx0VDkR
         3dXmlNXroZVjY1bV7rxeHmnI4FrR/FBui1Z5r0WJ8WnH+/noQYbOXXJTqOySgPtrXZnd
         c30nwJoUUWnwqjRRt8Ut722xbN8opoJCaTRAwiDCU/u3q2JXaAD/oAbcnrr2gcT5a1eK
         gYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=kbevDj9rs0YCj88osNDxLmOVg3ZIPEsd+q+0LgNzspI=;
        b=aLb81InAk9fO+VMZVEK7vc+xo9LJDAXdecyRrJDhNNxrddis4vfbOYg3hLyyRDPDrI
         +0+KnT2LnifyRpF60p9OGTjfq1DalJxiSweVehjhlkibt5Ds8gZlm2JvdP+e/aSjFNxM
         ZYO8tZ1NV8ienats+h5I2wwZmDEON7bF8TS/8qdYF6UrAaMxSndOhNZ6AuzodWvO9so3
         TlRmTOGC8PTKkFtxLJ4v/B5oo3QbRs0Px5oJ73UqsCyikJgKlWnZibN7xkllJd2kVXu4
         e8VH0Rc/UTy3YMjFeE2qxi7JCM5Q8EJOhCRkgu8ah4vOnM0F1doRiGe+2OY60k0dcv1p
         pZWA==
X-Gm-Message-State: AG10YOQ7f6FaGDt1iIWlDcjeny6xJmsYTBGZ8dF43vjA4y6eJEGZjEIug/52mAVMJ2/iOgVhD+8SeIVlpnJW8Q==
X-Received: by 10.25.4.7 with SMTP id 7mr2930795lfe.45.1454303424223; Sun, 31
 Jan 2016 21:10:24 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sun, 31 Jan 2016 21:09:54 -0800 (PST)
In-Reply-To: <xmqqsi1hilug.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285184>

On Fri, Jan 29, 2016 at 1:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Would it make it simpler to invent a specific value for 'xxx' that
> denotes the main worktree (hence $C/worktrees/xxx/config will always
> be read by worktrees including the primary one), not to add
> $C/common/ anything, and use $C/config as the common one instead?
>
> Then the repository format version can live in $C/config that would
> be noticed by existing versions of Git.

I can read this in two ways. In the first way, we still have $C as a
.git _directory_ that contains no worktree stuff because those files
are in $C/worktrees/main. When we detect .git directory we need to
decide if it this is worktree v1 and redirect $GIT_DIR to
$C/worktrees/main, otherwise keep $GIT_DIR as $C. This messes up setup
code a lot (I tried).

The other way, probably a bit deviated from your intention, is, we
only support two modes: either all worktrees are in $C/worktrees
(multiple worktree mode), or there's only one worktree at .git (single
worktree mode). In other words, there's no mixing main and linked
worktrees. The user will be forced to convert the main worktree to
linked worktree when they want to add a another tree. The backward
compatibility issue with worktree v0 is gone.

The transition between two modes can be done via "git worktree move".
This command can move any worktree, including the main one. Main
worktree is converted when it's moved (.git directory remains where it
is). "worktree move" can also move repository directory, which also
automatically convert main worktree to $C/worktrees/something. If the
user deletes all worktrees except one, they can move the repo back to
worktree's root, which converts it back to the single worktree mode.

Hmm?
-- 
Duy
