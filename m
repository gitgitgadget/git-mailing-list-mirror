From: Yang Yu <yang.yu.list@gmail.com>
Subject: Re: git repository modified after migration
Date: Mon, 11 Jan 2016 11:48:46 -0600
Message-ID: <CAFwKRnRV7dx49+dku13b--W2g9t=OJiyuT2O_dv4ZZ3PdD1v3g@mail.gmail.com>
References: <CAFwKRnQ_EZ73DBfrb0HNks3dt3=YJbLRoHvB0mfsD9FA-ey6hA@mail.gmail.com>
 <5693C48A.7060801@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:49:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIgax-0006IY-Lu
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760414AbcAKRt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:49:27 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37423 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759576AbcAKRt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:49:27 -0500
Received: by mail-wm0-f45.google.com with SMTP id f206so281317993wmf.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 09:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6vMGGO+aWZiU56ejHPrufOKPII4g/mnj3B7TGjWfDq4=;
        b=KysywISUswBHb5BN9w1Yj7aO9URIUugyLmSept+3n0BebQdeteBZLPP98yVve8gd4c
         gKl36pGbC1lgE5anlJIK7lM/E6E+sPDgTgIDwHdbpf1mzKRnwvdTlZ+1dE3mmi4h8xhk
         PN8seF+MhbpJaW2BV8LzYgmxWx5K0/s61MnQ0YZTDBhOLC9WGHj9eKYObk5jGsqkuNuX
         dazYdOM35uo5LQJ0VED5lh2ytEveCFovQ1r7GZmjhX96RqpTE4c5xAnJFFZYJM+TYmU6
         4omosrbLbXgwin4n/IraDMAPLfvN63lRbn9z+PKeVibm9epnP4tRFpi4vqisB8JNrGCn
         FtCQ==
X-Received: by 10.28.5.213 with SMTP id 204mr13874500wmf.20.1452534565491;
 Mon, 11 Jan 2016 09:49:25 -0800 (PST)
Received: by 10.27.97.141 with HTTP; Mon, 11 Jan 2016 09:48:46 -0800 (PST)
In-Reply-To: <5693C48A.7060801@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283684>

On Mon, Jan 11, 2016 at 9:04 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> This happens whenever the "stat" information changes, e.g. due to
> changed device numbering and such. "git reset --hard" would have been
> the quickiest way to reset the stat cache/index - after git diff, of
> course ;)
>


Can you go into a bit more details about this? Why does it only affect
certain files (always these filed modified) on every host I tried?
Thanks.
