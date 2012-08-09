From: Andrey Pavlenko <andrey.a.pavlenko@gmail.com>
Subject: Re: fast-import error: fatal: 'refs/heads/master' - not a valid ref
Date: Thu, 9 Aug 2012 12:42:03 +0400
Message-ID: <CAHSUVA5hUODLyqL=nqzSuJxBMrWNZeJmLp2+HwJKVN7DU8HPQg@mail.gmail.com>
References: <CAHSUVA5y1nZG69JbvC-wbmHhjyBGLx8Z2TM3htEyuCsWj=A+aw@mail.gmail.com>
	<20120808175433.GA12772@sigill.intra.peff.net>
	<CAHSUVA4muWPh7jYNJNsPP4=_g0z98QQmz6fzraVkKfyDgE_rcw@mail.gmail.com>
Reply-To: andrey.a.pavlenko@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 09 10:42:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzOJt-0005vx-HP
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 10:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab2HIImK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 04:42:10 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:50459 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2HIImF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 04:42:05 -0400
Received: by wibhm11 with SMTP id hm11so119284wib.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 01:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=xNE4Plk46X6uqVXAS+mbtUoRXoqMHFZkyYzIwe7XeOc=;
        b=mnpM1CX0dUbtI93NJpWWWaHWSQGs30zrHpIP1QkFQInu78gbcP5XWwXUMOzQYPBmhH
         p9dZJP+z854iH4a3XccSIMjKlpggpBAJ9YYpuH37CxZhi4pBVZO7q/2eYYEGy2vzopim
         rIT5cYbueMXuXISzbaDgckNwFlvs9Bu7jgNoHuGFVjF+UUfhNRXeBDeTQyneoZP4f5TB
         l0NKtbmtoTvvczkdLlrI9dFs7sKKA5D7edDQpbTquYM8jfdliQLLujH3h2Z6H3/m74Qu
         u3D1yfOEdaisBF+bb+xW4fUH7Nq0yr1GcjNOKxdR/IwYi1jYVnGbZLP3PQERILQVX/WC
         scaw==
Received: by 10.216.68.2 with SMTP id k2mr10661207wed.69.1344501723720; Thu,
 09 Aug 2012 01:42:03 -0700 (PDT)
Received: by 10.216.152.164 with HTTP; Thu, 9 Aug 2012 01:42:03 -0700 (PDT)
In-Reply-To: <CAHSUVA4muWPh7jYNJNsPP4=_g0z98QQmz6fzraVkKfyDgE_rcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203156>

My helper really executes git show-ref before writting the export stream...
Thank you for pointing that out and sorry for disturbing.

On Thu, Aug 9, 2012 at 12:22 PM, Andrey Pavlenko
<andrey.a.pavlenko@gmail.com> wrote:
> git --version
> git version 1.7.11.3
>
> On Wed, Aug 8, 2012 at 9:54 PM, Jeff King <peff@peff.net> wrote:
>> On Wed, Aug 08, 2012 at 11:25:02AM +0400, Andrey Pavlenko wrote:
>>
>>> I'm developing a remote helper which uses the fast-import stream for
>>> fetching. When I perform cloning git prints error message - "fatal:
>>> 'refs/heads/master' - not a valid ref", however the clonning completes
>>> normally. Each my fast-import commit command starts with "commit
>>> refs/heads/master" header.
>>>
>>> What does this error message mean and how can I fix it?
>>
>> What version of git are you using? The only command which produces that
>> exact message is "git show-ref", and it is not called by current
>> versions of the cloning process (but it used to be in old versions).
>>
>> -Peff
