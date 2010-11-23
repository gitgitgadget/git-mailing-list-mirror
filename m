From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] rebase -i: remove undocumented '--verify' flag
Date: Mon, 22 Nov 2010 18:24:10 -0800
Message-ID: <CA8E4FB8-70F7-415C-85DE-746B1113AE4C@sb.org>
References: <1290408504-14639-1-git-send-email-martin.von.zweigbergk@gmail.com> <vpqoc9hsemy.fsf@bauges.imag.fr> <201011221414.15982.trast@student.ethz.ch> <vpq8w0lqyf7.fsf@bauges.imag.fr> <alpine.DEB.1.10.1011222103290.17721@debian>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 03:24:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKiYM-0003X5-Tj
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 03:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173Ab0KWCYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 21:24:14 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59285 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab0KWCYN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 21:24:13 -0500
Received: by pzk6 with SMTP id 6so311917pzk.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 18:24:13 -0800 (PST)
Received: by 10.142.79.20 with SMTP id c20mr5829338wfb.243.1290479053137;
        Mon, 22 Nov 2010 18:24:13 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id y42sm7221548wfd.10.2010.11.22.18.24.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 18:24:12 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1011222103290.17721@debian>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161925>

On Nov 22, 2010, at 12:21 PM, Martin von Zweigbergk wrote:

> (I hope this is the correct way of including a patch. I have only used
> 'git send-email before'. I noticed that Jeff seems to remove the first
> three lines and put a '-- 8> --' before, but others do not. What does
> the mysterious header mean?)

It's actually 8< or >8, and it's a little ASCII icon of a pair of scissors.
If a line consists mainly of dashes and scissors then `git am --scissors`
can split the mail on that line and treat the rest of the body after that
line as a patch.

-Kevin Ballard
