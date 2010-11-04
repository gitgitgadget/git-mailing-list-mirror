From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Problems switching branches
Date: Thu, 4 Nov 2010 21:39:49 +0700
Message-ID: <AANLkTikK93Jt+dAkpp6K-hQEo6D67q5OKJSLs+g0YL4y@mail.gmail.com>
References: <loom.20101103T032930-451@post.gmane.org> <loom.20101104T012032-963@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Thu Nov 04 15:40:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE0zB-0004wn-Vk
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 15:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978Ab0KDOkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 10:40:13 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33538 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0KDOkL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 10:40:11 -0400
Received: by ewy7 with SMTP id 7so996483ewy.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=onKUBUHxUjTQN+WnLy0kUo0+E/+qoZnTQOh9b3e/iF4=;
        b=xr/CLUmNxPZ9oAb0FTXeQbE6wF+jPPgbzK7/8bPbjPmmki0U5VguNlbhsuA+BJ+MLL
         H9Q72Rhg8lCe/ILnpcAatvrTJw3YgD8SHGWThd3cEBZfGTelRZtY9Nw1F3mdNdiXD4rr
         uBLMdnUoMqTelBedBa+cNkT6w9r3HO7cBoMSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=b+Y+S4xy0M7PYhJum4DaDjqcJoieXkIm4ck0xuL9e9njblTEvH4g4bdjdvzHyngVHg
         Khi5LFxL8/KoyXOIPjfUl7DEPEDNvRQYrMnPPmgiAgSRb48ckiSYJdLTVo0Wll16ULXQ
         t46A+FtmLlnLAbcwIneEXckr20z+TrLmf9Nk4=
Received: by 10.216.47.19 with SMTP id s19mr1993522web.56.1288881609764; Thu,
 04 Nov 2010 07:40:09 -0700 (PDT)
Received: by 10.216.172.199 with HTTP; Thu, 4 Nov 2010 07:39:49 -0700 (PDT)
In-Reply-To: <loom.20101104T012032-963@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160725>

On Thu, Nov 4, 2010 at 7:23 AM, Maaartin <grajcar1@seznam.cz> wrote:
> Maaartin <grajcar1 <at> seznam.cz> writes:
>
>>
>> I sometimes run in a problem similar to
>> http://kerneltrap.org/mailarchive/git/2008/10/15/3667644/thread
>> There are some ignored files which I want neither track nor throw away; I'm
> just
>> happy to have them and keep them out of version control.
>>
>> Unfortunately, there weren't ignored in the old branch. I'd be quite happy
> with
>> non-destructive switching like "checkout everything what doesn't overwrite an
>> untracked file", so I would end in the old branch with a dirty working tree.
> Is
>> it possible?
>
> No answer?

Which means nobody is interested in. Well, not really.

I also get irritated by a similar situation, where the untracked files
have the same content as the to-be-checked-out files. I have been
tempted (but never got around) to make git compare the in-index
content and the untracked file, if it's the same, no need to abort the
checkout process.

But your approach may be better. Yes, I think it's possible. Any
suggestion for checkout's new argument? --no-overwrite-untracked seems
too long.
-- 
Duy
