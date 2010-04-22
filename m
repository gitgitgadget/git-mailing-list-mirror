From: Eugene Sajine <euguess@gmail.com>
Subject: [BUG] git shortlog hangs in bare repo
Date: Thu, 22 Apr 2010 15:22:03 -0400
Message-ID: <u2i76c5b8581004221222ge8bb0b8cp55cb1f13d5f9692a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 22 21:22:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O51yW-0001Nb-NM
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 21:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab0DVTWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 15:22:06 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:50472 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740Ab0DVTWF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 15:22:05 -0400
Received: by qyk9 with SMTP id 9so11745987qyk.1
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 12:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:cc:content-type;
        bh=B3+yVWXP1lfWZuz5KeoDQey0FQeEhSmuuvMrl0oAbps=;
        b=enwYDwMgJ9KC/sLH3rqdgAiz/UknHA1h1VYSxGZwDGRcwcSpr/VUAL5aV+CtzHn64L
         awiEs0dl7cpKmNhsYBIQSleHfG7eCvOnlMSJnLpSfc3CNm4UP6PBthAVfb5yvx29hco6
         VjlT/rcE2lLjE9StwuPoVdfZD/N2VMikgaWlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=mv8eJk6XPW6IbFfIJJzjqnDq4r3lxsk7bNul70GtyE7aE1fMrHURotzOdAWAyr8pki
         qzuuE0G3op2UEfHyudErAMRD1peSQWSoZcZ2ANzYYu5hLrcGm+3UAegrvyCN0O+KeJu3
         1WSiOfoeGMuNcE6zAuYEjdv8yHtpuZEk/xpGU=
Received: by 10.229.190.202 with HTTP; Thu, 22 Apr 2010 12:22:03 -0700 (PDT)
Received: by 10.229.186.211 with SMTP id ct19mr373393qcb.16.1271964124084; 
	Thu, 22 Apr 2010 12:22:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145550>

Hi,

I have tried to run this command in order to get some stats from the
mainline bare repo. The result is that "shortlog" hangs for long
period of time and nothing happens. At the same time git log works OK.

Thanks,
Eugene
