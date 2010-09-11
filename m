From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/8] en/object-list-with-pathspec v4
Date: Sat, 11 Sep 2010 11:19:09 -0600
Message-ID: <AANLkTimEcrFEGZ3RYXsByLT275=X0E-D29Sio3pOjH6T@mail.gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 19:19:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuTjb-0000jY-I6
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 19:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab0IKRTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Sep 2010 13:19:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47752 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab0IKRTL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Sep 2010 13:19:11 -0400
Received: by bwz11 with SMTP id 11so3284782bwz.19
        for <git@vger.kernel.org>; Sat, 11 Sep 2010 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8g91dz23s4gqkbTuZcS4LX3rSxLQBXRBzbUyUGrViw0=;
        b=LDg1c94ICsBl7QieOJZ5JS9DA/Ho+qRT5AZn3g45GboFwNuhYw6cJ+4l89wGunR/DV
         vUeHn+YcwR2QMAYT7n7EQF/rzVs41hB4gKusFIj7cNd93l9JNHhzOcAQcfJlMsbVNkz8
         Mlhf77iYA+gOdfoft3MnC2e9EnBcvmLRq06Kg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dlBhu8JfUFmlq/sM+ID0q1KQOOPOIBzCoO0ekJ8ixFqZ8KQkf+8ah/HmGBJ/GDAg7G
         NC3oVwcEGd4jsdIm6YJZfql9XovPB4ONKF+qV3vMWcpRqojAGZw3BofzKjE7ENAczNVA
         arKkz5Wa1W9hVKuXk7bR+pJy54/mxTp3HCrPg=
Received: by 10.204.112.7 with SMTP id u7mr1681749bkp.70.1284225549452; Sat,
 11 Sep 2010 10:19:09 -0700 (PDT)
Received: by 10.204.126.198 with HTTP; Sat, 11 Sep 2010 10:19:09 -0700 (PDT)
In-Reply-To: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155996>

Hi,

2010/9/8 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
> OK it's good enough now. I no longer use struct exclude_list.
> Its name does not really match the semantics.
>
> The last two patches implement tree exclusion and are not meant
> for submission to en/object-list-with-pathspec. I wanted to see
> if the new struct was extensible. And I need tree exclusion anyway
> in my narrow clone.

Perhaps the last two patches should be split off and submitted
separately?  I really like your work here to add negated pathspecs;
they'll be really helpful for me.  However, as you say, they are
really moving into a different topic.

I've reviewed and tested patches 1-4 of this series, and they look
good to me.  (Am I supposed to add a Reviewed-by and Tested-by or an
Acked-by for these?  Still not sure what the rules are there).
Patches 5-6 are already part of pu (modulo the return of tree_entry(),
which is nice) and already have my signoff, so I don't need to comment
on those further.

I've got some comments for patches 7 & 8, which I think may need a
little more work; I'll add them to the individual emails.


Elijah
