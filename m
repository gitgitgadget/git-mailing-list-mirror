From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 3/3] New send-email option smtpserveroption.
Date: Sat, 4 Sep 2010 20:35:43 +0000
Message-ID: <AANLkTinvos_65kb2uO9bTpRAaCeN+N63-KsMmARadt=3@mail.gmail.com>
References: <1283630128-3472-1-git-send-email-pascal@obry.net>
	<1283630128-3472-4-git-send-email-pascal@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sat Sep 04 22:36:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrzT3-0000c3-Te
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 22:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336Ab0IDUfp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 16:35:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36104 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab0IDUfo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 16:35:44 -0400
Received: by iwn5 with SMTP id 5so2746910iwn.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 13:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+1kA1mYw/1jYl9+g+n/trWuMkeXY24Fb9t0IataN2UE=;
        b=JONG23uiyrN1otO1HfYiAdw82RtHlUZpe/8S5vf99XkJ5otrPOcekf+PTuZc6Q7g1g
         oqSxLgt6qY5+DraGBDmrjfUs5dam8Ge2FS8uXPkL6QumHpFGldZpV/g3zh/7EV51kaHj
         MWXWI23c4Q1X90Y2jzfxo5DwylAHVUnSSszjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Pk8O3deK7pnM6A2ZSpdprw1gICaLR73UlGmfgwasR8OzUE+e1gtgJs51Nz26F0Uft4
         NnV8I40cBDSITLjfNesG7P7sgNL4DRj16ljmYFiKrwZg1ZEbA38eAEk6D4pFnmqi92r6
         ylB+mcPz7YLSMZ2t7+AZKN3e5ofqzYRgzM8Mk=
Received: by 10.231.19.140 with SMTP id a12mr3318557ibb.153.1283632543907;
 Sat, 04 Sep 2010 13:35:43 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 4 Sep 2010 13:35:43 -0700 (PDT)
In-Reply-To: <1283630128-3472-4-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155357>

On Sat, Sep 4, 2010 at 19:55, Pascal Obry <pascal@obry.net> wrote:

Looks good, but tests are always nice :)

> + =C2=A0 =C2=A0 =C2=A0 unshift (@sendmail_parameters, @smtp_server_op=
tions);
> +

It just seems iffy to not be able to provide options without having
the sendmail_parameters. Or maybe all usecases for this involve a
program that takes sendmail-like arguments, so this isn't an issue.
