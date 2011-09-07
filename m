From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.6.2
Date: Wed, 7 Sep 2011 13:24:38 +0200
Message-ID: <CAGdFq_hAm4Avoi1VoFMHcnSE4oDmhEPvqJiodrLUJ5042pKzGA@mail.gmail.com>
References: <7vvct55j4h.fsf@alter.siamese.dyndns.org> <CAGdFq_gF8Uz_JTEUfb46kVii=Y0CwzCpOp5H81+HT8y=1PPUTQ@mail.gmail.com>
 <7vsjo84mx3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 18:59:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1LSu-0000oA-2H
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643Ab1IGQ7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 12:59:01 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54319 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab1IGQ7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 12:59:00 -0400
Received: by yxj19 with SMTP id 19so4079981yxj.19
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=W4Ra12NFuuyhxbSaRwO9z+skapttxu7+5ayIsd6fXxg=;
        b=KscecmdElqdwpW5QlPASjtMGI5TPkLKMLKfwcyAFBmYLtUcDYCjc/RnZ2MwW9zeRSc
         s6mUxxMscEIfk9WwieuzJ2gxc5MeZ6GSJ2zi1z7woHsbQt2BVX4nZHM3xJbwEu+36gnR
         ok4a5JYZtHC7i5AKHDkwc+7zYC6tW14J2HyDg=
Received: by 10.68.38.103 with SMTP id f7mr3834692pbk.500.1315394718122; Wed,
 07 Sep 2011 04:25:18 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Wed, 7 Sep 2011 04:24:38 -0700 (PDT)
In-Reply-To: <7vsjo84mx3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180871>

Heya,

On Wed, Sep 7, 2011 at 13:22, Junio C Hamano <gitster@pobox.com> wrote:
>> That's interesting, how did revert a merge commit?
>
> Does "git revert --help" lack the description?

It warns that "As a result, later merges will only bring in tree
changes introduced by commits that are not ancestors of the previously
reverted merge." How would you later re-merge the series when the
problems it has are fixed though?

-- 
Cheers,

Sverre Rabbelier
