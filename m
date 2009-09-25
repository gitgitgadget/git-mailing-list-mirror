From: Frank Li <lznuaa@gmail.com>
Subject: Re: [msysGit] Re: Add MinGW header files to build git with MSVC
Date: Fri, 25 Sep 2009 08:18:02 +0800
Message-ID: <1976ea660909241718k1d9e27f8pfa0e2e1cb628edb6@mail.gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
	 <7afd55f9b2f0f7859f757c715034cc3520e07f0e.1253088099.git.mstormo@gmail.com>
	 <a416a9d0-90f3-40b7-bd39-ea67ceb2e0b9@j19g2000vbp.googlegroups.com>
	 <4ABA0698.7020604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	msysGit <msysgit@googlegroups.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, gitster@pobox.com, j6t@kdbg.org,
	raa.lkml@gmail.com, snaury@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 02:18:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqyVl-00082o-R7
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 02:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbZIYASA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 20:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbZIYAR7
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 20:17:59 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:10804 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbZIYAR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 20:17:59 -0400
Received: by qw-out-2122.google.com with SMTP id 5so789149qwd.37
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 17:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=5T+zwWoc4dZP+kFMZ6F5utyUz1mwJ1rxMIfCOrJ4XIM=;
        b=EU4fEOfQawJ7igR5NCOTq9bl0nHgDil14nAq3DvDwt03g2Oe4ex7zn0RtgKmvZz99E
         xDgi7/CcaDNZTMJB6AHAntMa0buy5dvq7cDtbQ6B7TEXpJBPLlqooy+k8ry0iieMjX2q
         QampeSPrETOZ9pr3QnrZ7ufOZ4yxOU2a4gdUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dI5F4fFIx4j22aUSecIYbZXOS3f2PV/O0z1gIRzzvjTjimAXsgHQiKwwx0ORSgzzM6
         rzSG+dzINzH59uYWSI0vFbLiOkXMWvGhXQrucbAt5cki6hkEAAPpdJnzFiTOJRJXVRdI
         idi01yfnz64eRnNt/JpjmdmBnoT5/M3LWZWqQ=
Received: by 10.224.25.3 with SMTP id x3mr3964345qab.159.1253837882636; Thu, 
	24 Sep 2009 17:18:02 -0700 (PDT)
In-Reply-To: <4ABA0698.7020604@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129058>

>
> This was a patch which originated from Frank Li's original series. While we
> might have been able to simply use the MSVC one, I'm sure Frank had a reason
> for overriding it with the small content which you see in this patch. We'll
> have to ask Frank about that. We can always remove it now, if the MSVC
> version works ok and doesn't introduce any compiler errors/warnings.
>

At beginning, I don't want to copy all msys header files to
vcbuilc\include and copy only necessary header file and data
structure.
Many structures have been defined at MSVC standard file.  So I use
simple utimer.h and unistd.h and dirent.h.

Best regards
Frank Li
