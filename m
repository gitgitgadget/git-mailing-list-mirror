From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Unusual behavior from git describe
Date: Sat, 30 Jul 2011 15:32:48 +0200
Message-ID: <CAGdFq_imU3_=E1LK-AG33Tj70iOJBTmt2_qdUKVHL9DVW2yJRQ@mail.gmail.com>
References: <CA+jCPNcOe_dd6fsHDvWtoXEQE+xyd=aaSbfjpjQ8UfyFnvXTfg@mail.gmail.com>
 <CAGdFq_hYiBoqNmNtBKBqNN4XLLKwxDMHJfAUwdHB_iCcya=DOQ@mail.gmail.com> <CA+jCPNfwwhM8R-bB_VnwpaijSMf3BNydH35SqZt3dRb-P1AOmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 15:33:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn9fZ-0001lu-SW
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 15:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab1G3Nda convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jul 2011 09:33:30 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50002 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab1G3Nd2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2011 09:33:28 -0400
Received: by pzk37 with SMTP id 37so8084223pzk.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 06:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3eG4cSx6B0ocx74vawXq7kmen5Z88Z1CqPKeSQlMoyA=;
        b=NyOBpt8Oo8FmaUkxuKRxWl+WTvOcu892r1MWgrSyhTUYKCVJjTBm7rQiqXCPwZvpoh
         YDuGSJQWjmm9Uw/Qh9J58xwrdp5b3tZvvMDwX4+6qG92rFCzSlsOPFKN/2DH7onLPIys
         9bE5Fzq9H31FyzJ4IXeuQhs+uLeAqKZy6P9v0=
Received: by 10.68.28.106 with SMTP id a10mr4650694pbh.176.1312032808236; Sat,
 30 Jul 2011 06:33:28 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Sat, 30 Jul 2011 06:32:48 -0700 (PDT)
In-Reply-To: <CA+jCPNfwwhM8R-bB_VnwpaijSMf3BNydH35SqZt3dRb-P1AOmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178194>

Heya,

On Sat, Jul 30, 2011 at 15:29, Allan Caffee <allan.caffee@gmail.com> wr=
ote:
> I suppose that makes sense. =C2=A0But what about building a package, =
which
> doesn't change any tracked files or add any (non-ignored) untracked
> files, would cause the index to appear dirty in the first place?

Does it perhaps touch some of the tracked files? That way it would
make sense git at first thinks it's dirty (since the lstat info
changed), but then 'git status' will actually check the contents of
the file and notice that they're equal? Just guessing here though.

--=20
Cheers,

Sverre Rabbelier
