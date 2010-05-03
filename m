From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH v2] blame: add a range option to -L
Date: Mon, 3 May 2010 13:23:53 -0500
Message-ID: <u2ib4087cc51005031123z9be44d50ra529f082a9eca3c2@mail.gmail.com>
References: <1272909995-3198-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
X-From: git-owner@vger.kernel.org Mon May 03 20:24:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O90Jc-0000Eo-0f
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 20:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763Ab0ECSYR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 May 2010 14:24:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39200 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971Ab0ECSYQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 14:24:16 -0400
Received: by fxm10 with SMTP id 10so2406233fxm.19
        for <git@vger.kernel.org>; Mon, 03 May 2010 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wb/G5UHkqlVIP/DhclGiNI9N43L0ZOvWduulgfKotao=;
        b=WW9gQVGlT2iEq8uZmR3BPfPc3xhIvQDEWsikZo9P8VyGo/l0NZzTL/xw6g60GvL1kX
         c8EdCVimMuDX0+hwchk+H00oPkc28kmEQDS6iK2Cg65oR5EdIBZH3t8I0RwW1GCKr24Q
         CrkKIm9wpuLsF+P0gASDN0b71o4KksTK52nBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=j2GLxrBPMSuDq7A5mHOQJjzJu8f0O1dj7Ta5MyTF/3s3DswSjJb6albk65K5klVmM2
         3sbGk74TLmsOw4wp5JMf6cfm9dd3j82StrcEJwpEvi133yI7V/ImJctH1e/ZOJhomgUG
         paPxZ7zLo25CCB4Xrya09rg94sYROmD2jGFX8=
Received: by 10.239.142.18 with SMTP id e18mr674697hba.52.1272911053691; Mon, 
	03 May 2010 11:24:13 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Mon, 3 May 2010 11:23:53 -0700 (PDT)
In-Reply-To: <1272909995-3198-1-git-send-email-wfp5p@virginia.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146248>

On Mon, May 3, 2010 at 13:06, Bill Pemberton <wfp5p@virginia.edu> wrote=
:
> +-L <center>%<radius>::
> + =C2=A0 =C2=A0 =C2=A0 This works like <start>,<end> with the annotat=
ed range
> + =C2=A0 =C2=A0 =C2=A0 centered on <center> and showing <radius> line=
s around it.

I think the baggage of '%' might trip people up unless you add
something like: "Here, % symbolizes the notion of context above and
below the center line".
