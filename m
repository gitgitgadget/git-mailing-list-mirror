From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] Move libgit.a sources into a libgit/ subdirectory
Date: Fri, 18 Feb 2011 10:47:16 +0700
Message-ID: <AANLkTikFLkXKKhZoDGAgh+i8H2fv+QNEVj7vEVABxee2@mail.gmail.com>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org> <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie> <20110218023126.GB23435@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 04:48:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqHK1-0004uZ-Bd
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 04:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab1BRDrw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Feb 2011 22:47:52 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48824 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab1BRDrv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 22:47:51 -0500
Received: by wwa36 with SMTP id 36so3340825wwa.1
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 19:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=VT3NSm5zhzAp3YjKEknPINXhYxw8mkQhQcELkTpMSG8=;
        b=lNj5X8Z9j2bSXAw8wfgM+73MVDtdxTNLrYtyd8ldR6UDBie2jBK0K60Y+98wH5mUG0
         UzPDHZb7IIe87tpvZ69MbQCzPtoAuxZL2tR2zQqTiPOm5Jv6DVmRL8w1BfLtLWPuUBYz
         IITd6bbOOX9pQqeUJNr5D7Y6aLNzWEolT98ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ul9+zcrnVwqjTIrunTRalwsFUY6WNRCXyMp++tZUafk4Hn+rAI5Nj70ke5qMGCexHM
         j2051jTAAmpvwaQxw3IVXHomDbcv7U8lCjdu2fG9B4A7csPFSvLzc1RIiW0vSDpqPBAO
         3W0REu6ck9xfoieQbzDyVDyK5I8GAWWmToyd8=
Received: by 10.216.184.139 with SMTP id s11mr1103634wem.13.1298000869494;
 Thu, 17 Feb 2011 19:47:49 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Thu, 17 Feb 2011 19:47:16 -0800 (PST)
In-Reply-To: <20110218023126.GB23435@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167158>

2011/2/18 Jonathan Nieder <jrnieder@gmail.com>:
> Move sources for libgit.a to a libgit/ subdirectory. =C2=A0This way, =
a
> person wanting to tackle the reusable part of git will know where to
> look, and those looking to work on individual commands know to look
> elsewhere.

You missed a few (on purpose?): block-sha1, ppc and compat.

libgit.a is produced at toplevel so I need a few more keystrokes to
reach files inside libgit. Maybe move libgit.a to libgit too?

> Perhaps some day the libgit/ subdirectory can be managed as an
> independent subproject (for example if it gets merged with libgit2).

With die() all over the place in libgit.a, I doubt it would become an
independent project. Although this certainly makes it easier to
reimplement libgit as a thin wrapper around libgit2.

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
--=20
Duy
