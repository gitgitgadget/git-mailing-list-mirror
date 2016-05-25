From: Austin English <austinenglish@gmail.com>
Subject: Re: Please add a git config option to make --show-signature the default
Date: Tue, 24 May 2016 22:58:13 -0500
Message-ID: <CACC5Q1c2s4yOtGAtKsepwnme7udq7yqyN7S5BfMHbi0L08XwzA@mail.gmail.com>
References: <57438568.60707@gmail.com> <alpine.DEB.2.20.1605241313440.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 25 05:59:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5PyE-00030k-QS
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 05:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbcEYD6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 23:58:54 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36289 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcEYD6y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 23:58:54 -0400
Received: by mail-io0-f179.google.com with SMTP id f8so24830567ioe.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 20:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0OsuQ23FwFC/aBj5Td/dktlJwxU1MbeMxNgk4+Xlg+o=;
        b=Ihub1CcrtGvx0H3+hh9pn0E9yJlZ9f1AXdvxluKkA+0fyH0zuJQ13ylOyOQILVEmel
         bgVl/u8zH3XJTlPBX1wb5imLurpmp7z0JugI6XzbngnRrylfXMR+s5stNIiYiYGe56YY
         ugMK0pW29p4MlWmVp11RVtpI9NQ0EgpvXpDRO2ZE/6QTr1kD6qm5VA2O6RTYxjrqrAmr
         de0Prz1LgHhMcI0gr0jU4MwMz07KLi7lXmH5fAw5RPbJSmrDUsGRhrPW1ui3uDiFbgHK
         UrYsL0+JfDybheyHlTNvl3rs+Vuyv4AAe/0zlwgAfBKXoW2Psf021b46udlV7mLIbBcK
         aXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0OsuQ23FwFC/aBj5Td/dktlJwxU1MbeMxNgk4+Xlg+o=;
        b=gCqWD+oLbTrCJ9uX2/Qm0vy9DVDLWoSKifr80jHvkpoX9M/gpXlxxcGCIO8K9g7+D9
         EmTXQAXHPOtuf8gJYwRyfhlC4mUVivB9Bw4KDytLtctoFZGMqzGlRWbP0Pjq296Z8+qy
         lRLWhLYddAr7tWArW+44nNz0NjCMqmTWLdXpSVtUllmgshaJMaVNh9Ze8B0kmBF4jyao
         s7LOH0EJAOGPTtnuB9J+qZutsxEdhpJNhVQARXSjkQQwQenjrOCDTVgr+UI70dfgH/Z7
         UQyVdytJrcLUf20qr9IN7Zw1XGOkzIBxtvbDsAeUnEvd4rha6CkRBDIUrhp7ok8GEJAv
         59Gw==
X-Gm-Message-State: ALyK8tI6VXGckp4/3uZCTVQ28tLEP6u80Gw2CoYri/RMmqpzTfjrM+Sy7T91KBxERGOPYVvdXB8ez+qbuMeGnQ==
X-Received: by 10.107.55.212 with SMTP id e203mr1841460ioa.108.1464148733257;
 Tue, 24 May 2016 20:58:53 -0700 (PDT)
Received: by 10.79.114.83 with HTTP; Tue, 24 May 2016 20:58:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605241313440.4449@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295554>

On Tue, May 24, 2016 at 6:20 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Austin,
>
> On Mon, 23 May 2016, Austin English wrote:
>
>> As stated in title, I'd like to see an option to enable GPG signature
>> by default.
>
> I see an option was mentioned in the mail's subject line, but no
> indication which command you want to assume implicitly that this option
> was passed.
>
> Care to elaborate?

My mistake, 'git show'.

>> I find this feature very useful and would like to enable it by default
>> on my machine, without having to resort to an alias in my ~/.bash_rc.
>
> You probably meant $HOME/.bashrc.

Well $HOME and ~ are functionally equivalent on bash, but yes I did
mistake the filename, thanks.

>> I asked in #git and checked the git repo, but I didn't see an option
>> listed for this.
>
> Since you are already a Git user, why not just use Git itself to
> investigate further? It is easy:
>
> 1. clone https://github.com/git/git
> 2. run `git grep show-signature` to figure out where this option is handled
> 3. open the corresponding file and find out where the flag is stored
> 4. use `git grep` again to determine whether there is another way to set
>    that flag

I used git to verify that there were no options for signature, which
led me to file a bug, but in the absence of a bug tracker, to this
mailing list.

> If there is no other way, why not go the whole nine yards and just come up
> with a patch? That is how many, many other improvements were made: users
> wanted a certain feature and then just went ahead and made it all happen.
>
> You will find it a rewarding experience, and you will also find that you
> will receive excellent help on this mailing list when you demonstrate your
> willingness to invest some of your own time into that project.

I'll keep that in mind. I have a full time job and several other open
source projects that I contribute to, so if I can find time, I'll try
to submit my own patch. In the meantime, it seems appropriate to file
a bug so that others can have the opportunity to solve the problem if
they're interested.

-- 
-Austin
