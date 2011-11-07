From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: BUG. Git config pager when --edit
Date: Mon, 7 Nov 2011 14:43:41 +0100
Message-ID: <CAH6sp9Ox+6p4RkjCZ0j3tXG9F4u7SPuwbSrOWmLSXic9DxSKiQ@mail.gmail.com>
References: <20111107172652.0faade61@ashu.dyn.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 14:43:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNPUI-0000YP-Ss
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 14:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567Ab1KGNnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 08:43:42 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34901 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab1KGNnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 08:43:41 -0500
Received: by qao25 with SMTP id 25so591253qao.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 05:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=obyOprC/sAXoejQJ+5DusbeHW7FtK59eqxeMrnH2S0U=;
        b=sGC70fZBtLEnaxH5N4JLXrYsZ1oJ31Ake0tOutMevh54JqMbGc7ysc1TvEvSsWQRsh
         SzwBvS5dwPsV2ofhaeQzkkLtPYoid/pCCcXp7UemZ0BMjwsggxVgiBaOyofO4S2Tgh4S
         pgLDcQTb32s7NeBrGtfl0UAM17RGWxFc/58t4=
Received: by 10.224.202.8 with SMTP id fc8mr12863894qab.10.1320673421205; Mon,
 07 Nov 2011 05:43:41 -0800 (PST)
Received: by 10.224.80.149 with HTTP; Mon, 7 Nov 2011 05:43:41 -0800 (PST)
In-Reply-To: <20111107172652.0faade61@ashu.dyn.rarus.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184984>

Hi,

On Mon, Nov 7, 2011 at 2:26 PM, Alexey Shumkin <Alex.Crezoff@gmail.com> wrote:

> As far as my config is large enough to be paged I set pager.config=less
> setting. But since that moment when I run
> $ git config --edit
> I get
> Vim: Warning: Output is not to a terminal
> And some messed config output
>
> The same happens if to run
> $ vim .git/config | less

So git is trying to tell vim to pipe its output to less. vim can't do
that because it needs a terminal, as it's the only way vim is usable.

Should pager.config then only be used with --list?
