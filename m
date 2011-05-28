From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFD] Proposal for git-svn: storing SVN metadata (git-svn-id) in notes
Date: Sat, 28 May 2011 17:55:45 +0200
Message-ID: <BANLkTinorqTQOBw46mYJYfEWTEXC+Myzpw@mail.gmail.com>
References: <201105281154.25223.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 28 17:56:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQLs6-0002PQ-2p
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 17:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665Ab1E1Pzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 11:55:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64993 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab1E1Pzq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 11:55:46 -0400
Received: by fxm17 with SMTP id 17so1813864fxm.19
        for <git@vger.kernel.org>; Sat, 28 May 2011 08:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=drMN7+YArIsRpAh3hsAAijI40gf7lF+I7GXBchYPH5E=;
        b=Am2HW5UcEzPyRlxBKilLNSddNIXCeIrJ2z7cYfHsGrimedoG9NDXKO8xyYXJofUjho
         HXLWvzn8TaaoY/GjpMNNuJRoONmc1gy1KtZ/ug5GBKm5UnxV7uZrU1QEDPaOprp2fO3S
         T9m79HCOblet14kWglKnExR5+ybYl0YBaFo1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UFD8iTxR4T9HJYxevMOH7IuFn80ZyfH7JwyQYL0eAMBTjWGTplu7iJTWXNMfWiXfZ5
         wUk8TUy2U5VWkQD/Ek5jgf6++kvhdnZxyy64Br4LtI9/kPEG2Zr+LXj9rYKdsYeNRK8A
         QqN5iYSYVH+6ZXwQt8Lp1Bgu/icjgkU/LdY/M=
Received: by 10.223.73.139 with SMTP id q11mr3638207faj.56.1306598145448; Sat,
 28 May 2011 08:55:45 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Sat, 28 May 2011 08:55:45 -0700 (PDT)
In-Reply-To: <201105281154.25223.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174663>

2011/5/28 Jakub Narebski <jnareb@gmail.com>:
> Now that git supports annotating comments with `git notes` utility,
> could we have an option to git-svn which would make it store SVN
> metadata, i.e. git-svn-id: lines using git-notes (separate svnmetadata
> or git-svn notes ref)?

One good thing about git-svn's current system is that you can easily
share your repository with someone else, and they can bootstrap from
the same commits.

Has the sharing of git-notes been improved to the point where that
could be done similarly transparently?
