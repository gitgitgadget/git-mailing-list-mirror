From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Add log.abbrev-commit config option
Date: Sat, 14 May 2011 13:26:56 -0400
Message-ID: <BANLkTi=MB5nz7wGkPw6_cf1barPbdN3UAQ@mail.gmail.com>
References: <1305393758-95432-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 19:27:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLId2-00031K-8e
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 19:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210Ab1ENR11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2011 13:27:27 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:42556 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab1ENR10 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2011 13:27:26 -0400
Received: by pxi16 with SMTP id 16so2273782pxi.4
        for <git@vger.kernel.org>; Sat, 14 May 2011 10:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=8YXk1K5DOEXmWOsguTYIWSZXIB83mU3co9OTnu9bdQg=;
        b=afrXYvsCCDi5WuhwoK7hiWVrysUT2sTsFRGUDIY+yiOh8QWQOpFfYrS0samT66UOF6
         ORrDDDJ8kxXipWzWe+Q3s8/NjacSFbSyH5EJPveQn4f7Ofx1dtQL3fIXpIzVqDsF0t9y
         9YFQqVMWPBL8xlZKQdxyxGPOGSYy6mhSrZ5mI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rume9w6Ic+2I5uwL4weHOr8D6CAueF/7CEfMZ0sdsoqFoRvnK7+/bMjsAtsInPTMt+
         uttYkLvxV4mLfX5boIYMmAERu6Oe3fyu1t3jo2aLThV7MhrjpHIjhH6LtG37/ATg5vBP
         h9FTep02+6S9S4hW+KFsTI+M0HvHq76UD7dFo=
Received: by 10.142.248.37 with SMTP id v37mr1558056wfh.369.1305394046108;
 Sat, 14 May 2011 10:27:26 -0700 (PDT)
Received: by 10.142.174.16 with HTTP; Sat, 14 May 2011 10:26:56 -0700 (PDT)
In-Reply-To: <1305393758-95432-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173595>

On Sat, May 14, 2011 at 1:22 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> +log.abbrev-commit::
> +log.abbrevCommit::
> + =C2=A0 =C2=A0 =C2=A0 If true, act as if --abbrev-commit were specif=
ied on the command
> + =C2=A0 =C2=A0 =C2=A0 line. May be overridden with --no-abbrev-commi=
t. Note that this setting
> + =C2=A0 =C2=A0 =C2=A0 is ignored by rev-list.
> +

The last sentence should probably read:

   Honored by the 'log' and 'show' commands.

j.
