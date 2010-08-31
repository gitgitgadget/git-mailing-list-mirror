From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: format of git pack objects
Date: Wed, 1 Sep 2010 00:22:57 +0100
Message-ID: <AANLkTikKavvRb-f0UFF6npQyuPaDHfxEnUFoqNCZNoZ5@mail.gmail.com>
References: <AANLkTimNnUYoBa1VfZeBb=eD=HymOU_h57bthYFC9jUZ@mail.gmail.com>
	<20100831231947.GH32601@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 01 01:23:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqaAR-0004X5-Eu
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 01:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107Ab0HaXW7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 19:22:59 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51542 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab0HaXW6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 19:22:58 -0400
Received: by vws3 with SMTP id 3so5913059vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 16:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P2oYcqgj3fxP3eJzZM99xicQ/ARJlGSAQjgNcZsbeDI=;
        b=GQrX52XsarDaCMF0xnrC01rBtlAnKWM7vOpBvnGpb6dLhc1cgAT4Oo0XxhFj4FmOTf
         gulFDqYL6sfyWTnM5eddwp+PVEYj7HvXsZtHlDddidErQg/tLtlUc69Udbwlo3bV6nMv
         RG3gNLBXf1A+mp1sD1eaovPirQpZb+v0kTnZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QbS7HvrFl/RgY4sBSkKvs28R+b78o5Ctpu8en42N7TYocBk6DLFO87myfxpeNB2WSJ
         QqY1RGp3/kPecyz0+CzIbU3HvpeC2RBVBqTm4vCMLEneS5T8IYgUk7mHVpH7q4DIaST/
         vYQnnREe1XC3ypFtuD4sFu+D7arG8CaeNhMX4=
Received: by 10.220.60.204 with SMTP id q12mr3746909vch.183.1283296977757;
 Tue, 31 Aug 2010 16:22:57 -0700 (PDT)
Received: by 10.220.98.14 with HTTP; Tue, 31 Aug 2010 16:22:57 -0700 (PDT)
In-Reply-To: <20100831231947.GH32601@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154995>

On Wed, Sep 1, 2010 at 12:19 AM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Luke Kenneth Casson Leighton <luke.leighton@gmail.com> wrote:
>> where can i get information (specifications) on the format of git
>> pack-objects... please don't say "look at the source code" unless
>> there simply doesn't exist any format specifications. =C2=A0as part =
of the
>> git p2p bittorrent vfs layer stuff, a "file save" operation doesn't
>> "happen by magic": i need to actually verify the pack objects
>> received: count the number of entries? =C2=A0or do i?
>
> Its in the Documentation/technical subdirectory of git.git[1].
> Look at pack-format.txt.

 star!  thank you.

>=C2=A0Its rather sparse though.

 good enough.

 .... ahh... ah ha!

  - The file is concluded with a trailer:

    A copy of the 20-byte SHA1 checksum at the end of
    corresponding packfile.

    20-byte SHA1-checksum of all of the above.

 i believe that will suffice.
