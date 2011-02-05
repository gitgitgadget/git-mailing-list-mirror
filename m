From: Jared Hance <jaredhance@gmail.com>
Subject: Re: ignoring file modes completely
Date: Sat, 05 Feb 2011 11:03:49 -0500
Message-ID: <1296921829.5467.1.camel@localhost.localdomain>
References: <4D4D6BC2.90101@io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: rkitover@io.com
X-From: git-owner@vger.kernel.org Sat Feb 05 17:04:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlkcN-0002cm-EJ
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 17:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab1BEQD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 11:03:57 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36564 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab1BEQD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 11:03:56 -0500
Received: by vws16 with SMTP id 16so2110562vws.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 08:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=ZWXD/BnInBcl3iAY7EZPbYHLaJ4dMWku2mDuJL/PxeI=;
        b=bDKnC1heJO2zLYUrhdRB++xDiILEzLXgXktJOhC6WECieQmWKtVaTbDphX9yy7hrtY
         0AmlCy8YGab+fZVOgeJdFKUT+b0Gmal8L2RSbYKXDMD5/448MnzGLm2w91EDsHqOQhbw
         C18sp/BJ4e3LTwAl+eoPpg5p5bKTX+OeIFP30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=njKFWZSr8br76cJjjB1h54sddmxP8M64Fl+YjafwRjON/4YRhVyAfl1yyawkOfpSfJ
         s3hxNr6wiu5k1Z79VNOzqhtDa+GCAS4ygAdOAJY1UgPiH7Fjktw04KDrnFj2o6VjY2NV
         fiSybAxaSiHgsOppuxuDCpyw+DMhHsXX9VhVY=
Received: by 10.220.190.195 with SMTP id dj3mr3574806vcb.131.1296921835943;
        Sat, 05 Feb 2011 08:03:55 -0800 (PST)
Received: from [192.168.1.101] (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id i14sm754666vcr.35.2011.02.05.08.03.54
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 08:03:55 -0800 (PST)
In-Reply-To: <4D4D6BC2.90101@io.com>
X-Mailer: Evolution 2.32.1 (2.32.1-1.fc14) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166099>

On Sat, 2011-02-05 at 10:24 -0500, Rafael Kitover wrote: 
> Hello,
> 
> I found the core.filemode option, which ignores executable bits, but I 
> need an option to ignore all mode differences, and such an option does 
> not seem to exist.

The only mode tracked by Git is the executable bit, so this shouldn't
even be an issue. Are you sure the executable bit isn't the problem?
