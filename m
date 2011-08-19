From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Re: [PATCH] Disallow creating ambiguous branch names by default
Date: Fri, 19 Aug 2011 14:07:57 -0700
Message-ID: <CAOTq_pskn-yA8tLbJ_tkAC7Dgn2vJ5OK5d5BqOWSna_FVARs_A@mail.gmail.com>
References: <1313569298-3879-1-git-send-email-conrad.irwin@gmail.com>
 <7vhb5fev8a.fsf@alter.siamese.dyndns.org> <CAOTq_ptU2QmPMMZYQLd2MFQ_=_RnADdBnoN5+v4rXh_nmpOcjw@mail.gmail.com>
 <7v1uwh2kks.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 23:08:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuWIh-00072G-Ae
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 23:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab1HSVIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 17:08:18 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58803 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab1HSVIS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 17:08:18 -0400
Received: by yxj19 with SMTP id 19so2484019yxj.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DhHhOh4Gvu+XKniDfNzLsSVTEhqaba9i7f/AoCm/C0w=;
        b=hYwysJorPpdCRBMWNL6lnXSQwvnUvG30SlCVwzsI0EiXGwB2DbglHyC0dcXUqm4B8W
         9idecxlz7ZuPsagSb9J5pv9QTaFGMA6aXSx4g+tjPwKn93nl8TBeueH6Mj2d+p/OS+Cq
         E4cZ2do1Fhodr1+whaJWoUdPKptYAC5BORu8A=
Received: by 10.236.176.33 with SMTP id a21mr1283891yhm.108.1313788097148;
 Fri, 19 Aug 2011 14:08:17 -0700 (PDT)
Received: by 10.236.95.131 with HTTP; Fri, 19 Aug 2011 14:07:57 -0700 (PDT)
In-Reply-To: <7v1uwh2kks.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179726>

On Fri, Aug 19, 2011 at 1:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> $ git rev-parse HEAD@{1}
>> warning: Log .git/logs/HEAD has gap after Fri, 19 Aug 2011 02:00:09 -0700
>
> If that is the case, then the codepath to update the reflog is
> broken. That is not a reason to forbid -B, though.
>
> But because I do not know what you meant by "checkout -M", ...

Sorry, I meant git branch -M <foo> <current-branch>

Conrad
