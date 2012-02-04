From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 10/13] branch: add --column
Date: Sat, 4 Feb 2012 12:01:18 +0700
Message-ID: <CACsJy8AdSh_XH4o29yfEG8AxUK-=+zdeLanZA7C81qExiJQceQ@mail.gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328276078-27955-11-git-send-email-pclouds@gmail.com> <7vwr83ldfz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 06:02:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtXlP-0000EC-GC
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 06:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748Ab2BDFBu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 00:01:50 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52784 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab2BDFBt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 00:01:49 -0500
Received: by bkcjm19 with SMTP id jm19so3584757bkc.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 21:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OdawxaYsEa2dnylheNeNTLLbex1fn0x9UHewj8AD5bg=;
        b=Xz10fFA3GDsmq4uqemPwTvnVdQuZcuW7BnTfiLC1ADD5PzKMKszrdSyL8WBCFBDOtU
         sVmlBv9XpGTonG6DgK11XyNLeuNxJ7sVmFgoKv7CmU0WFP+BbB5jANRP52xAXuOfT3jb
         y8Xys4Vq42VNvAL8eMbi/tq6aF+xNS93fvLqM=
Received: by 10.204.157.17 with SMTP id z17mr4659091bkw.37.1328331708366; Fri,
 03 Feb 2012 21:01:48 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Fri, 3 Feb 2012 21:01:18 -0800 (PST)
In-Reply-To: <7vwr83ldfz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189840>

2012/2/4 Junio C Hamano <gitster@pobox.com>:
> I am not sure about the utility of columnar output for "git branch" i=
n the
> short form. =C2=A0You no longer can just scan the leftmost column to =
scan for
> '*' to see the current branch.

I rely on color for that. Without color you may need to scan more
columns for '*'. Though I would really like to see "git branch
--current" added to show just current branch if I'm on colorless
terminal.
--=20
Duy
