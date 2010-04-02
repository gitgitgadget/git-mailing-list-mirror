From: Simon <turner25@gmail.com>
Subject: git as backup and file sync system
Date: Fri, 2 Apr 2010 15:16:06 -0400
Message-ID: <m2q5f14cf5e1004021216y60797d29j1f63092435998823@mail.gmail.com>
Reply-To: turner25@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 21:16:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxmLo-00034M-7j
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 21:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab0DBTQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 15:16:10 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:44278 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516Ab0DBTQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 15:16:08 -0400
Received: by ywh2 with SMTP id 2so1537839ywh.33
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 12:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:received
         :message-id:subject:from:to:content-type;
        bh=h/N/K+vGxiEfUt8jZZkdYW+FHoMrCfciAhUURpb80gs=;
        b=nLLDWpojFNW9sW6mORr/sbkVLG1eWouLl4D03fyj4fYszqMEu0mEXkQhzF1nL0vhD7
         RDp1Ken3ik98HwVUtdKGmmWmvCwJN5Aggy2Fi/ebOsihfeIVhw0+XgcYfxwbocyskjZ3
         6f/pTC5M6sKhBsZqLoAGj3bwxhG5SOO8j1Dv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=h59kwP0vE+fSzXgV37fO3uV0I6+U9v1g8zpdwBMiiHFp6Vu5s/eH9iNvXHOYuh+OuR
         pLg4Se1aqEMVqmii0BK3HvQ8IKV+5S6dga3X/+OVVD4TPSGszZKg58Gij2Bb96fjnNLk
         E/7FXiG2tfGKo7esnWnKLlh3ww9SHME4XagVs=
Received: by 10.100.143.5 with HTTP; Fri, 2 Apr 2010 12:16:06 -0700 (PDT)
Received: by 10.101.59.16 with SMTP id m16mr6862315ank.84.1270235766835; Fri, 
	02 Apr 2010 12:16:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143838>

Hi there,
  I'm not sure if this post will be very welcome, but I'd like your
feedback or suggestions.  I've been reading Jon Loeliger's book about
git and I've understood many many things.  I'm interested in using git
as a backup and sync system between computers.

The one thing I'm missing is files metadata.  I thought the simplest
approach would be to create a "hidden" file containing the output from
stat (or something similar but more helpful).  Then hash that "hidden"
file as well or even make it part of the real file (ie first line of
every file are their metadata)...  I think I should look into some
hooks, but I'd need some guidance to get started...  help appreciated!

Simon
