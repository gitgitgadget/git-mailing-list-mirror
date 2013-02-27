From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] attr: allow pattern escape using backslashes
Date: Wed, 27 Feb 2013 19:23:57 +0700
Message-ID: <CACsJy8Ag8rJ4P6w6ZCB0vBp6Hzqr_G5vWS_Jt=RNQT8+hF_w_A@mail.gmail.com>
References: <1357310809-4771-1-git-send-email-pclouds@gmail.com> <7v7gly5az0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 13:24:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAg46-0006V4-6e
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 13:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758468Ab3B0MY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 07:24:28 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:56033 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757414Ab3B0MY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 07:24:27 -0500
Received: by mail-oa0-f43.google.com with SMTP id l10so970034oag.30
        for <git@vger.kernel.org>; Wed, 27 Feb 2013 04:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=PVbYEEA3rBAehbBOJSRbAxxT4MPdy02zs12BwNMEO40=;
        b=Xla19v98THkEtl11nb3X24D0uYsdxXd1Mlo197Q67csrM22BqoiaynTl9ERzQHXuvp
         bCtffPP+/hKuHz3VczMuj0Bkwa0lqlAZgt8sNrIjw3rwHCSNiyBwKubv1pAl2j2gulOT
         JIKQor/RpjIAxf9MzNykpVWMS3k5Szelc8RxtP4l98pmXkXvdB2xSy3PKuFrK88B1wqo
         f3wZeS0LLsbr7enftU1yjzzw6HqWLZcBUfWKKzd4MxZ3cXjb9d3yIxOMfMMX48hKAVEq
         HYIOQdqoDiB4up4df9IoLTKpDes98QRGE7lmonlS814NIPjbhV01Oh3E8rMCxR9D2a14
         miCw==
X-Received: by 10.60.171.167 with SMTP id av7mr1822738oec.77.1361967867178;
 Wed, 27 Feb 2013 04:24:27 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Wed, 27 Feb 2013 04:23:57 -0800 (PST)
In-Reply-To: <7v7gly5az0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217201>

On Sun, Feb 24, 2013 at 4:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Speaking of .gitignore, I recall that there was a hanging discussion
> on allowing a pattern to name the directory that the .gitignore file
> appears in, which I do not think we currently support.  With such a
> feature, instead of listing "/junk" in the .gitignore file at the
> top-level to say that everything inside the "junk" directory is
> ignored by default, we could instead say "<this>" at the beginning
> of the .gitignore file in the "junk" directory.

Shouldn't "/" alone in junk/.gitignore express that? It does not work,
but I think it's a natural interpretation of the syntax.

> I think "* <attr>"
> in the .gitattributes file in a directory causes "git check-attr ."
> in that directory to report the <attr>, and we may want to have some
> way to allow "git check-ignore ." to be affected by the .gitignore
> file in the same directory in a similar way, but I do not have a
> very strong opinion.  Do people have any comment on this?
-- 
Duy
