From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 00/20] [CONTINUE] Add gettext support to Git
Date: Wed, 8 Sep 2010 23:32:45 +0000
Message-ID: <AANLkTinC59XFt8pPyUF3ifMTeVMSC1e44MDPto5Fy1+n@mail.gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
	<7vd3sonq2n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 01:32:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtU8L-0000aS-DG
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 01:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750Ab0IHXcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 19:32:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58134 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756699Ab0IHXct convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 19:32:49 -0400
Received: by iwn5 with SMTP id 5so448532iwn.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 16:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/i3jxLvfoApgtLKLOVeFP9Qrnr6abCdF+iVlsjNuGS4=;
        b=dagr6SsxsnuM2ZrrkXH+ISwOXyHhTIDDRshkC6Det5zLV3j3tdr3u+iBbQYI6ldMtl
         AEWzEGe9WYndkH51S7BRi2CMQX+wMIq6PKNurMU9yOlVmYUaTbJanX7xnh1bhMXOulKZ
         bX2LFntSzOE+AMCf2hhDsruzF5Y9WRBRdy8as=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v2GvojmWhUVKDDCZ1nzVMxfhuxxn+4igcO7X6Um97HaDo2VWXDTyy/bOA7VUA95NhR
         CKdCKb72TmQ4z5U2dXfSjnagvQlgdRgGnu9YErbbN0KF4rpf00GybUIEsKV4J3SWShrE
         zWRftZvHloHMRXUs35HY+KQW2H+5oTd7n3SnM=
Received: by 10.231.11.72 with SMTP id s8mr10340885ibs.110.1283988766021; Wed,
 08 Sep 2010 16:32:46 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 8 Sep 2010 16:32:45 -0700 (PDT)
In-Reply-To: <7vd3sonq2n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155824>

On Wed, Sep 8, 2010 at 16:43, Junio C Hamano <gitster@pobox.com> wrote:
> I've done
>
> =C2=A0 =C2=A0git fetch git://github.com/avar/git +ab/i18n-all-continu=
e:ab/i18n
>
> and rebuilt 'pu' with it (I am not quite ready to push the results ou=
t,
> though).
>
> Please squash in the following to appropriate patches in the series.
> Thanks.

Thanks, those fixes were actually already part of the series, but I
hadn't squashed those yet.

I've gone ahead and done so:

    pick 8e9b49d gettextize: git-clone "Cloning into" message
    fixup 73f08a1 gettextize: git-clone "Cloning into" message braces

and:

    pick 8e9b49d gettextize: git-clone "Cloning into" message
    fixup 73f08a1 gettextize: git-clone "Cloning into" message braces

I've also fixed up the whole mess with the "me" messages. I.e. dropped
the revert commits and just fixed the originals so they make sense in
the first place.
