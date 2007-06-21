From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: Strange diff behavior?
Date: Thu, 21 Jun 2007 00:02:20 -0700
Message-ID: <31e9dd080706210002q4703f464xafa07359f98878cf@mail.gmail.com>
References: <31e9dd080706201802h9dcbffawd82575d09e082155@mail.gmail.com>
	 <20070621065043.GA30521@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 09:02:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1GgS-0004d6-Qo
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 09:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbXFUHCX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 03:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbXFUHCW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 03:02:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:25566 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbXFUHCW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 03:02:22 -0400
Received: by wx-out-0506.google.com with SMTP id t15so429579wxc
        for <git@vger.kernel.org>; Thu, 21 Jun 2007 00:02:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZmO62VMOR3F+Ys59kjWPWkDXn4NYej1SJYateN5scZ/6MmzzP8QHOqvs+DL5yKbN4OscU5Cv8//4nZChi5ma4V4d1fZBFZ0D893fCgbKULjRkHTfkp3skWSZRgTi1/QkqRoEHb1HPfLpJ3mw1wyeNVRl6pvuA/g4uLooZFFAmfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TCoZ1NlpnyMK0GO9QhA8Cp6dRoY2v8jig53RETxXWWrQ8qnyxEWE5by1EoT8zW1sCinBU8F0cMiJTgESfGsKFhVEVLf5ICioo+MOldFKlNM6KUY/IIoIaDpbzdlPCwg3za+avw9MwFN2vC4VodkvpCfAmUnL7N2rSzCU748kgFo=
Received: by 10.90.90.16 with SMTP id n16mr1271635agb.1182409340583;
        Thu, 21 Jun 2007 00:02:20 -0700 (PDT)
Received: by 10.90.54.18 with HTTP; Thu, 21 Jun 2007 00:02:20 -0700 (PDT)
In-Reply-To: <20070621065043.GA30521@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50603>

As I mentioned in the ps, I git-diff --check shows nothing. As a
matter of fact, I do have color turned on and the pluses are green and
minuses red, but there are none of the characteristic red blocks that
trailing whitespace makes.

On 6/20/07, Matthias Lederhofer <matled@gmx.net> wrote:
> Jason Sewall <jasonsewall@gmail.com> wrote:
> > It seems like every change listed after the first one is meaningless.
> > I really think I just don't understand something about the diff
> > algorithm. Can someone tell my why those empty lines are recorded as
> > changes?
>
> This are whitespace changes.
>
>     $ git diff --color
>
> marks whitespaces at the end of the line with a red background color
> so you can see what changed.  I also use vim with :set list to see
> whitespace changes, e.g.
>
>     $ git diff | vim -c 'set list' -
>
> If you like to have colors (not just in diff) permnanently you can add
> this to your .git/config or ~/.gitconfig:
>
>     [color]
>         branch = auto
>         diff = auto
>         status = auto
>         pager = true
>
> See also git-config(1) for more information on these and other
> configuration options.
>
