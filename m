From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-rebase.sh: Update USAGE string
Date: Sun, 03 Feb 2008 13:14:21 -0800 (PST)
Message-ID: <m3prvd68uy.fsf@localhost.localdomain>
References: <prvd3i9e.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Feb 03 22:15:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLmAz-0007TX-OJ
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 22:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbYBCVO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 16:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbYBCVO0
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 16:14:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:36811 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbYBCVOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 16:14:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1053384ugc.16
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 13:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=NwXN3B4A7bdnr8c1k9KgCpZs4cr3uX3tK2VfFuCLHPc=;
        b=k5X0k2PHOrlI0idcjdXOT1R8xrtH3i3w1VKp96O+csRXKkZYJ7Yf1cxBwPmjt6PPZoJHF/ctaf0E0HEYoDsjS1kn5CNM+zi+j8UqO7SmYnj7D7Th7vNG4kFgCrL1hJHvIJR4pjeN13zS1Mq40dG8eAYN0IzR7nLPjHsG4EWfpFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=LlDI3laKa5L4H2y/ssQ1qiUoKiWhYL8wHBpjZw22yCmLVal8B/gOk1YXDJED69DMGm0uP1NwDJNBvKTSAQ5fsaAaMKQ0XbtAY2br08OZEZ7sTBqd90yKJ5l0LQmmEC0KVh+opX97z0ArOMpe3O/ng5STpSeWiOHmR3jXTDS707Y=
Received: by 10.67.30.13 with SMTP id h13mr1771904ugj.45.1202073262824;
        Sun, 03 Feb 2008 13:14:22 -0800 (PST)
Received: from localhost.localdomain ( [83.8.194.5])
        by mx.google.com with ESMTPS id m1sm5872172ugc.51.2008.02.03.13.14.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 13:14:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m13LEFGw007580;
	Sun, 3 Feb 2008 22:14:15 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m13LEEw9007576;
	Sun, 3 Feb 2008 22:14:14 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <prvd3i9e.fsf@blue.sea.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72402>

Jari Aalto <jari.aalto@cante.net> writes:

> Present the options in -s|--long (short, long) order.

This is a good change (but might not make sense without the following
one)...

> Mention merge and new whitespace option.

...and this is not; usage string is now too long.

Please either use placeholder ([<whitespace>]), or enumerate
only short version of commands ([-i] [-v] [-m]) in synopsis,
or break synopsis into lines 80-column lines max.

> -USAGE='[--interactive | -i] [-v] [--onto <newbase>] <upstream> [<branch>]'
> +USAGE='[-i|--interactive] [-v|--verbose] [--whitespace={nowarn|warn|error|error-all|strip}] [-m|--merge] [--onto <newbase>] <upstream> [<branch>]'

-- 
Jakub Narebski
Poland
ShadeHawk on #git
