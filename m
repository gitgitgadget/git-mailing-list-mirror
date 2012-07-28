From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 1/2] remove unnecessary parameter from get_patch_ids()
Date: Fri, 27 Jul 2012 18:54:50 -0700
Message-ID: <CAOeW2eG_5G3qQTguvWsSDfLU1s5p=B8WT=v8ywe=G1-VJTfGNw@mail.gmail.com>
References: <1343409699-27199-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<1343409699-27199-2-git-send-email-martin.von.zweigbergk@gmail.com>
	<7v1ujwzuw1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 03:54:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuwF8-0001jn-Lu
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 03:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661Ab2G1Byw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 21:54:52 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43769 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab2G1Byv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 21:54:51 -0400
Received: by pbbrp8 with SMTP id rp8so5941529pbb.19
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 18:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fD9QmYgtojzTIFR64m8qsGAScmfV1KroNcFraBeR2KM=;
        b=SYM/0ALxQh/2CI6252wITJ2Sw1WRY9Pp8sOu2ktaiWVQDiWf86Ur0xS8nQ6zEXvPfe
         6GnnruFRowo46E6M2DKbVunyzazKPMiqRTa7Wx3SpgFFZEpez27Reaf+LIL0VUeyigVL
         3wjJLJfXWRQ4otRGXy9aYAdKsvC6sMmrbGLUZNq+IB04GCWu2ntzaPbmrWRDhmLTvZTF
         9iq8+9No2XsbGoLdMmzNRkOH1H+CbA9myRvs+6crnhhxsw8uqdfRASfaacYj/7B7GJun
         Yu3JDUkZljbV6w267TRr/mqNSj94sEHfpw5LBVDLn9jc2s2hhOOMmMPaS+LBEeQIvRuU
         tJag==
Received: by 10.68.218.133 with SMTP id pg5mr17646551pbc.140.1343440490921;
 Fri, 27 Jul 2012 18:54:50 -0700 (PDT)
Received: by 10.68.42.164 with HTTP; Fri, 27 Jul 2012 18:54:50 -0700 (PDT)
In-Reply-To: <7v1ujwzuw1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202397>

On Fri, Jul 27, 2012 at 3:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>
> s/it seems the prefix doesn't change/the prefix never changes/;

:-) Thanks for confirming.

> In that sense it probably does not even matter if you did not pass
> rev->prefix down to check_rev, and instead gave NULL to it, but that
> only holds true in the current codebase, so I think what your patch
> does is the right thing to do.

Makes sense. Thanks for explaining!
