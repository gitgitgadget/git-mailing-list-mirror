From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] git remote update: New option --prune (-p)
Date: Thu, 2 Apr 2009 15:34:15 +0200
Message-ID: <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com>
References: <20090402123823.GA1756@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Thu Apr 02 15:36:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpN5D-0001WU-HC
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 15:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232AbZDBNeT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2009 09:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753979AbZDBNeS
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 09:34:18 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:62945 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbZDBNeS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 09:34:18 -0400
Received: by gxk4 with SMTP id 4so1202972gxk.13
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 06:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CughoFzVgNvOZl6vTRO2874rnrmu4P39X1N/ZQ8kOcY=;
        b=W1iwryQ3dOG/k21Q+BBl0R1wv1zQhu+O+tKkhCZZPv04oRwCQlP3UjrkjVrz7leyaV
         Lo+D8GuPbj+lLADTB/0uoMt98GQDnmxPic/e/7UlUDVxLZd6A69d59uVpT+ywWojyvg+
         bVLRpuTVFpxBBgZRCupm6KvcvLs7UogxUgDqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QyUaJOF8ridvMpIvBPoellEaMmlnsk3PZ/Q77IdsXxqSGb9KRCIKiIvendHNzPKy/z
         /c8HJGeKRdd4LTaRCa831KUve/izloiM3e/zDr4nBPAoayW3RFTdG5sVImZLaySni3mn
         rg3g52G8MkZx8ep9R88E2j6F3hgZyC2wrwSBQ=
Received: by 10.231.30.198 with SMTP id v6mr8031ibc.22.1238679255482; Thu, 02 
	Apr 2009 06:34:15 -0700 (PDT)
In-Reply-To: <20090402123823.GA1756@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115464>

2009/4/2 Finn Arne Gangstad <finnag@pvv.org>:
> With the --prune (or -p) option, git remote update will also prune
> all the remotes that it fetches. =A0Previously, you had to do a manua=
l git
> remote prune <remote> for each of the remotes you wanted to prune, an=
d this
> could be tedious with many remotes.

Yay!

But one question. It seem to me odd to put this as an option to git
remote update, and not git remote prune.

I mean, it seems weird that one must say:

   git remote update --prune

and one cannot say:

   git remote prune --all

especially when there is a `git remote prune` already. It seems a bit
counterintuitive to find pruning actions under "update", but not all
that strange to find an all "--all" option for the "prune" action.

Although to me having both be allowed and mean the same thing also make=
s sense.

Anyway, thanks for this regardless, I am looking forward to this
functionality. :-)

Cheers,
yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
