From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git fetch documentation problem or bug
Date: Tue, 9 Oct 2012 08:57:16 +0700
Message-ID: <CACsJy8DOcfm1e9BnEjVCzs9u-QaG-jj8n6ehb6G_9dJqfyD7tA@mail.gmail.com>
References: <CAB9Jk9Ac06sfFMGizRq6Ztqd2tKS7BBqGOC891=z4615J3f4hA@mail.gmail.com>
 <7vfw5olqp9.fsf@alter.siamese.dyndns.org> <7vbogclqm6.fsf@alter.siamese.dyndns.org>
 <7vpq4silou.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 03:57:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLP54-0000FQ-94
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 03:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab2JIB5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 21:57:49 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:48198 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab2JIB5r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 21:57:47 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so476575iag.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 18:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VKJaauozQ88RCsIQWd1NsxEzj8r96TfmPzIZHmnSnWA=;
        b=xZOL2lgm0XzdPvXB7VyFcQOLRNK6c+5msgRVkg02NPAGcHnLQO8JgTS2SLbl1EvRvY
         y7gH0emrHJPG7CHZfNrA6lNuE7472RZkU8UJHQC+HHsJ+gxMWTBwezQSL+C8ywjqMK0i
         Cp9Y7/V7N0u564vxt3uhzphga36tWOQkZdHLxH3ptOLGpSoxjk0Me8DV+7JHBvNwjH9j
         LzRi+fWnlJbHlQ6tgVfGlITzodZ6xvdj7dLNYfJqlUiif4iX+rS+dEZNOLO31xle0uNR
         rBsSVCONm8MuEGeqln1flp9zbpe7EOnZ9wq7Djv6fKYEfYXAoRT1pE/w2cnc8Uw8pW8F
         Avrg==
Received: by 10.50.212.97 with SMTP id nj1mr279493igc.26.1349747867239; Mon,
 08 Oct 2012 18:57:47 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Mon, 8 Oct 2012 18:57:16 -0700 (PDT)
In-Reply-To: <7vpq4silou.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207283>

On Tue, Oct 9, 2012 at 6:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  * Unify pathspec semantics
>
>    This has happened and commands that used to take only path prefix
>    style pathspecs now take globs as well [ND]

I've been thinking about it lately and will probably restart soon with
a different approach. Still need to think about git-rm and git-mv as
they also accept directories (i.e. not exactly pathspec by
definition).
-- 
Duy
