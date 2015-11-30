From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v6] Add git-grep threads param
Date: Mon, 30 Nov 2015 20:45:24 +0100
Message-ID: <CACsJy8CyV9K8Kxwd-nOugjsTXN09afJFnXwR9mOE5FpA_hWacg@mail.gmail.com>
References: <1447242770-20753-1-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Victor Leschuk <vleschuk@accesssoftek.com>
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 20:46:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3UOf-0008Aq-AL
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 20:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbbK3Tp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 14:45:56 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35639 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbbK3Tp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 14:45:56 -0500
Received: by lfdl133 with SMTP id l133so210745280lfd.2
        for <git@vger.kernel.org>; Mon, 30 Nov 2015 11:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RsjsySSuqXtVnyd5wMpzfMp9g/Em/keNmZedlKOa2uM=;
        b=KsUOapHmSmeeFKJ0xioouqTvUsq5MzJU3719yV5WX7vgIemUEWmBgp7kllr+KTEe3Y
         XCmlDFmO4Y7F2+BluQfZJmprEVc+DCnwmtNK5KEglz4d7O2er+MrEXD8LZb3ElIn9kdb
         ePuIJ2XeaJBW5hW5ds/GEcYFKSjNjqvNdt1aklCmR2CO8QpoWcbaPutSLJMtA+ajN3nP
         YBLkCCbwtCKKXs2HNjEfRkjZtClnE9bwdQMaG/CCZ6d945av1r72jST9ENPvOqlyPZKX
         9snBI3UY3DXPmwEk78Hl4FCTWBRtcD8I00FH4w21Peg4DQKmv2b42pT+Sxqt10vAPKAI
         +hiQ==
X-Received: by 10.112.16.135 with SMTP id g7mr27426736lbd.80.1448912754383;
 Mon, 30 Nov 2015 11:45:54 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Mon, 30 Nov 2015 11:45:24 -0800 (PST)
In-Reply-To: <1447242770-20753-1-git-send-email-vleschuk@accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281819>

I forgot..

On Wed, Nov 11, 2015 at 12:52 PM, Victor Leschuk <vleschuk@gmail.com> wrote:
> +       else if (num_threads < 0)
> +               die("Invalid number of threads specified (%d)", num_threads);

Please wrap this string with _() so it can be translated
-- 
Duy
