From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: More support on branch description?
Date: Thu, 19 Jan 2012 22:24:24 +0700
Message-ID: <CACsJy8DTw-8Sm09hzHoHP8eFVGCX_kkrvhj+8v3MXz2eohfaEQ@mail.gmail.com>
References: <CACsJy8D0_EB6jN7KxpzLtnPnj0HjdU6sNHJRyqXJf-2-ZNatFA@mail.gmail.com>
 <4F183365.5010607@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 16:25:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RntrK-0004tp-7s
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 16:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167Ab2ASPY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 10:24:58 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58348 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab2ASPY5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2012 10:24:57 -0500
Received: by bkas6 with SMTP id s6so31950bka.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nm1h3DJlvewAGdWAUPCBCTasEE1lDjPpaZ6yGkjz2xk=;
        b=KEetQgxHDKyAp79Xb3CpzFYdeJGVoAFMeYq6hr3XXaib9WXDwH9Fkg4NyPk0Pl9pFQ
         DPk2beJoqydWR9/hkSAj3LfMvSwPEHKAKB65qj4X6NUZCnHdcsQxPmcih9RaGn5ji+Eq
         N107W7VFKIDN+X5EtKQOB9rtugDJWMDaRVH64=
Received: by 10.204.154.211 with SMTP id p19mr2440361bkw.130.1326986695239;
 Thu, 19 Jan 2012 07:24:55 -0800 (PST)
Received: by 10.205.123.145 with HTTP; Thu, 19 Jan 2012 07:24:24 -0800 (PST)
In-Reply-To: <4F183365.5010607@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188816>

On Thu, Jan 19, 2012 at 10:14 PM, Michael Schubert <mschub@elegosoft.co=
m> wrote:
> Junio suggested a new option "--verbose-format" for branch some weeks
> ago:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://thread.gmane.org/gmane.comp.version=
-control.git/186727
>
> I planned on working on it, but haven't found the time yet nor do I
> really know which way to go.? (pretty.c seems to be the right
> place for format code, but it's very commit format specific atm.)

Thanks. I must have missed that. There's another piece of formatting
code in "for-each-ref --format" command (I happened to have a look at
it a few days ago). It's ref-specific, probably closer than pretty.c
for this kind of stuff.
--=20
Duy
