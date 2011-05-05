From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.5.1
Date: Thu, 5 May 2011 13:13:01 +0200
Message-ID: <BANLkTikV0-efkU+V90i=hPkMLYXi2Puw4w@mail.gmail.com>
References: <7vfwouc4jx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 13:13:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHwV9-0002sv-5P
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 13:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab1EELNm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 07:13:42 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47097 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab1EELNl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 07:13:41 -0400
Received: by qyg14 with SMTP id 14so1485827qyg.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 04:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=TP623oPUoVPkISmoEVZxMBgBK7be64xVBb7U+gB+DG4=;
        b=K15Wfit6SXeUHhipDRmTxL+e1UKn7MIJnSzpKuJow3ZSCzprfMAbo1TcZ97E9uxORc
         NSLLNID5DlxvVIBIxhg2njFp7MOSTuhq4W9Z0CuA4L54Ia/EXUt8Tp9iVqEjGwfgeyQm
         mEg4XyKRfOnxlCW+L0j3G4HfCgx0FjQzV2J5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=B7gtJfceeWqhUi3G+gjHMf2C3MMgYm067ZBS6NonIgJ7036RNaCHHiTlvJRD2Oz08m
         9qCTCpzv5FivHho9dGKNNRC2etCvfASaOWAb84u6+3vReLITujYfKJkuvok7R2/dcGxj
         NTz9rGLK+UwzYRljNdB3yD6qHGohYmDdhlnVw=
Received: by 10.224.207.196 with SMTP id fz4mr2152268qab.184.1304594021090;
 Thu, 05 May 2011 04:13:41 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Thu, 5 May 2011 04:13:01 -0700 (PDT)
In-Reply-To: <7vfwouc4jx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172827>

Heya,

On Thu, May 5, 2011 at 03:35, Junio C Hamano <gitster@pobox.com> wrote:
> =C2=A0* "git stash apply" used to refuse to work if there was any cha=
nge in
> =C2=A0 the working tree, even when the change did not overlap with th=
e change
> =C2=A0 the stash recorded.

Does this mean that I won't get the "you have unstaged changes, please
add them" message anymore for the non-overlapping case? If so, nice!

--=20
Cheers,

Sverre Rabbelier
