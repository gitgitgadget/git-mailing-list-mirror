From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/2] rev-parse: add option --is-well-formed-git-dir [path]
Date: Sat, 13 Aug 2011 09:49:56 +0700
Message-ID: <CACsJy8D7W54w3ji6foXySCuvNLLBu=FY70z8+kB5hmJT_-3yCg@mail.gmail.com>
References: <1313178913-25617-1-git-send-email-iveqy@iveqy.com> <1313178913-25617-2-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net,
	gitster@pobox.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 04:50:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qs4Iz-0005Ld-8b
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 04:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805Ab1HMCu2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Aug 2011 22:50:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56325 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab1HMCu1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2011 22:50:27 -0400
Received: by bke11 with SMTP id 11so2002192bke.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 19:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Ky3WFpTrva+vjkBcFvq/FBetQ/I/BH0gbgS66/2HlrI=;
        b=aEhzhQ3C7L9HRvs7XqEo3g/WSTKn/vXsG1ZI+e5abERbu7a+KOeHhgjmJ5VryyN0yj
         L57rkW+FrEiy2a/e+LFZUaiOdGHgN6+06haBwMB1KHIswj6Nr0m+6uik9AiqD9vecj4g
         31lIojefe390NHqgwleQ6uc41p+KbAA9JCmOI=
Received: by 10.204.49.199 with SMTP id w7mr586138bkf.227.1313203826320; Fri,
 12 Aug 2011 19:50:26 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Fri, 12 Aug 2011 19:49:56 -0700 (PDT)
In-Reply-To: <1313178913-25617-2-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179269>

On Sat, Aug 13, 2011 at 2:55 AM, Fredrik Gustafsson <iveqy@iveqy.com> w=
rote:
\> +--is-well-formed-git-dir [path]::
> + =C2=A0 =C2=A0 =C2=A0 Check if [path] is a valid git-dir or a git-fi=
le pointing to a valid
> + =C2=A0 =C2=A0 =C2=A0 git-dir. If [path] is a valid git-dir the reso=
lved path to git-dir will
> + =C2=A0 =C2=A0 =C2=A0 be printed.

May I suggest --is-valid-git-dir?
--=20
Duy
