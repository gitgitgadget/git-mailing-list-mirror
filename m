From: Edmond Halley <halleyinvent@gmail.com>
Subject: How to query the version of a file?
Date: Wed, 25 Aug 2010 14:33:30 +0800
Message-ID: <AANLkTi=upbiD5EBumxNxG0YvSRZN0mDfvu7LeU0y0Zpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 08:33:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo9YR-0003Su-2a
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 08:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab0HYGdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 02:33:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38308 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab0HYGdb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 02:33:31 -0400
Received: by iwn5 with SMTP id 5so326066iwn.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 23:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=i+CMuCxEx23RUmkf4Zr9oB4Ox1sdccUVQZKSLDspPkY=;
        b=PwV48wUL+bYAGFvZSlzj8c9ZZIJLBhClI/XPYvPpA7luBAcyVT86nUcb17lHxL/cQh
         cPG4JVvKghNGrPu8viO4nC3nOBoIWH3qE7bFjD0HI+TyOlSD3tnRrHACF75cy2jeqTr9
         NqAX9Wrs9+xe6tusC/krMBPZdngpvSYQgV4u8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ABDalXRWLgrqVIsrssAdjdvDgoDEh8ArYy/xqi8rUW5LU9mUggPLRfZmxNDS4L6EQi
         LgtpXus+jjnG+lGggy3D75WViKihLjkgZ1hIC3yPTZpgXJKA6WU750BWp/EdjnEKL/KO
         zQ2TOSgKxjD/aMosyOF6qNKGqfl8BPu928o7c=
Received: by 10.231.32.75 with SMTP id b11mr8839918ibd.162.1282718010563; Tue,
 24 Aug 2010 23:33:30 -0700 (PDT)
Received: by 10.231.119.140 with HTTP; Tue, 24 Aug 2010 23:33:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154427>

Hi,

I have a standalone repository.
File a.cpp has 3 versions.
For example, I checked out version2(HEAD^).
> git checkout HEAD^ a.cpp
After a few days, I forget which version I have checked out.
Is there a git command that can query which version is checked out?
"git status" will show there is "changes to be committed", but with no
the version information.
Thank you!

Best regards,
Halley
