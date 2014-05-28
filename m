From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Summary of the problems with git pull
Date: Wed, 28 May 2014 09:13:32 +0200
Message-ID: <CAGK7Mr4uucBN=17ph5pBjrz7yP60By1sERU9oBL+c2-gsMDmrw@mail.gmail.com>
References: <5366db742d494_18f9e4b308aa@nysa.notmuch> <536de90320f06_239010732fc82@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"W. Trevor King" <wking@tremily.us>,
	Philip Oakley <philipoakley@iee.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Richard Hansen <rhansen@bbn.com>, Andreas Krey <a.krey@gmx.de>,
	Marat Radchenko <marat@slonopotamus.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 09:14:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpY3t-0006Rn-NT
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 09:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153AbaE1HOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 03:14:05 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:50910 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbaE1HOE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 03:14:04 -0400
Received: by mail-oa0-f54.google.com with SMTP id j17so10870837oag.27
        for <git@vger.kernel.org>; Wed, 28 May 2014 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=x6oYewtrj+PHkTWJH2kg+fDoKqVQatKSzTjwpUuJoI8=;
        b=pt5vPMBphDFdJgIAfML6+lX1tg4WWkFhDd4IMNKG3OY8M6WG5cTWkpPKAR7nN7C6Cn
         plGFd8RXdLtHKEJZ5F2WQXSlHZe2ITek0E97idCz+YVwh27Rexgl/NVuuZKCyrrmU/DA
         2cDlPRpKCDARX5IvPYRnbDEFBmEjn8cgqxcsBnfWJRR5nnKSuHAM/orLQT9LZ5dGExyi
         YdavTJoAYKsab05e19e15b0Wi/5CPMoSqjCNfdAdnWrI1q3t3LtNCISSKcBbT0BClUXk
         ZmgBE//wija57rMj0IgaPE2zwxueh/G51dMTabRogbrTQcYGtjnRwG2C6EUuwYLWiCrn
         J/ow==
X-Received: by 10.60.52.207 with SMTP id v15mr39182601oeo.19.1401261243058;
 Wed, 28 May 2014 00:14:03 -0700 (PDT)
Received: by 10.76.76.228 with HTTP; Wed, 28 May 2014 00:13:32 -0700 (PDT)
In-Reply-To: <536de90320f06_239010732fc82@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250268>

> Felipe Contreras wrote:
>> == git update ==
>>
>> Another proposed solution is to have a new command: `git update`. This
>> command would be similar to `git pull --ff-only` by default, but it
>> could be configured to do merges instead, and when doing so in reverse.
>
> And here it is:
>
> https://github.com/felipec/git/commits/fc/update
>
> Here's the documentation:
>
> https://github.com/felipec/git/wiki/git-update
>
> Works exactly as expected: non-fast-forwards are rejected by default,
> but can be configured, and parents are reversed when merging.

I know patches from Felipe are sensitive subject and that a lot of
people probably simply ignore him entirely, however I think this patch
deserves more attention.

>From what I read, it seems to really improve the "pull" issues and is
more or less in line with what Junio suggested what should be done in
[1]. So the goal of this mail is just to make sure people consider it
for inclusion.

Sorry if I missed a thread where it was already decided not to include it.

Felipe, please don't use this to start any non-constructive behavior
(rant on who is right/wrong, "my patches are not accepted", etc).

Philippe

[1] http://article.gmane.org/gmane.comp.version-control.git/248258
