From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFD: should git rev-parse exit with non-zero status if ref@{n} is
 not valid?
Date: Wed, 18 Aug 2010 21:41:49 +1000
Message-ID: <AANLkTim+A5SFekBSg9bndPzesuBrOKMQeVsfn5pidu3S@mail.gmail.com>
References: <AANLkTi=Ktz=ARx0qUqB0844aYuq8BbqYUM8g726r9o5t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 18 13:42:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olh1t-0004t5-8I
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 13:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630Ab0HRLlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 07:41:51 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55860 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab0HRLlu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 07:41:50 -0400
Received: by qwh6 with SMTP id 6so393951qwh.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 04:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=WJTzebwK+EEYyjh1syumqfVWrRRZ325/KGeaJsllITY=;
        b=Qn6Yd3+1YWeUHFIgF6heijlRiiV83hDNXE4TBNn/UjKD/PkQJLPVI3FZJvB9mXIYXU
         +FX33VvYWzxQBupa9sBHOoixh6BYQ0xdI9xE7wREaJ6/3kmXslUIlsOfCXuEHmA/a6av
         7UKYEAeuH3HpYjMx7ZORB70oGy0Ewe8IkUayE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=XXVHWtRB4vFWXG4T0N4IGpsqwd+v5iPQGXGT5RJLiO/IWHpe5M/AcLCzuvMtSr9PiN
         49PyOyqUXp+FQogVN8T3OV+ktl69F55HORbMeB+6nbBOhSymW6jIza0CNbk8SOz9twtZ
         nDmq6b6zUKm1JQgSBXj190tywqr+KXu67A3Fs=
Received: by 10.229.1.203 with SMTP id 11mr767475qcg.238.1282131709565; Wed,
 18 Aug 2010 04:41:49 -0700 (PDT)
Received: by 10.229.231.199 with HTTP; Wed, 18 Aug 2010 04:41:49 -0700 (PDT)
In-Reply-To: <AANLkTi=Ktz=ARx0qUqB0844aYuq8BbqYUM8g726r9o5t@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153831>

| Argh! Sorry, that last message made no sense. Corrections marked with _.


On Wed, Aug 18, 2010 at 9:36 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> While reworking my detached-stash topic, I noticed that git rev-parse
> ref@{n} will exit with a warning message on stderr, the SHA1 of ref
> and a _zero_ exit code if ref exists, but ref@{n} does not.
>
> I understand why ref@{time-spec} might behave this way, but I reckon
> that if you ask for ref@{n} for n > N-1, where N is the length of the
> reflog, then you should either get empty output and a non-zero status
> (preferred) or a ref@{N-1} on the output with a status code of zero
> and a warning message (less optimal, IMHO).
>
> What say the list?
>
> jon.
>
