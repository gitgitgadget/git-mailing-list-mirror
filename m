From: =?ISO-8859-1?Q?Gauthier_=D6stervall?= <gauthier@ostervall.se>
Subject: Re: gitk refresh keeps showing dangling commits
Date: Wed, 4 Dec 2013 10:45:13 +0100
Message-ID: <CAM8gEgg2v+isLEcf_rmACBLoaKL0VoA8k=2BpM2JAiY8wNvWuA@mail.gmail.com>
References: <CAByu6UVWWW+5QKfVD30_LR4UF3991PLMRHGo6WWgrxOPXws0mQ@mail.gmail.com>
 <CAByu6UXXVRoQtFkU+A3E885pxVoiPdXXwXbozBP9gciD9BZMBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Thibault Kruse <tibokruse@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 10:45:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo91Z-0007My-7s
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 10:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154Ab3LDJpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 04:45:36 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:48997 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260Ab3LDJpe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 04:45:34 -0500
Received: by mail-wi0-f178.google.com with SMTP id ca18so7869624wib.5
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 01:45:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Nj6V9BKHM9xdrSzrY5mhCPgLgKzLYyyTJWRLIOW8vCM=;
        b=crd8XfsjOIdUITVteiz0cx2iaJY/vZ7zVSkIRZJ26KAko4Q9utZTDtT1IJiOpavFDh
         UU22gVuLZECWA+sFWQDlHSf2oO5DR3Et8mumff+LIODcOOxrREXg/d+W+f4zgEuHuPRC
         EOM6Jc3d0F3UGEJdwFqx4+zi23R//vmdRgHsjfqrWZy7Z56ikQ3OdjgAIampZ210cuPa
         I7UOcnlVO8ryaXP9dpIJ8m4UNHoD7SJj+CMZC6uGX8PkxqvmsrJZLPBen5NB0QYrRiB8
         ZFvtqxWrysbAR419lWWbHdFh9X1ACLomtMGh64pGH0HQeMUMl2Hydh57BaIKA3HLCcZy
         XpNA==
X-Gm-Message-State: ALoCoQmxvTqIxhfgOmgJppkWUNdRC0E3J3auh6L/A0FRhLJLjojtumFmG98e899LSIhAusQQJYHz
X-Received: by 10.194.6.161 with SMTP id c1mr157253wja.89.1386150333251; Wed,
 04 Dec 2013 01:45:33 -0800 (PST)
Received: by 10.180.104.165 with HTTP; Wed, 4 Dec 2013 01:45:13 -0800 (PST)
X-Originating-IP: [212.247.43.194]
In-Reply-To: <CAByu6UXXVRoQtFkU+A3E885pxVoiPdXXwXbozBP9gciD9BZMBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238767>

On Fri, Nov 29, 2013 at 4:27 PM, Thibault Kruse
<tibokruse@googlemail.com> wrote:

> and in gitk, I select "Reload"(Ctrl-F5), and I still see both commits,
> not just commit foo.

Do you use the menu entry Reload, or the keyboard shortcut Ctrl+F5?
The shortcut was changed a while ago to Shift+F5.
http://git.661346.n2.nabble.com/PATCH-gitk-avoid-Meta1-F5-td7444531.html
