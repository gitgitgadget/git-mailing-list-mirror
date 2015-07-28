From: Chris Packham <judge.packham@gmail.com>
Subject: Re: default configuration files on cygwin
Date: Tue, 28 Jul 2015 22:57:36 +1200
Message-ID: <CAFOYHZB2u8JjvaUvcd_RU8_=8c_M0yUeCs_b5_pZasKoGtdgMg@mail.gmail.com>
References: <55B72AF0.90208@centralesupelec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Filippo Gatti <filippo.gatti@centralesupelec.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 12:57:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK2Zt-00085z-2s
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 12:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbbG1K5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 06:57:39 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34329 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356AbbG1K5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 06:57:37 -0400
Received: by igk11 with SMTP id 11so100949409igk.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HnwCe7uqCswzrvZN+0SXMK0ezHqUB2C8DpfEYkwy/sA=;
        b=KGGlL3CcellaIkLNWIXuSN8Zj5DR8aS0PrqZ5YoyJn4Ftq0FX1Z2/IDJ6w+N8NmP6z
         gcTo21fouMwePvMVBxhNQSECibcr+a4qBkIwFSni/kovPSdT1BH1Xn1FeQAbaY3aYumR
         xKT9Djmkqxpk0O180+dPq3whxkxebhOKv9f4EwhG476S3NFV2r/F6WqtGMQLmqCVQxlQ
         +oxA9hllXthSzyuHCw5pwWfw/kOcBlKHSXLW0h7GVsS1ExkagC2OQvYmQ+rdz1MlPjBi
         E4o8lv06ND6uW/SEk7hM9KrquAblnulq8FP7ddmYnqF06K2TTYorrnKyGSGvNJQP2DN5
         4ZBw==
X-Received: by 10.107.136.152 with SMTP id s24mr51471488ioi.165.1438081056951;
 Tue, 28 Jul 2015 03:57:36 -0700 (PDT)
Received: by 10.79.116.130 with HTTP; Tue, 28 Jul 2015 03:57:36 -0700 (PDT)
In-Reply-To: <55B72AF0.90208@centralesupelec.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274766>

On Tue, Jul 28, 2015 at 7:10 PM, Filippo Gatti
<filippo.gatti@centralesupelec.fr> wrote:
> Hi,
>
> I'm currently running git on a cygwin platform.
> I would like to know how i can set up a sort of configuration file to launch
> automatically the ssh-agent and get connected to github (for istance)
> directly.

I'm not a regular cygwin user so I can't give you a direct answer, but
perhaps you need to ask the right question (or at least explain your
use-case).

The point with git (or any other DVCS) is that it does not need to
connect to anything until you want to publish your changes (i.e. git
push) or incorporate changes someone else has published (i.e. git
pull). These are the (main) cases where git will actually connect to a
remote the rest of the time everything is happening locally on your
local copy of the repository.
