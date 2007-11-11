From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Sun, 11 Nov 2007 01:07:01 +0100
Message-ID: <8c5c35580711101607l7c45d6f5ge0f40ac6e447031a@mail.gmail.com>
References: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 01:07:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir0Mf-0006i3-S7
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 01:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556AbXKKAHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 19:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755757AbXKKAHE
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 19:07:04 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:10052 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556AbXKKAHC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 19:07:02 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1051958wah
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 16:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=V/4d6BMHYc6oBUFxsTnj7bIYryhuL3viPrOcpufz3sQ=;
        b=Gqa+IlbWuQDX9PcJViTEgnWais0kAqzzsy0iayjD+aF34VebcZseIZ9ByjKnf5kcFnnDX0u94OchGWrcbmC62FoNJPkS+gn8zRvx4zhJuZJp7WbtdLfLZ4QfAC/Vi/l1uuwE1LOJdbACiK4vo6uDdcMe7WIhF7FP9W6O0fBBpg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WXbSHTW+a2CFNEuj0TCqOFW/hWGzxMH3LodybWgWaNrD+JgvqDfOipl3Au7g/pZLIhBEhFUDNien/kXAZj++JbP/NzjXgZfXYis5y1KfioKPrmykYcL15NBoACbQ2eBhVSsv1sEGvhHmmywm3MTuDkNxd8vQxG95PIQ1/ybWwT0=
Received: by 10.115.90.1 with SMTP id s1mr1228414wal.1194739621813;
        Sat, 10 Nov 2007 16:07:01 -0800 (PST)
Received: by 10.114.235.4 with HTTP; Sat, 10 Nov 2007 16:07:01 -0800 (PST)
In-Reply-To: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64389>

On Nov 10, 2007 8:27 PM, Ping Yin <pkufranky@gmail.com> wrote:
> This commit teaches git status/commit to also show commits of user-cared
> modified submodules since HEAD (or HEAD^ if --amend option is on).

Some nitpicks:
-we'll need a config option to enable/disable this output in git-status
-the feature should probably be implemented in git-submodule.sh

--
larsh
