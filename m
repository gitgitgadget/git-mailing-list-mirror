From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Revert a single commit in a single file
Date: Fri, 25 Feb 2011 11:34:18 +0100
Message-ID: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 25 11:34:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psv0D-0005Ez-T0
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 11:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352Ab1BYKeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 05:34:20 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39934 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932319Ab1BYKeT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 05:34:19 -0500
Received: by vxi39 with SMTP id 39so1237788vxi.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 02:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=b+EPLJaN6UbqgDgVUW2/sjafBc2g/Vi1jNbjJcuTRO0=;
        b=N/Iqyd6xvkjIhDHN2CpXZLFBgPEAlQihANUNFHyuLBC+aFvaLwSk2MVhzSvHAp7vDm
         5MJVgBS6yUsjeGNCnamKwgIw7skDKVDEKujmQCJLlkghIxAmryUC/rmARn+iIgqXMeT0
         n3W9jN7wECxPwrR3YjU71Zn1LLWno2Zblq1MU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=xw3mIl9CcW4+JHar/Ihi/Dm85CqhVJYMG29HRCiFzJCiR9by4E30hfwzl5LoDIrt66
         cfF1ppsMDeTiLqY5bTPjWSZr3UGe0HZu5LLZ2bH7oxp5ciJwbL0nAbbjh2MWUaUiK3fN
         Q/sDPSD+dcip7ueIL0A0Eb2QVN/dHEp3x12dU=
Received: by 10.220.181.77 with SMTP id bx13mr544251vcb.70.1298630058620; Fri,
 25 Feb 2011 02:34:18 -0800 (PST)
Received: by 10.220.186.131 with HTTP; Fri, 25 Feb 2011 02:34:18 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167898>

I tried asking the same question on the "newbie" list some time ago:

http://groups.google.com/group/git-users/browse_thread/thread/d562b4eeac016711

Basically, when I go
> git revert <commit> <path>

.. my expectation was that a new commit would be made reverting the
changes from the old commit, but only for specified path/file.

Maybe it's a bit of a corner-case, but still would be nice to have
once in a while. What do you think?
