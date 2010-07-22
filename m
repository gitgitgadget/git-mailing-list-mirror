From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git Notes on Branches
Date: Thu, 22 Jul 2010 16:05:54 -0500
Message-ID: <20100722210554.GA17461@burratino>
References: <AANLkTinnDBUzoDj-C289l4Kui2qSiKmF-027MzijyCFY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Joshua Shrader <jshrader83@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 23:07:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc2ys-0000Ru-UA
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 23:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436Ab0GVVG5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 17:06:57 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54879 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115Ab0GVVG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 17:06:56 -0400
Received: by yxg6 with SMTP id 6so852145yxg.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3DLQrghSh8nPUIGqgHgTQ43ypSORoKHzGqEtOB1JEn4=;
        b=fVLHFFuDz/OicNQ/XaLTxFCp26OJqVAhtmw10k+Tkr6zUlNEuCbvA5KxV2B0vdxt4F
         N5TX0REy6eX35p87SAsqfXTWOs5ZNUGcQS7ejLZyj75TfC1oic0QR8gFKDbfbpedn2xh
         XMTHLJf4Y5d+ddhKV9z+tc4SLjIsLikOVH7co=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=v6UWoJLPED1YNhCY6nXylx3cNVAhmcgUs3uZXpwV88FmHd5iBBsx3n93STAm4voYO0
         PVYvdAkPRvAleQG4f0ei+PES+Rq/Foyl9aXDvZLlWXqzGCr+StZRyslQvoWOYU05Q2R8
         QLmLrmNRPG5VaQJbp93PCOdZGql8URoDN+ER8=
Received: by 10.224.98.143 with SMTP id q15mr1727751qan.252.1279832814926;
        Thu, 22 Jul 2010 14:06:54 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h41sm30904553qcz.25.2010.07.22.14.06.53
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Jul 2010 14:06:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinnDBUzoDj-C289l4Kui2qSiKmF-027MzijyCFY@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151485>

Hi Joshua,

Joshua Shrader wrote:

> I'm wondering if there is a way to (or a reason that would prevent on=
e
> from implementing a feature that allows one to) associate a note with
> a branch, rather than a specific object.

Except for the word =E2=80=9Cnote=E2=80=9D, I think your suggestion doe=
s not have
anything to do with git notes at all. :)

Special support in gitweb, =E2=80=98git branch=E2=80=99, and so on for =
a branch with
files named after branches and giving descriptions would seem sane
to me.

Here=E2=80=99s something similar for inspiration:

  http://thread.gmane.org/gmane.comp.version-control.git/33528/focus=3D=
33563

Good luck,
Jonathan
