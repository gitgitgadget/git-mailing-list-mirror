From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Merging (only) subdirectories
Date: Wed, 1 Dec 2010 12:55:55 +0000
Message-ID: <AANLkTi=gDdasJ1gsAgSCxQ5a3pWvTNCfiaSn5h-WUt1C@mail.gmail.com>
References: <AANLkTimZc0r8WBOsE73V=7SKdZgONiCKfYCk7rBrCY3F@mail.gmail.com>
	<AANLkTik-d8oys9h=wFRnyt8sukTsSymaw5LGM39BU2K=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 13:56:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNmEH-0003d0-DH
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 13:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202Ab0LAMz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 07:55:58 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52699 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951Ab0LAMz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 07:55:57 -0500
Received: by yxt3 with SMTP id 3so2843224yxt.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 04:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=bPry/7LqZnjKo9Au377gZXtZEa68e8rzbUGfdkqQ4QU=;
        b=UvWKYBMJAeZxZ8lEKrlwgnY2VtvzSamRBilrzRVFPvWxtespgGmTPEGXYKaJbDpqIh
         Pr8r2o8+6h2YMVs/TumRVd5mRaZsSdP/5dJpLRHbSctGSGo4SDHzZ7gOmS+BZygqsNwv
         1K8QQ5AdB4YH/zSaECZWo+O88OBZL62JaL8mE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=BqbqCoKDAl39mpD1xfrqV1CZhKEaNVJBoI3pjYN20tZjJz5Zdf1btmnrffaFQR063D
         Dw6A1txcf5+xCusfN2It5UJIXiRUyULE7QXjCOkDKtLhfS7VM3W0d+7CD3JwP/WtNMj1
         IoiJSq4kyzvDRHJYRgHhB7ROjAvr1kfHlX5xg=
Received: by 10.101.56.12 with SMTP id i12mr4534422ank.142.1291208155194; Wed,
 01 Dec 2010 04:55:55 -0800 (PST)
Received: by 10.100.38.15 with HTTP; Wed, 1 Dec 2010 04:55:55 -0800 (PST)
In-Reply-To: <AANLkTik-d8oys9h=wFRnyt8sukTsSymaw5LGM39BU2K=@mail.gmail.com>
X-Google-Sender-Auth: 9Kdu1sc71MLmjTnu8cGlJEOo7zE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162506>

On 1 December 2010 12:36, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Wed, Dec 1, 2010 at 6:18 PM, Howard Miller
> <howard@e-learndesign.co.uk> wrote:
>> What I would like to do is to be able to merge branch B into branch A
>> but ONLY stuff that concerns the theme directory. I don't think this
>> is possible. I'm reluctant to keep themes in a completely separate
>> repo as that just makes testing them more problematic.
>
> I don't know. Maybe you can use topic branch. The idea is that you and
> other theme designers branch out from a known point, then make changes
> in the theme directory only. You guys can merge from each other's tree
> because nobody would change anything outside theme directory.
> Occasionally you can merge back upstream for testing with new code,
> but don't push that merge until your theme is ready. Once your theme
> rolls out, you can either keep working on your topic branch, or throw
> it away and branch out again.
>
> Also, please consider submodules if theme dir is totally independent.
> I don't see how it makes it problematic for testing. git-subtree [1]
> might be of your interest too.
>
> [1] https://github.com/apenwarr/git-subtree
> --
> Duy
>

Thanks! Again, I need to go and do some reading to see if those things
fit my needs.
