From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: Gource - new GL Visualisation for git repositories
Date: Wed, 16 Sep 2009 12:16:23 +0100
Message-ID: <3f4fd2640909160416n7c0ac92eo3f055d6c45f9c0a2@mail.gmail.com>
References: <4AB0858E.6040805@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 13:16:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnsUv-0003Ie-NH
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 13:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbZIPLQV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Sep 2009 07:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbZIPLQV
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 07:16:21 -0400
Received: from mail-vw0-f195.google.com ([209.85.212.195]:46806 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbZIPLQU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2009 07:16:20 -0400
Received: by vws33 with SMTP id 33so1680196vws.33
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 04:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zLSH4aGjOj6FRKtIvbfatw9I7ITm7zqF57qPDix3NYo=;
        b=c3ks5y1VuEQLP8oiOOI2Gq9KxdZaqJuFXrOP1YWdeo7iBClKJbaMP0XY2hA6q4siOJ
         vwOmYjaJYoPEXpg3VJ4yQEN9j1vXsHO4ie0Dn1Vzgg2tKY0DWM2AoWhcPBH2z+kC/gAv
         SiYTdC8MjajrM4wW17bM6XoRjPmnS1M8KPGCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F0YyRnL7mPx6NS9SLrZzmNB5wqJbRCY2fXCRi2WKE+iruKr2ahNpRouh8grPfc+LUY
         HQXHdm0vP/gRotu/5rcLZAwalKx7ZdRxxKW5zjzK2w0F5FXXTJJNr2kRZN6Kcdn7MNUE
         ojVmsWDYxaw6uF94/vKpzA8FVFYxZAU08qEe4=
Received: by 10.220.108.40 with SMTP id d40mr12012964vcp.80.1253099783777; 
	Wed, 16 Sep 2009 04:16:23 -0700 (PDT)
In-Reply-To: <4AB0858E.6040805@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128642>

2009/9/16 Sam Vilain <sam@vilain.net>:
> A little fun candy to be had here:
>
> =A0http://www.youtube.com/watch?v=3DGTMC3g2Xy8c
> =A0(HQ version coming, once processing completes...)
>
> Gource is a visualizer written in C++ which shows you the development=
 of
> the source code over time graphically. =A0It's pretty neat. =A0Home p=
age at
> http://code.google.com/p/gource/

This looks nice.

Having a branch activity (as opposed to directory activity) rendering
would be nice as well.

I also noticed that this shows the committer's activity. It may be
more accurate to use the author (for example, the Wine project only
shows activity from one person and with Git, the activity for Junio is
similar being its maintainer).

In addition to this, for large projects that span a long time (5 or
more years), it would be nice to speed these up (possibly control the
rate as a command-line parameter).

Aside from that... very cool.

- Reece
