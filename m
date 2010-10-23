From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: add a note to help contributors catch
 some errors earlier.
Date: Sat, 23 Oct 2010 15:11:19 -0200
Message-ID: <AANLkTikCr5yRHzetY9-T=_rg+PZM-e8ZnQvL79ucws+6@mail.gmail.com>
References: <1287843434-10890-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Oct 23 19:11:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9hcs-00019A-PI
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 19:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758091Ab0JWRLV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 13:11:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50464 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758002Ab0JWRLU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Oct 2010 13:11:20 -0400
Received: by bwz11 with SMTP id 11so1354163bwz.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MSleFzTe3Sg+I/ROmC+9tMCXB2eucAjjVF8fogGzOFs=;
        b=tCk3H5rnGulol6TLXHVz04YQylE9bGraPh9T6UnWiaG2riIggqJO+LW8FsgLjkd0Cx
         qqgo34RryvOfWNk/h6nV+RpiuNjkGi0xcPPRiH1CDu8JOmsl1v5A+8A7zqZWe1zJztpN
         3NxjwNiWCU+L5IW1q37EPyeRldQYrHJxP8flY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lNEkqcgZfgPv7Uz4+tYl1xaF5ib9MoH0LWb2y/AHXFCpMurqcStdJ3q5Hol24/zUkW
         Nvu7iPDiRSCo9jXFiEI9mgnaK0Fn4SDqERWO5zkxy7vGR+qErAhilttoVRz2hemPox86
         RGvvWiARcYV8y2pneR3ZXX/jJ/5J4AClO5Wh8=
Received: by 10.204.71.12 with SMTP id f12mr636341bkj.34.1287853879181; Sat,
 23 Oct 2010 10:11:19 -0700 (PDT)
Received: by 10.204.72.82 with HTTP; Sat, 23 Oct 2010 10:11:19 -0700 (PDT)
In-Reply-To: <1287843434-10890-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159802>

On Sat, Oct 23, 2010 at 12:17 PM, Yann Dirson <ydirson@altern.org> wrot=
e:
> + - C code is expected to compile when the build is launched with the
> + =C2=A0 following command:
> +
> + =C2=A0 make CFLAGS=3D"-Wall -Wdeclaration-after-statement -Werror"

Why this is not in the Makefile by default? Also -Wall is already in
the Makefile.
