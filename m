From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: installation issue when building with NO_CURL=YesPlease
Date: Wed, 26 May 2010 15:58:39 +0200
Message-ID: <AANLkTimsGdv-La_poLpdrvuGChD6_sAD77fcjqKn5PAd@mail.gmail.com>
References: <5B1E2CF0-4BC4-43FF-A372-EB3582DA6286@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Walker <PWalker752@aol.com>
X-From: git-owner@vger.kernel.org Wed May 26 15:59:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHH8a-0000He-IU
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 15:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298Ab0EZN7E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 09:59:04 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38116 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241Ab0EZN7A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 09:59:00 -0400
Received: by vws9 with SMTP id 9so4269768vws.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/9yjAdju11ZJSPe9Hv9d4YrBMcpRNq7PdP/LIeNImYU=;
        b=yECao58PkyX3ADrqQsfsvJ8TD5TVlFS1GRLAXdmNt490F7m128VoYc2sdwShHlbcZ+
         MP+dtuyt4wx1hDmCZ15l14GQ+07DVX61s/vq7gXXrb7dXkYuuoHkwYibz0vn1Zq8YWRR
         2euCGsWr7x320h+jyEuo+5+HtWjmwHPGhCg+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=N/kq+2b5+LfsCQahkszpPxHklFPaxzT2qHQDcNuOZnFRZV9qOmw1KSS+6B7gCrRqLb
         D1W7q5SUp2X/086sFthxfpafW8BxVgEufU2h/W35mfOEDWY6XPG79MF+BdNqzVn7YJu2
         hk8oaoyCVEycLefm5DNKTbeAzj9pmZyWZOAfM=
Received: by 10.229.240.77 with SMTP id kz13mr1846220qcb.199.1274882339156; 
	Wed, 26 May 2010 06:58:59 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Wed, 26 May 2010 06:58:39 -0700 (PDT)
In-Reply-To: <5B1E2CF0-4BC4-43FF-A372-EB3582DA6286@aol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147798>

Hi,

> As I could not find any bug reporting information on the wiki I thoug=
ht I
> would mention this here, please let me know if there is a better foru=
m for
> bug reports.

Bugs are usually reported on this mailing list.

>=C2=A0I believe the latest git release (1.7.1.) has an installation
> bug when building with "NO_CURL=3DYesPlease". =C2=A0Looking at the Ma=
kefile line
> 1999 it reads
>
> for p in $(REMOTE_CURL_ALIASES); do
>
> which results in "/bin/sh: syntax error at line 1 : `;' unexpected" a=
s
> REMOTE_CURL_ALIASES is empty.

I can't reproduce this. How exactly are you building? I'm using
$ NO_CURL=3DYesPlease make
=2E.. and it builds fine for me.

-- Ram
