From: Javier Domingo <javierdo1@gmail.com>
Subject: Splitting files merge with branches
Date: Tue, 5 Nov 2013 10:38:45 +0100
Message-ID: <CALZVapmJDEWyUcgdJ0C0V0bKpSyukHZ=ei9GgVh-Z0yfb8x8tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 05 10:39:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vdd6O-00086R-Fj
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 10:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab3KEJjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 04:39:08 -0500
Received: from mail-vc0-f169.google.com ([209.85.220.169]:49906 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab3KEJjG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 04:39:06 -0500
Received: by mail-vc0-f169.google.com with SMTP id hu8so5568176vcb.28
        for <git@vger.kernel.org>; Tue, 05 Nov 2013 01:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=9umwOMmRMPy5tbN+oS27zgiL0Kh/p2rVkuGGIlw8Ty8=;
        b=ac/zFD9yZpb4I7IWCtEFA7e5MixZ9nDLiAuONqvaL/MT3oudGiUJVVQWqQw/U9kPCV
         kds6ArppxDQ+IMiKl/BIQJMPN+brVeRS/cLGJ1ddcnJffS6uUXS+K5VbdViehN8pPMhu
         Uq/DHGfYA8ue5iF17XTX6Cv7QDZ4jTiqvkx27UzPmfLO0vl5lL74TZQn/djVJE+k5g2w
         Uxn2ANAsG45wIDiGDx4jAL7EZncUyj9vvGQsWotltISpGcDf0SagAEV1EDY7fgUljVgw
         2tiJbzFNK14TPeTYoYN/enb/Eedllw1CPArMQ+xnVMsSwOEHsO8ji/jik7pu0pavUvlP
         4dbQ==
X-Received: by 10.52.187.138 with SMTP id fs10mr12086392vdc.10.1383644345223;
 Tue, 05 Nov 2013 01:39:05 -0800 (PST)
Received: by 10.58.233.203 with HTTP; Tue, 5 Nov 2013 01:38:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237325>

Hi,

I have been using git for now 4 years, and one feature I miss a lot,
that would increase the usability of git in many cases, would be
having it detect "inter-file" movements, so that if I, in a single
commit just part one file into many, git can track that change.

I suppose this is quite difficult, as would mean having extra features
in diffs, and I don't know how could it be implemented, but that would
ease even more having integration branches, and merging one with
eachother.

I wouldn't either know how to split it, in the means that if 5 lines
are in the middle of a split, where would those lines go? But as you
have resolved quite variety of problems, you might now a way.

Just wanted to collaborate with my idea =)

Cheers,

Javier Domingo Cansino
