From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Segfault during merge
Date: Thu, 07 May 2009 03:17:54 -0700 (PDT)
Message-ID: <m3y6t9md2u.fsf@localhost.localdomain>
References: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave O <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 12:18:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M20gW-00072N-EO
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 12:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbZEGKR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 06:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbZEGKR5
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 06:17:57 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:3275 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbZEGKR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 06:17:56 -0400
Received: by wf-out-1314.google.com with SMTP id 26so641884wfd.4
        for <git@vger.kernel.org>; Thu, 07 May 2009 03:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=kA1eM2g1vpEleIqdM8MdDh4E+KD/ftOcJJIcuvEE0tA=;
        b=iDoU8FS1yDwhIqI5GDhAtZ5Q2c76d3wJZlT8k0bQTGSKW3wDkaf+681r9PrHu3PoYS
         6UUyJr9W/CljIkdDQdchy8goZGc8Z0AEth5oxQ5eI/XsNCB4hQ1drD59+G+T8nhmYWgv
         0UDXSq0rrK7hKEHZ5ApVo9REHS2gHjmfgTjjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=MxRP/sldHUI2AF30/PYhzWCyzfm7xVgx6MSbVTRX9LoiG1O/3YgqBGDiOxJYmBtDJu
         B8x0ZZx14iiAJu78/2pL2xSGRjC4rQhN3TnHFEyMjyoAhzyfMo7U4QtfjqPyMZizc/f/
         W/9loUEFANHacRyP2+dTs82pb2EOSkANXqVGA=
Received: by 10.143.13.17 with SMTP id q17mr1073110wfi.222.1241691475850;
        Thu, 07 May 2009 03:17:55 -0700 (PDT)
Received: from localhost.localdomain (abwu219.neoplus.adsl.tpnet.pl [83.8.244.219])
        by mx.google.com with ESMTPS id 32sm488394wfa.13.2009.05.07.03.17.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 May 2009 03:17:54 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n47AHmfv000989;
	Thu, 7 May 2009 12:17:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n47AHjND000986;
	Thu, 7 May 2009 12:17:45 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118460>

Dave O <cxreg@pobox.com> writes:

> Hi, I've encountered a particular merge that causes a segfault, and was
> able to successfully bisect git to commit 36e3b5e.  However, I'm unable
> to come up with a simple repro that doesn't involve the source tree that
> I found it on, which unfortunately I'm not able to share.

[...]
> Please let me know how I can further help debug this issue, or possibly
> come up with a repro that will help someone else debug it.  Thanks!

Couldn't you use repository anonymizing tool (which replaces all
content, but preserves shape of history) which was published as
example some time ago on git mailing list?  Unfortunately I don't
have it bookmarked, so you would have to search for it yourself.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
