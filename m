From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Folding commits together
Date: Wed, 22 Sep 2010 15:25:47 -0400
Message-ID: <AANLkTikqmJrLoF8tvpUoE7gfPOtHkFr0VMH0oqzdxani@mail.gmail.com>
References: <loom.20100922T123419-101@post.gmane.org> <vpqsk12rpz4.fsf@bauges.imag.fr>
 <loom.20100922T132318-104@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Wed Sep 22 21:26:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyUxy-0003jX-AN
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 21:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292Ab0IVT0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 15:26:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59193 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560Ab0IVT0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 15:26:45 -0400
Received: by iwn5 with SMTP id 5so736122iwn.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 12:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=yerep533V121Hy8+qeUNgQrYNwfL+FCHNRhp/hTEKFA=;
        b=s0ktdlKzEpzqfsL1b8lKwcjmkU6ACXUjBJOzYmm5ze0uYNeQf3U+reZTNY717a66yR
         HtS5cIpBQASNlKq5vIzpnuVr9mxnpWuKr+7kq06ShqPyqgS/TW6GAVrYjv3Iga9Gt16E
         sNNN7eMdw8DyMvhXHUpXGhMdUUg8jw8XYIzKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GO6FJvQIiXwRerNTKF/d36yOYyfeTBQlefNilJelp9NGp0LVQOrr2UJglR7fyjovev
         ascDodlN0AIkrTxjUdJU3Cw99x9jCpgbvyjyWKCL/NBZj/2BdeiHRltHOGvLhZqSoFYR
         s47nzTEPZToK9Cvw0sVbPDmTH8L549UJfuWHQ=
Received: by 10.231.149.80 with SMTP id s16mr637910ibv.81.1285183604341; Wed,
 22 Sep 2010 12:26:44 -0700 (PDT)
Received: by 10.231.19.140 with HTTP; Wed, 22 Sep 2010 12:25:47 -0700 (PDT)
In-Reply-To: <loom.20100922T132318-104@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156828>

On Wed, Sep 22, 2010 at 7:33 AM, Maaartin <grajcar1@seznam.cz> wrote:
> Matthieu Moy <Matthieu.Moy <at> grenoble-inp.fr> writes:
>
>> Which exact command did you type? Something like this should do it:
>>
>> git rebase -i HEAD~3
>
> I've tried nearly everything, starting with
>
> git rebase -i d8e3842
>
> which should be the just the same as HEAD~3. I retract the question, my editor
> keeps opening a wrong file, which I've just spotted by accident. The problem was
> caused by a git-cygwin-emacsclient-emacs interaction, rebase works nicely.

Another way to do this if it's the top-most commits is:

$ git reset --soft HEAD~3
$ git commit --amend

j.
