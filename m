From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2011, #02; Wed, 6)
Date: Sun, 10 Apr 2011 20:52:09 +0200
Message-ID: <BANLkTinTVinnDLPnHGoF9DY97ky_MFiLAQ@mail.gmail.com>
References: <7v8vvni1t3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 20:52:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8zkA-0006KH-9k
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 20:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809Ab1DJSwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 14:52:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42170 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab1DJSwL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2011 14:52:11 -0400
Received: by fxm17 with SMTP id 17so3170799fxm.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 11:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sFV58f9OALxfVhZZgiZbe0K1Ij7/dCauaVvtQkCoP/8=;
        b=NTyrS5EGLRkHfrnwkL3sJ+50vVOjJ//clEqXLX9UNejAB1fBxVfG3SVMd/qy/j5Vsk
         cjYc804S6CAD6xfQK+XHRVbEA0sDvaVnDgtte5aULUIMg7AAvTX505+6GF5e0ZLuD+Ue
         RoYIIn3LpacOY+NKAGQZqjtayMZKGmVjDnKJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ep7WXabOsD4Iv/xOTDy3pmkATdrw13v9ohL42eLgWGfoo4QCGDAuLr+B6naTTtBFxQ
         f15WBBjFScmoN/U1aSM3xA3n0v8ZFtyn0msiJ5wngXDI1bJAOD50NZ+ZgX1jeU7JXqDR
         0DR/XrivFjErwafL06iP59x6mNrjmKVirwJzM=
Received: by 10.223.127.210 with SMTP id h18mr134316fas.67.1302461529934; Sun,
 10 Apr 2011 11:52:09 -0700 (PDT)
Received: by 10.223.105.201 with HTTP; Sun, 10 Apr 2011 11:52:09 -0700 (PDT)
In-Reply-To: <7v8vvni1t3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171270>

On Wed, Apr 6, 2011 at 22:04, Junio C Hamano <gitster@pobox.com> wrote:

> * jl/submodule-fetch-on-demand (2011-03-06) 7 commits
> =C2=A0(merged to 'next' on 2011-03-20 at a5e452d)
> =C2=A0+ fetch/pull: Describe --recurse-submodule restrictions in the =
BUGS section
> =C2=A0+ submodule update: Don't fetch when the submodule commit is al=
ready present
> =C2=A0+ fetch/pull: Don't recurse into a submodule when commits are a=
lready present
> =C2=A0+ Submodules: Add 'on-demand' value for the 'fetchRecurseSubmod=
ule' option
> =C2=A0+ config: teach the fetch.recurseSubmodules option the 'on-dema=
nd' value
> =C2=A0+ fetch/pull: Add the 'on-demand' value to the --recurse-submod=
ules option
> =C2=A0+ fetch/pull: recurse into submodules when necessary

This series needs to be fixed to not fail tests with GETTEXT_POISON=3DY=
esPlease.
