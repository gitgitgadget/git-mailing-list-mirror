From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v6 00/11] Column display
Date: Mon, 27 Feb 2012 07:40:03 +0700
Message-ID: <CACsJy8AyZcNSPEY8S0WczVu0ychGKr61BoBm0iy39ZsVM=zHpA@mail.gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com> <7vaa45dwq7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 01:41:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1oeS-0004N9-Bf
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 01:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab2B0Akf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 19:40:35 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:47630 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027Ab2B0Ake (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 19:40:34 -0500
Received: by werb13 with SMTP id b13so2470606wer.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 16:40:33 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.80.226 as permitted sender) client-ip=10.180.80.226;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.80.226 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.80.226])
        by 10.180.80.226 with SMTP id u2mr16267745wix.0.1330303233266 (num_hops = 1);
        Sun, 26 Feb 2012 16:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3J59LQvSh1tabxSKWwlo5qBegzLZoHIljOwk5ltdbmI=;
        b=qwHYQDfpNpNNocxSD9Xz/sQiu/gZ46j2OHNDYauLvMS9Qukn594hLkNyLplnDDwQqL
         K0JN5Ihl1sdK90Sy2I1UDAIJU1fVl/gH6FholoOh4kdh+ieMz3P8j+2QZC5HSXgkJj2O
         k1Ahg6nCYAV7h1iRvomt3xicjJaSV7+/YrMH0=
Received: by 10.180.80.226 with SMTP id u2mr12896133wix.0.1330303233231; Sun,
 26 Feb 2012 16:40:33 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Sun, 26 Feb 2012 16:40:03 -0800 (PST)
In-Reply-To: <7vaa45dwq7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191589>

2012/2/27 Junio C Hamano <gitster@pobox.com>:
> But I am very much reluctant to see us adding a "git column" subcommand; I
> cannot justify it myself because what it does is even less connected to
> git than the "--no-index" mode of grep/diff commands, i.e. it does not
> have much to do with "Git, the version control system".
>
> Shouldn't it be "test-column" that is useful during the hacking, much like
> "test-date", "test-chmtime", and "test_credential"?

It used to be test-column. But we would need an external program to
pipe through to minimize changing display code, especially when
display code can get complicated (e.g. git-tag for example). The other
reason is to get column display even when the command does not support
it (e.g. GIT_PAGER="git column" git diff --name-status HEAD~10)
-- 
Duy
