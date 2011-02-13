From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/4] clean-up store_updated_refs
Date: Sun, 13 Feb 2011 19:46:07 +0100
Message-ID: <AANLkTimq+keyCO_EfLvswjwVYwLD=YDUagqcUTB1iVYd@mail.gmail.com>
References: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
 <AANLkTi=k9z67zmG6qBCh2uQWiofNceqs2erZ74XQARYq@mail.gmail.com> <AANLkTi=fN+cDjgDqLKas5n0iCAetRTAZfnPqcgyeYoX0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Vasyl'" <vvavrychuk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 19:46:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PogyE-0002VQ-PG
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 19:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab1BMSqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 13:46:50 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35976 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab1BMSqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 13:46:49 -0500
Received: by gxk9 with SMTP id 9so1763307gxk.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 10:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=I5aiqpeuYOqplu166dVCHtnbACgwM5w8+0Xmuj/XGA4=;
        b=tIuPA5g4zMdwktm1I5xdbTDGd/q3B2tskd0zeiO+dbwJxY20mCzkC8amTQqdl7SpAk
         1NdrzsRWLHMefr5AT4PsCodnbkEK0KT/5NPy4V0xSdd+2PQVv3Zs3lE9JI/BM6KYrVcw
         RcLI6ihqPNDf6+ydbCdcatlWGZfUjdNdlB0o8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YR9pTSHhxVs8sG9fo+ak0luzHeOxYASdUe3b1u0zxMKgU6p5TW8nMc3aNM+IsBqbbS
         vEXjqIA3YkG8Cf+KNB2aOXRYIVvruQkfL6VGrLjjgl67jbROvHZT/j5kbIMQeMFAmaJC
         L39ilOW/t8GzcITO7NDQTdIV7TdxiHWNx06Hg=
Received: by 10.150.185.6 with SMTP id i6mr3331575ybf.279.1297622808204; Sun,
 13 Feb 2011 10:46:48 -0800 (PST)
Received: by 10.151.158.10 with HTTP; Sun, 13 Feb 2011 10:46:07 -0800 (PST)
In-Reply-To: <AANLkTi=fN+cDjgDqLKas5n0iCAetRTAZfnPqcgyeYoX0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166673>

Heya,

On Sun, Feb 13, 2011 at 19:37, Vasyl' <vvavrychuk@gmail.com> wrote:
> I've needed this as part of bigger change which is collecting all
> .git/FETCH_HEAD related code across different files to
> fetch-head.[ch]. Which in its case I do as part of git-pull.sh to C
> porting. So thats motivation chain :)

Thanks, that's the kind of stuff that should go into the cover letter
/ the patch description.

-- 
Cheers,

Sverre Rabbelier
