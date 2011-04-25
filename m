From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: RFC: Folder Git
Date: Mon, 25 Apr 2011 03:39:31 -0700 (PDT)
Message-ID: <m3fwp6wr7h.fsf@localhost.localdomain>
References: <BANLkTim=xKxN9JovToVuOg=SQ2Mba1LvxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Victor Engmark <victor.engmark@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 12:39:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEJCc-00075l-Qk
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 12:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758269Ab1DYKje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 06:39:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37895 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758232Ab1DYKjd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 06:39:33 -0400
Received: by fxm17 with SMTP id 17so1229431fxm.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 03:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=8AHwPU9Z3jvO/Au5XZe+DulkyP/cMzhg902dHe03TZE=;
        b=cgipkVxRumeWuGJs64NmJJPF307PNNmnvqdXzGI0HCUPgNEcJ6YnkvsQt5pNoC4APr
         SuLmoTutZUA4+U5y8XAhsG3O/ExYdCTADI+Yjq00efVnl/wQNCxUkTxMGHDzWXdmNUaa
         WGjAhHQBN+jZJo+UYEPv4yU6rX+5snew2J52c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=XtXwH8MIg3tze9eoIn7L9XFt1nvLG3i+2QKyyTj0qRvbr9fNrPErEailv/g/cxh/NE
         LiZN2lA/sJjtwL15Ahn9cIo5FKnttis/ahjvR7XcogMP5omBstaMhQqzgvIcsiLd0dKI
         t7aG7EcX8jNYsxJtWvCzhocBevWIvmV+SBVgA=
Received: by 10.223.28.19 with SMTP id k19mr500784fac.139.1303727972647;
        Mon, 25 Apr 2011 03:39:32 -0700 (PDT)
Received: from localhost.localdomain (abwn49.neoplus.adsl.tpnet.pl [83.8.237.49])
        by mx.google.com with ESMTPS id l3sm1653050fap.12.2011.04.25.03.39.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Apr 2011 03:39:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3PAd9QD020930;
	Mon, 25 Apr 2011 12:39:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3PAcwrg020689;
	Mon, 25 Apr 2011 12:38:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTim=xKxN9JovToVuOg=SQ2Mba1LvxQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172023>

Victor Engmark <victor.engmark@gmail.com> writes:

[...]
> I wrote a script for it: fgit
> <https://github.com/l0b0/fgit/blob/master/fgit.sh>. Features include:
> * Runs the Git command given in all specified directories which have a
> .git subdirectory, and warns about any that lack this directory.
> * Should work with any path, containing spaces, newlines or other
> exotic characters.
> * Should work with any Git command that doesn't require the "--"
> separator between the options and arguments.
> * Prints the Git command before running it, for logging and repetition.
> * errexit and nounset are active for each line, with one exception:
> errexit is disabled for the running of the command, to allow it to
> continue to other repositories.

Do you think this tool is mature and stable enough to add it to

  https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

page on Git Wiki?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
