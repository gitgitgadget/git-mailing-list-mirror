From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] check-ignore: Add option to ignore index contents
Date: Fri, 30 Aug 2013 07:51:26 +0700
Message-ID: <CACsJy8COEwA0hSf4yiTETqA6UBRhcCviayrhnynw23bTC-3foQ@mail.gmail.com>
References: <20130829224652.GA13621@opensourcesolutions.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Adam Spiers <git@adamspiers.org>
To: Dave Williams <dave@opensourcesolutions.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 30 02:52:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFCwU-0008Pf-78
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 02:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040Ab3H3Av6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 20:51:58 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:64776 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab3H3Av5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 20:51:57 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so1612249pab.38
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 17:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fiFQuYOgJHIul0Ev4Vr5eqmsi3mE+M9tFEHPTWsD1fs=;
        b=Q90RXZ+2iqz0QIE9qDj6Wtqmb7VGEtJAinCn3gYg7+/cJE4rTlq1YUNLa05uivC7St
         BkeuJa9wrMTGj43hDBa5ApcyKHBTQryQFuKZj9/bQi9/+Pocadn0XBgrBS5fJ/HwM0bn
         +VerFRup5hKC4w97DOIJ13PrR2vOjvQsO9OZRDAYyJ2PlYZ00qU9BDQwu1NyJ4JCTBjS
         tUVcHZVhsvs454hLeVZbkLOGszWDZGoJJg3Ah1WARdZYW8L6PeX24MtBYfv5h0oqmfLT
         M8PNKX5ipkPR2ApwZWJ0F/ikh3WPSnU0Ltak9reeL4jDjlWzs8eDLmIppznus6p9jWyy
         sXjQ==
X-Received: by 10.68.170.227 with SMTP id ap3mr6579383pbc.162.1377823917254;
 Thu, 29 Aug 2013 17:51:57 -0700 (PDT)
Received: by 10.70.70.72 with HTTP; Thu, 29 Aug 2013 17:51:26 -0700 (PDT)
In-Reply-To: <20130829224652.GA13621@opensourcesolutions.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233383>

On Fri, Aug 30, 2013 at 5:46 AM, Dave Williams
<dave@opensourcesolutions.co.uk> wrote:
> check-ignore currently shows how .gitignore rules would treat untracked
> paths. Tracked paths do not generate useful output.  This prevents
> debugging of why a path became tracked unexpectedly unless that path is
> first removed from the index with git rm --cached <path>
>
> This option (-i, --ignore-index) simply by-passes the check for the path
> being in the index and hence allows tracked path to be checked too.

Maybe --no-index, already used by git-diff and git-grep.

> Whilst this behaviour deviates from the characteristics of git add and
> git status its use case is unlikely to cause any user confusion.
-- 
Duy
