From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] rebase: use @{upstream} if no upstream specified
Date: Tue, 8 Feb 2011 19:27:03 +0100
Message-ID: <AANLkTikxz1FJcKRkqRHtm3hUfhbQkcWHnNT25Kws1+yi@mail.gmail.com>
References: <1297125475-19151-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <AANLkTi=Uqkzv+ucBzww6R1V+0ujmfH-dED8XJhyRvWQF@mail.gmail.com> <alpine.DEB.2.00.1102081320350.4475@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 19:27:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmsI2-0001ZI-BF
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 19:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab1BHS1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 13:27:45 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43865 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab1BHS1o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 13:27:44 -0500
Received: by yib18 with SMTP id 18so2379915yib.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 10:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=7mGYCddw28F0aN5J6Ty2V9Oz2oWRhtCq78LLbtHbj+g=;
        b=oGLqruim4p8L9GIdQOwOyapyjBjdWJDXECcTTfIvpJaObwJZFQNJ7lgfmobKQANxCT
         tcfimSETy8SRSciyHNwfNq+pWuv6Nzbel3xnQ+RvcGMxaOektE0kBBP4Iu2SVprAoIKc
         DQgOEC94VicNhfci2rMx14vQy6jblp+AaXpAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=EznnqvLkASvDOf8nFQsKmsMCxXIDxHjujjoxy7enTlcHdptgA1e6Nronjyeb3KY+Mk
         b4x/LpnFua6NapdL9ZPA7oF4Ld810uddkJtit2rEzQNtW0UQFK8DEpOFbm8OIHdyBRnM
         EB4zeLgeG9rCZZMBIWc0AButRe2hD4Q8JnTtE=
Received: by 10.150.229.16 with SMTP id b16mr320630ybh.226.1297189663890; Tue,
 08 Feb 2011 10:27:43 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Tue, 8 Feb 2011 10:27:03 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102081320350.4475@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166364>

Heya,

On Tue, Feb 8, 2011 at 19:23, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> Thanks, but that was stolen from git-pull.sh ;-). Federico Mena
> Quintero added it there in 8fc293c (Make git-pull complain and give
> advice when there is nothing to merge with, 2007-10-02).

Credit where credit is due :), nonetheless, glad to see it here as well.

-- 
Cheers,

Sverre Rabbelier
