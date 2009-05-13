From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 4/9] Convert 'clone' to the use stgit.lib
Date: Wed, 13 May 2009 17:10:08 +0100
Message-ID: <b0943d9e0905130910w35a5382ai3d89751d7d8b0c48@mail.gmail.com>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
	 <20090428150957.27261.83658.stgit@pc1117.cambridge.arm.com>
	 <20090429062101.GD18483@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed May 13 18:10:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4H2D-0005Xn-Qr
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 18:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758726AbZEMQKN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 12:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758530AbZEMQKM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 12:10:12 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:41869 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758136AbZEMQKK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 12:10:10 -0400
Received: by ewy24 with SMTP id 24so901403ewy.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JjjcMU8rjbRW1Na67ExV/m3cfUA+F99H85uiZl/d6yY=;
        b=WRuEQccnBePjttHMP+M+YkRxzQEuBCM9Omy+LMeOeN93E5ses2K6f/miXXMmTJi08e
         GaPYNY1m4ato83cBsmo4Wr8bJHnjA6aB3yUND/ckFuRxJ+lNDSlTr9hQ1Ro4Egpj7aCU
         52J2Hx6nnL+RQeYLJDhFNgohiCnSsh/LiIpUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N5/r5OcAUvhxTMihtY14MtkDf+1WOqg/QJljWuh5Rh56IwHatV9USkiB7HpIoCZyQX
         mrvVO9VuvmUonBhlYpr3JLlZws/wPvnlbL9ZjTt2RGIzgaP8Js6R86Tde1sKr3FvIMw2
         z5ZIUzqfoVyyzgh4b6rwEedoPoMn1GCWSqdWQ=
Received: by 10.216.3.70 with SMTP id 48mr508057weg.74.1242231008342; Wed, 13 
	May 2009 09:10:08 -0700 (PDT)
In-Reply-To: <20090429062101.GD18483@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119063>

2009/4/29 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-04-28 16:09:57 +0100, Catalin Marinas wrote:
>> +def clone(remote, local):
>> + =A0 =A0"""Clone a remote repository using 'git clone'."""
>> + =A0 =A0run.Run('git', 'clone', remote, local).run()
>
> You don't capture git's output here, but just let it through. Does
> that look good in combination with the enclosing out.start() ...
> .done() stuff?

I actually dropped the out.*() entirely as git already prints enough
information.

--=20
Catalin
