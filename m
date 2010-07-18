From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Merge commit subjects git.git
Date: Sun, 18 Jul 2010 16:18:05 +0000
Message-ID: <AANLkTikhhjjRYPY4KWEJWUQjCw4TzhXRMvHRsaQ7BECe@mail.gmail.com>
References: <AANLkTikavL0DH8FgFxBw7hbGLtj2tqxnP-BT77zo5FJT@mail.gmail.com>
	<201007181733.59704.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jul 18 18:18:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaWZM-0003Xa-M0
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 18:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756616Ab0GRQSJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 12:18:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36289 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756602Ab0GRQSH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 12:18:07 -0400
Received: by iwn7 with SMTP id 7so3761826iwn.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3bSlj09wjMdW8IqnpYCnaI0HxIZCH8Sd0E49ejbiHhU=;
        b=HWbX97RgunpZNNhhCieBk+LYUE+1TNt4+djb/3s6n9540S2uTJJ8mJrehNCFrQeXFQ
         O0f5idR1EKAhGb09JKE0oZ1Ss2y6voJIVy0ctL1BC3fVSg3Ray36kcYTkTYc1jl1Pth4
         aIypUqUzE30BTWw07xUmYUeHlmzgQimE84pXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RTUDjB9bGhCSApjWPzXSm8p7EIVDYF5S6a6x1RnPbYhKLfxcVhCAVEhladpJhU6XSd
         hCCrVk17syB9mhBRbmwUK6dUN3Nr+Zhqz+fWXQjiJ7ouoR0b+3x8Y+RORoJ/ykN1wxiF
         2lcoCsmlq2uHdN3xaP5jhpFPX9kn+4BIvvPY8=
Received: by 10.231.14.200 with SMTP id h8mr3158229iba.188.1279469886002; Sun, 
	18 Jul 2010 09:18:06 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 18 Jul 2010 09:18:05 -0700 (PDT)
In-Reply-To: <201007181733.59704.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151218>

On Sun, Jul 18, 2010 at 15:33, Thomas Rast <trast@student.ethz.ch> wrot=
e:

> A merge that does not have the 'into <branch>' bit is a merge to
> master:
>
> static void do_fmt_merge_msg_title(struct strbuf *out,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *current_branch) {
> [...]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp("master", current_branch))

Is there anything in Git that records what the canonical branch is?
E.g. perl uses "blead", and gets these "into blead" merge commits
every time it merges into the main branch.

The HEAD can move, so that can't be checked.

(not that this is an actual problem)

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addch(o=
ut, '\n');
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addf(ou=
t, " into %s\n", current_branch);
> }
