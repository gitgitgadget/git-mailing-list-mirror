From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] upload-pack: support subtree packing
Date: Tue, 27 Jul 2010 13:15:59 +0000
Message-ID: <AANLkTinQeEpb8BjySdPsZpwYo4O7sHUMZ-ARuA7_y5aU@mail.gmail.com>
References: <1280187370-23675-1-git-send-email-pclouds@gmail.com>
	<1280187370-23675-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 15:16:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odk1K-0004XW-An
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 15:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab0G0NQA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 09:16:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50589 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab0G0NP7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 09:15:59 -0400
Received: by iwn7 with SMTP id 7so3783158iwn.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zSs7ns7tPLJBXNFMduAPdWapmf+QjdRWqSUsVOJrpvg=;
        b=oOPlMPtPBn/DeoJRMXm42XsAOAx4vTKtIUoRNz5Jdbo08R1T6fxJ9kWcSaBNh4CP7C
         q+e8XLFE9FkefWizFtWkLfZA8ZeDB/rth/yOn+H712PKF3RkWpWsNQd7x9ZxBDUvwDjQ
         wjjY+IuOSkGN9RC4XR4JgLj3ztTs34EYwBImc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mUVcJUC0m/u6rdyr2oiQ7ZqWdUbwiLcy49tSvopxGchjco8dLhSI8dsCgdNe2Ua7nk
         ykeyDK/FvT1dCfn5pz2g9EMhuD08pzMn9sYAcxzFwkpUNEnTXqgG99yslaJDFQMB0HEt
         YysFMSkEm3dOAGdE9OnzZfZWWhY5uGrITWd68=
Received: by 10.231.146.135 with SMTP id h7mr9948365ibv.149.1280236559046; 
	Tue, 27 Jul 2010 06:15:59 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 27 Jul 2010 06:15:59 -0700 (PDT)
In-Reply-To: <1280187370-23675-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151940>

2010/7/26 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D strlen=
(name);

Don't you mean "size_t len =3D strlen(name)" .., or to use a cast?
