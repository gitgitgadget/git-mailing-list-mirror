From: "Sebastian Schuberth" <sschuberth@gmail.com>
Subject: Re: git diff --name-status does not always list changed files
Date: Thu, 28 Feb 2008 22:23:43 +0100
Message-ID: <bdca99240802281323x1ec904ddq914ac2c484e7c468@mail.gmail.com>
References: <fq6hhi$cub$1@ger.gmane.org>
	 <7vablkkhac.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 22:24:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUqEq-00084k-Ry
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 22:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbYB1VXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 16:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbYB1VXr
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 16:23:47 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:4827 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbYB1VXr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 16:23:47 -0500
Received: by wr-out-0506.google.com with SMTP id c48so5413180wra.23
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 13:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+mua//mZg/Lpy/kwe34IMlaXA3uMZ5wRQE4jLnheil4=;
        b=JFGT0lKveKhJub9VIl1c0pqycJjkFM02m7GohH4F3romN0cszO/yKcpRe1viOA29HjrYRJC7vhg494Rk0kxfGfKNoahYxXhVReEOtGqoRnpLFNCT2x8fkvQ9LVXmJn8FnxxBlLwZBHvC+pK4Qm7mOa9x0AIs2mEbBe1ErUFgr+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=USApbXnIGj+NU3cWZt6v7Pr20DBZHqL8fPlI0AUcdBjpxLRvaZ0Jsx/02XQDEHVUvFvDWtvuGRnukGBpuU9dqnqUwF0+IdXyoFAU+ZLSAl9ZC9Z9tUmOBkZy+KY/T6ymYobDxQVkiKLlilklnRkxdz8Abo8cZKcz7M8DneYeReg=
Received: by 10.140.171.4 with SMTP id t4mr5917799rve.230.1204233823937;
        Thu, 28 Feb 2008 13:23:43 -0800 (PST)
Received: by 10.140.147.11 with HTTP; Thu, 28 Feb 2008 13:23:43 -0800 (PST)
In-Reply-To: <7vablkkhac.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75461>

Junio C Hamano wrote:

> Doesn't reproduce for me.
>
>         $ rm -fr /var/tmp/j && mkdir -p /var/tmp/j && cd /var/tmp/j
>         $ git init
>         Initialized empty Git repository in .git/

Can you reproduce it if you do

$ git config core.pager "less -F"

after "git init"? The "-F" seems to be important, but I'm not sure why
using this switch causes no files to be displayed in this case.

-- 
Sebastian Schuberth
