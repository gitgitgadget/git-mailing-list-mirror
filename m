From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 22:23:29 +0200
Message-ID: <200909102223.31602.jnareb@gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com> <200909101850.26109.jnareb@gmail.com> <43d8ce650909101246l50189c97r4f3fc4a8d7a0bd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 22:23:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlqB0-0001H3-Mt
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 22:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbZIJUXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2009 16:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753751AbZIJUXV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 16:23:21 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:52287 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbZIJUXU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 16:23:20 -0400
Received: by bwz19 with SMTP id 19so376596bwz.37
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Ri38Ej/LPUb7JtCgfqblEqD2jc9gQM1eKqc106rzUyk=;
        b=e5HH96MnVrHcEyjAIQnS0s8CJLuWnjUxeA6FwVqZIhyh7iYl38/MMHSFjHMzQBnyLa
         HbCFxgwVMXxUurZ7+jUibQg7gcgsWsgx0vD9qldPK/KGPXBqYhO4DJgIcUzdZQkZIV20
         YR3xU04sPtehYydmZLiBM6jerjdodvOIPe7qU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=K5Upb77WJ1pXO2m53NdcMTomIL6EDoCHxL0HvoTcmSc2L3Tg9X4PBIzLGnRMN4KMPV
         fj3GstE81/1dy5rTHna1ulW7oO1s+L2P3ZW2TQHNb6l9F+pt7vQPB2xI2YBu4kmEEDJH
         j05OlDEbArlr6BB+5Sg+JiL9UPll+r3ebevzo=
Received: by 10.86.230.27 with SMTP id c27mr1563032fgh.63.1252614202635;
        Thu, 10 Sep 2009 13:23:22 -0700 (PDT)
Received: from ?192.168.1.13? (abwa69.neoplus.adsl.tpnet.pl [83.8.224.69])
        by mx.google.com with ESMTPS id 12sm101524fgg.6.2009.09.10.13.23.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Sep 2009 13:23:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <43d8ce650909101246l50189c97r4f3fc4a8d7a0bd4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128140>

Dnia czwartek 10. wrze=C5=9Bnia 2009 21:46, John Tapsell napisa=C5=82:
> 2009/9/10 Jakub Narebski <jnareb@gmail.com>:

> > First, it would be consistent with how ordinary archivers such as t=
ar
> > or zip are used, where you have to specify list of files to archive
> > (in our case this list is HEAD). =C2=A0Second, I'd rather not accid=
entally
> > dump binary to terminal: "git archive [HEAD]" dumps archive to stan=
dard
> > output.
>=20
> That could be fixed by outputting to a file.  git format-patch output=
s
> to a file, so why wouldn't git achieve?

"git format-patch" outputs to files because it generates _multiple_
files; generating single patch is special case.  Also git-format-patch
can generate file names from patch (commit) subject; it is not the case
for "git archive" (what name should it use?).

--=20
Jakub Narebski
Poland
