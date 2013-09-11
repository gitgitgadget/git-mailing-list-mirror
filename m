From: Javier Domingo <javierdo1@gmail.com>
Subject: Re: [RFC] Disabling status hints in COMMIT_EDITMSG
Date: Wed, 11 Sep 2013 09:42:32 +0200
Message-ID: <CALZVapmYzKO=fvVgSd+3fzAhdGrawU0C=iETkoJ5fxG87o4KtA@mail.gmail.com>
References: <vpq4n9tghk5.fsf@anie.imag.fr> <xmqqeh8wzl0h.fsf@gitster.dls.corp.google.com>
 <vpq61u7akin.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 11 09:42:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJf4j-0006af-Cu
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 09:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906Ab3IKHmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 03:42:53 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:37338 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab3IKHmx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 03:42:53 -0400
Received: by mail-vc0-f169.google.com with SMTP id ib11so6048094vcb.0
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 00:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KTL+ZWFin5F04aUv366A+Ig1Qp4/unbYGltCP1ybnO0=;
        b=rcdp0gtPDPqAmLxbNYDdXAg3mtmLKup0FT1xA1AuB7z3KCpX5r4j9LIvPsSTlqpB5u
         2sxfWcZNTQg4ezxWfNEeXUuw0B62J43D009N5Hml8pzHLykn8b/+s/IL/tEawFpF1oXG
         raie35lDiQePgDjRVTjO8FkrNug8arJl0Av/57GPQx2tPd6OCXkc3SnxbzfpYWdU5+og
         HkUfkFMMU5fCFq6Od+ImUuA2H9v8kxMJUarCUKA9XuawsP3/yRZfHBD7CwIzZ0F4jRiM
         hIRNEZ0m3YWEtkDnzEQ8OecupUoKCnoW5IIGkg5xw0pimmE/a54fLYPm/Nzy1ELxXQIT
         2Erg==
X-Received: by 10.58.169.101 with SMTP id ad5mr65761vec.88.1378885372392; Wed,
 11 Sep 2013 00:42:52 -0700 (PDT)
Received: by 10.58.200.74 with HTTP; Wed, 11 Sep 2013 00:42:32 -0700 (PDT)
In-Reply-To: <vpq61u7akin.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234547>

IMHO, It is alright as it is.

I have been using git for 4~ years now, and I still find very useful
those lines. They are like a git status while committing, and it's the
key to avoid accidental commits of objects or forgetting files in a
commit. Between that and that the commit message can't be empty, I can
abort a commit and correct the staging area.

Cheers,

Javier Domingo
