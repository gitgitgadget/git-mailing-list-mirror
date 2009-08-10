From: John Tapsell <johnflux@gmail.com>
Subject: Re: backups with git
Date: Mon, 10 Aug 2009 11:51:13 +0100
Message-ID: <43d8ce650908100351w10e4d49cne8cff6f7e900f07a@mail.gmail.com>
References: <41CB836B-6057-448E-805F-F25EAF765D27@roalddevries.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Roald de Vries <rdv@roalddevries.nl>
X-From: git-owner@vger.kernel.org Mon Aug 10 12:51:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaSTK-0006rE-Kv
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 12:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbZHJKvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 06:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753794AbZHJKvO
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 06:51:14 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:49128 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbZHJKvN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 06:51:13 -0400
Received: by gxk9 with SMTP id 9so4007890gxk.13
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 03:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6a/r5DwTHIDa3jmN+CYHM+BjQ3pvj+Cdkj76nzSOb5w=;
        b=swqZc4EwzBbaJ28o2fYQDjVo8WxGafkPkrHTuvrSlqpKz80d/IyoalPFeY6bt1iL56
         WM767JMDxoBZb9uI+iZ/pHkiErvHvl4oxz/rtheocwWdlKFhjRB8qfLe3+xT9uNZom4A
         6X42ms3fi+jx/Ume1bX2wlhmr78ycNE6gobhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KXavbIiGj4wpwAmvbsXtEnaKQmvL0tz6Ztgq4zUA/fgJyCqX26MxRFNb768LDRPNdS
         c3NlAH8arquwk+lnJ2XaAmbJF12dXDgJ6HD8I+YGhii9R+3QtdjDYO78F/ro0btNWVIU
         5e6haX2LZq5ZrwKVqGhR8dMHXtWChWteoxF4o=
Received: by 10.151.78.9 with SMTP id f9mr7906082ybl.329.1249901473700; Mon, 
	10 Aug 2009 03:51:13 -0700 (PDT)
In-Reply-To: <41CB836B-6057-448E-805F-F25EAF765D27@roalddevries.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125431>

2009/8/10 Roald de Vries <rdv@roalddevries.nl>:
> Dear all,
>
> I'm thinking of using git as a backup solution for my whole system, setting
> my $GIT_DIR to something like "/backupdisc/backup". Does that seem sensible?
> In his Google tech talk, Linus said that git was not good at huge projects;
> I guess that would apply to backups. On the other hand, maybe a backup
> doesn't need to be as fast as he wants git to be for projects. Has anybody
> used git like this? And was it a good experience?

Perhaps you want something more like btrfs.

John
