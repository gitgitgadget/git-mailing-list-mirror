From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv2 1/4] commit: --fixup option for use with rebase --autosquash
Date: Tue, 21 Sep 2010 22:35:18 +0200
Message-ID: <AANLkTi=ok2EBAkwgPAN9zBmfayKXBdCEneiAhoDDstZv@mail.gmail.com>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com> <1285100703-49087-2-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 22:35:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy9Z3-0006Ey-T3
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 22:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab0IUUfj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Sep 2010 16:35:39 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60508 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab0IUUfj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 16:35:39 -0400
Received: by gxk9 with SMTP id 9so33779gxk.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 13:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+e74GKxi2cBVwLXswAAqM2XuRefjdwuOMjjlYXhUUqw=;
        b=x20kQejcRDdAxC4l4Rx/+7FHzFNSJSGq8bHuE9w3LYMb+/VDfBIMafBwahHsh2+gsE
         V9CNFdW1gyi0uHuyysigvGE7RNuwyrwaJ5rAgBYl3Mmm7Oc2IjRv+1ZzDoaSthKw+QZK
         SiUHdrGwr2zUo+vHcKe4kpaHmoOLor/AyDlKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=C4M49FBMMqHGfrUjaQKtTXPX7NV/gic0gbtUwXXy9FVoEqTc5Or9JlbNv/XGuvRvIo
         hhNgr+gZjuSu3Y5bgPJ+W8Y6GXO7jGNWG4I5LVu8RlwnHZ/4/Bp+MxyYQWWvIoG33hni
         oycIb6EvzZkiR2QgX9r4pkcScgfIorUBGyEBY=
Received: by 10.151.143.17 with SMTP id v17mr11935984ybn.179.1285101338353;
 Tue, 21 Sep 2010 13:35:38 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Tue, 21 Sep 2010 13:35:18 -0700 (PDT)
In-Reply-To: <1285100703-49087-2-git-send-email-patnotz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156755>

Heya,

On Tue, Sep 21, 2010 at 22:25, Pat Notz <patnotz@gmail.com> wrote:
> This option makes it convenient to construct commit messages for use
> with 'rebase --autosquash'. =C2=A0The resulting commit message will b=
e
> "fixup! ..." where "..." is the subject line of the specified commit
> message.
>
> Example usage:
> =C2=A0$ git commit --fixup HEAD~2

This is brilliant, I love it. I don't use 'autosquash' much atm
because I don't like messing with commit messages. This would make
using it much more convenient, thanks!

--=20
Cheers,

Sverre Rabbelier
