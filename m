From: SASAKI Suguru <sss.sonik@gmail.com>
Subject: Re: SP in committer line in fast-import stream
Date: Tue, 19 Jul 2011 04:10:13 +0900
Message-ID: <CAE3X6mx+X=ptcXTXmm2GaKKU1nag4P+cp_e6NRAcN5bgaob7Cg@mail.gmail.com>
References: <CAE3X6mwJquoHj06FVGTsg0qtzyTwbd6gNqy7J4yWiVF-+p-23Q@mail.gmail.com>
	<loom.20110718T172927-173@post.gmane.org>
	<CAE3X6mxbMBwd5O+md0J3M6DUu38Q1uzDHNhAU7iGbqYVm2TyRw@mail.gmail.com>
	<loom.20110718T184404-335@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 21:10:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QitCx-0005eu-GV
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 21:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab1GRTKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 15:10:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62071 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab1GRTKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 15:10:15 -0400
Received: by iyb12 with SMTP id 12so3377443iyb.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=EhoxEaLY4YV7kx443/DtNdxz+Sp2Gv2zyoJdfadB9dY=;
        b=CVbQbHzLDqbI4er4/M3amrwkMkazmZ/bBSWaWfBNpVh6KF6g62nFMBqsUQpq9IF36N
         5lt5d0jWApLyG3t3ExSqVl7zYa1RR+Nk2VfP99ODjYrvormIyscq0LcELmHBYu54ftd6
         Uhlz2vaqLE1kmzZMNhGB0GSQ68aPUXjeVVWTc=
Received: by 10.231.17.10 with SMTP id q10mr2886344iba.179.1311016214046; Mon,
 18 Jul 2011 12:10:14 -0700 (PDT)
Received: by 10.231.43.9 with HTTP; Mon, 18 Jul 2011 12:10:13 -0700 (PDT)
In-Reply-To: <loom.20110718T184404-335@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177398>

Hi,


(2011-07-19 01:57), Dmitry Ivankov wrote:
> One patch is at the bottom,
 > it makes fast-import behave well on proper input streams like yours.

Thanks.
fast-import with you patch has worked well on these input streams.

> Making fast-import stricter is worthy but will be a larger patch and effort.

Exactly.

> I'll try not to forget about and at least to write some failing tests.

Addinng tests to t/t9300-fast-import.sh ?
If tests on input streams like these streams of mine will do,
I'll write some failing tests.  Will they?


Regards,

-- 
SASAKI Suguru
   mailto:sss.sonik@gmail.com
