From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git-archive ignores submodules
Date: Mon, 20 Apr 2015 20:51:54 +1200
Message-ID: <CAFOYHZAZvidjtTzyhF2_nD_bi27H-h=GT4F-MKm+h3RT5LB_gw@mail.gmail.com>
References: <CAL1ZDKZs++NkLoHZ_w_YebQuZYG3rgAiH5SsaQfTmb9MPHjR3w@mail.gmail.com>
	<20150416175623.GJ21868@paksenarrion.iveqy.com>
	<CAL1ZDKbcmrer481fRY2NEHUQ1J5tjRbHz2yLEcszh3Q-NjcvcQ@mail.gmail.com>
	<5530076E.50605@web.de>
	<CAL1ZDKbvNvTA3CFg5iWMYpOVDbxFwtpFCu+PO2onssO=+pw5XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	GIT <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pedro Rodrigues <prodrigues1990@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 10:52:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk7Qt-0003Na-RM
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 10:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbbDTIvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 04:51:55 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34580 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbbDTIvz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 04:51:55 -0400
Received: by pdbqa5 with SMTP id qa5so201228457pdb.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5SX+kgympjOU7cs6nxMRStK8Dv9XF2SnkM7A06QlNRs=;
        b=ep7f0gIYcroKTT2zzStKB1Bn5QCriL9RSQx/5zSjLZ5KAIAyHCT++gsmC9wdAguqxE
         rirHW0fwsV6jORYt0k2O8xAPc283C7TzhAjSkgZu34J20yLmqsJV5p0RZidhznPVc3Zp
         coMNbTmUQn1976k875nOpliNAp5U+lq7n6CD+2hsoLGtFAKkuh1n0T9BwlklXXrkfTju
         4JueNPvQA4mPNqGcmrjkHso1id+X54oyKHOebzYCP36IhjoMBzZko6R1aRTR736Vd+O2
         1Kwfy0eD1P9FUKuyRpGTLXsZouuSLMbNT0zWTupO/ioN4OlSbKL8111iPy7YOWwy0qPV
         N/pA==
X-Received: by 10.68.248.39 with SMTP id yj7mr26388452pbc.58.1429519914589;
 Mon, 20 Apr 2015 01:51:54 -0700 (PDT)
Received: by 10.70.41.162 with HTTP; Mon, 20 Apr 2015 01:51:54 -0700 (PDT)
In-Reply-To: <CAL1ZDKbvNvTA3CFg5iWMYpOVDbxFwtpFCu+PO2onssO=+pw5XQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267459>

On Fri, Apr 17, 2015 at 7:59 AM, Pedro Rodrigues
<prodrigues1990@gmail.com> wrote:
<snip>

> Not completely off topic, but for consistency consider that:
> git-clone supports --recursive and --recurse-submodules, which do the
> same thing.
> git-pull and git-push only support --recurse-submodules.

It took a while to get the terminology sorted but the eventual
agreement[1] was "--recurse-submodules" was the best generally
applicable flag for all commands. For backwards compatibility some
commands that already had "--recursive" as an option have retained it

--
[1] - http://article.gmane.org/gmane.comp.version-control.git/160634
