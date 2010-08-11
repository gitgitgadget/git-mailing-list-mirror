From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [WIP/PATCH 0/4] Re: Making error messages stand out
Date: Wed, 11 Aug 2010 12:34:41 -0500
Message-ID: <AANLkTimBY=WxAr8fv=W2AMcdQ6Jmcj0kvN=SDmrn5KYN@mail.gmail.com>
References: <20100725005443.GA18370@burratino> <AANLkTilnQhsopnuAf0nja8Qq63VrOlt0_uCJrqYv5X-v@mail.gmail.com> 
	<201007251122.41166.trast@student.ethz.ch> <20100729235151.GB6623@burratino> 
	<AANLkTi=ao2RY8NGm4cACqz3_5zfT2zvXB4JHOopBD9T5@mail.gmail.com> 
	<20100811083100.GA16495@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 19:35:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjFCp-0002Oy-Gk
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 19:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758242Ab0HKRfD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 13:35:03 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48044 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756888Ab0HKRfB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 13:35:01 -0400
Received: by ywh1 with SMTP id 1so101639ywh.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hL/LX3V+xLgJjyityGaIzIIrTf0bd01uhyuEBvmFu+0=;
        b=SvXTmy6WZWaMuR/aCrMzS7tYixLEJiLCDIaB82QaTqZ/6wyt+BFhViVm0jMsq5HrPH
         syMyw61U2I5yQj6PgwylWt8Ks2o8xy0YfKxmePBKxFAaxw3Lce0Gh5ybdb9R799lubGu
         C/jhh5UUZnkZBh1agK8QzvGKbaH9q/49vMWz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=suzgFZtHEt2wMAIgdsM7G9VXKgqt3+peXyjlIZaJloOFGDVdVYfG5di0I6ZOlYTltB
         A6CJrJ4HnxunXoC/smf39g3KHOc+YD2TotPF7RZyceb3IkxwqAhJt9MjmGqJTidS0AEh
         /G4KIVsfcaEiaqi6td92pyViuESnMoYNLNXug=
Received: by 10.150.1.4 with SMTP id 4mr21548136yba.118.1281548101197; Wed, 11 
	Aug 2010 10:35:01 -0700 (PDT)
Received: by 10.151.6.12 with HTTP; Wed, 11 Aug 2010 10:34:41 -0700 (PDT)
In-Reply-To: <20100811083100.GA16495@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153269>

Heya,

On Wed, Aug 11, 2010 at 03:31, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Jonathan Nieder (4):
> =C2=A0Eliminate =E2=80=9CFinished cherry-pick/revert=E2=80=9D message
> =C2=A0Introduce advise() to print hints
> =C2=A0cherry-pick: Use error() for failure message
> =C2=A0cherry-pick: Use advise() for hints

Nice :).

--=20
Cheers,

Sverre Rabbelier
