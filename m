From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Adding Beyond Compare as a merge tool, was: Re: What's cooking in
 git.git (Feb 2011, #05; Wed, 23)
Date: Sun, 27 Feb 2011 11:58:56 +0100
Message-ID: <AANLkTikv=pGmy7NmCU2xCAq4oBnkXoGfdmNPY962gBdo@mail.gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
	<4D68D4FA.7090500@gmail.com>
	<4D69E355.7010104@gmail.com>
	<7vhbbp6dyh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	charles@hashpling.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 11:59:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PteL8-00014b-Fk
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 11:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab1B0K66 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 05:58:58 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38198 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab1B0K65 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 05:58:57 -0500
Received: by qyk7 with SMTP id 7so1541391qyk.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 02:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BdJYE6B84cKSZzsQN1pJlzvSnj8XkfffEWh+wgFuvb8=;
        b=ikTPRFQlpJlsypubCz+IiAEwDRMn9F+WHT5BWzXjGgBpJkyP9PHudPAEqDOb/4nM+y
         k4Lzqm7K9MBTSgr2BjktcfHXZZ76sP1ABq+NWIm8O97/lNvJao4KiSDD/53hMgAEy5f0
         QmZAaGCYQXIRa6uwTmPem/OrnTePkPqqnl26o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J3C4wzJSy9a9IdzhqM4RKEsdU4dmCQqOvAhLNhulK24dU1/bBG+zSaY1wpBO4FvX5e
         7azw3MV5GnPetuBKlh1bcL7UwWms7xmaLJNiaHunuFz0x3LFLRZ3M3b3LVZ5LMP6+P/7
         RGTqj5ZrvJPy6TV2lN+8hZl2GjXD3n55EqIBg=
Received: by 10.229.217.212 with SMTP id hn20mr3148015qcb.225.1298804336987;
 Sun, 27 Feb 2011 02:58:56 -0800 (PST)
Received: by 10.229.17.73 with HTTP; Sun, 27 Feb 2011 02:58:56 -0800 (PST)
In-Reply-To: <7vhbbp6dyh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168023>

On Sun, Feb 27, 2011 at 10:09, Junio C Hamano <gitster@pobox.com> wrote=
:

>> Unfortunately /usr/bin/bcompare is a little more involved than a sym=
link
>> so for linux we need to call bcompare.
>
> The real question is which one the end-users like git-mergetool--lib =
are
> expected to call, and it looks like the "bcompare" in /usr/bin spelle=
d in
> lowercase is the one. =C2=A0So shouldn't we be calling that, Sebastia=
n?
>
> And if we invoke lowercase "bcompare" on Windows, the system would do=
 the
> right thing, no?

Yes and yes, I'll update my patch accordingly.

--=20
Sebastian Schuberth
