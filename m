From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 19/23] http-push.c::fetch_symref(): use the new http API
Date: Sat, 6 Jun 2009 15:20:18 +0800
Message-ID: <be6fef0d0906060020x1a3a03a6ya4e58de6c83854d0@mail.gmail.com>
References: <20090606000559.483f22da.rctay89@gmail.com>
	 <m37hzq5rod.fsf@localhost.localdomain>
	 <be6fef0d0906051802n4f6d5df3g453b292787ed62d0@mail.gmail.com>
	 <7vvdnadj0z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 09:20:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCqCZ-0005lW-HR
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 09:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbZFFHUS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 03:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbZFFHUR
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 03:20:17 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:51386 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbZFFHUQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 03:20:16 -0400
Received: by wf-out-1314.google.com with SMTP id 26so872168wfd.4
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 00:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3RyCdcZ9Hvt1yWkEfwvgdcAJka8/0jxl8g1VvzSoxEI=;
        b=FyGjxU6e/w157snCVkdhj2lqR0xmnQCXkCiTny9Q8lDC8vDMDbr22BRGf7M1HYW9sF
         lA9nvemuQjAlnT0IqbKVjchS7XMXlh+Zsc4RP559PN4SmBBEHirlCBNBZQoeDGhSThzD
         YbyTZEWNklaZ6XTtSCClcip3KBucmqXLzzLtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a1hC0aA/ocifRvTrcdBsieILtowj1ttfF1b/gOh+3oEE8sIntYGzaSAYDc2GTqu/6g
         CTMcavov2tH66n01hAAuFkyIn2EPUrz+x4fBmuFh8VJ+VXB7Y0G7hwBCAHYdMfSQnBc2
         zDEQ/EXxwjJN35FatDJAyUJIZHUrze4g6L2J0=
Received: by 10.142.252.13 with SMTP id z13mr1444535wfh.310.1244272818777; 
	Sat, 06 Jun 2009 00:20:18 -0700 (PDT)
In-Reply-To: <7vvdnadj0z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120876>

Hi,

On Sat, Jun 6, 2009 at 1:32 PM, Junio C Hamano<gitster@pobox.com> wrote=
:
> Please don't.

Ok.

> =A0 =A0(5) Three-dash separator;
>
> =A0 =A0(6) Commentary to explain the history of the patch, and/or bac=
kground
> =A0 =A0 =A0 =A0information if necessary,

Is there anyway git can store and display these "commentaries"? I find
myself having to repeatedly write this.

--=20
Cheers,
Ray Chuan
