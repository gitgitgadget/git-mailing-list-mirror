From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Sat, 5 Jun 2010 15:29:48 +0200
Message-ID: <AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com>
References: <20100605110930.GA10526@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Jun 05 15:30:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKtS6-0001Rf-F7
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 15:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933351Ab0FENaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 09:30:10 -0400
Received: from mail-yw0-f187.google.com ([209.85.211.187]:51456 "EHLO
	mail-yw0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109Ab0FENaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 09:30:09 -0400
Received: by ywh17 with SMTP id 17so1286080ywh.1
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=i4gvZzGiKlvpQ7m8hxyHOHOlgbAHaIiiLhMuE1RzYuA=;
        b=WqFKYLyYZGzKTHuv+VnSqWDv1a6pfVE04TYJ+Sn7PmrN5++acNMACbFxvdetTpSV9/
         2L/CmrOo0wjAg73u+my2Dd+34RYCQ48SPLmYoXPdRXj3u20Fmh7D3nVPAhotZLtwdomS
         fme1j0l+X2JeHXtlqM1cY1QbM2cTVmzKdHeKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WG+IJpTuttdQMizxCYVL95HrLhnEgZ+p48Q8rzSONCTPe5YremtgfH3sC7/QQUlrR2
         XUcdu/cwDUF5jz7xjfnan3bkyJMUfKcav5BiA9x8xQwzhgfb095u4RE1D6pwR11SteMf
         Rs+83yKQ1E0WII+ZGqD1J5fGQr5xDeMtycdbA=
Received: by 10.150.188.10 with SMTP id l10mr12310911ybf.296.1275744608081; 
	Sat, 05 Jun 2010 06:30:08 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Sat, 5 Jun 2010 06:29:48 -0700 (PDT)
In-Reply-To: <20100605110930.GA10526@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148469>

Heya,

On Sat, Jun 5, 2010 at 13:09, Clemens Buchacher <drizzd@aon.at> wrote:
> I think git checkout -t <remote>/<branch> is short enough for
> creating a new tracking branch. For something even shorter, we can
> create an alias. But I'd prefer to keep the already complex
> checkout command a little simpler.

You're a little late to the party ;). Did you read the original thread
discussing this?

-- 
Cheers,

Sverre Rabbelier
