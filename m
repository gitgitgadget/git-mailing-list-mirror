From: Arthur Debert <arthur@stimuli.com.br>
Subject: Commit hashes differ from local and remote
Date: Wed, 13 Apr 2011 16:38:26 -0300
Message-ID: <BANLkTimhx1tN7EzU94bpKK64P1F8P7MG0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 13 21:38:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA5ta-0002i7-JX
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 21:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757885Ab1DMTi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 15:38:29 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41859 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756652Ab1DMTi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 15:38:28 -0400
Received: by wwa36 with SMTP id 36so1131490wwa.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=2zCAoTVX8ekJFltlVOjEV/ovudydgoDn/UCk8vCi8lE=;
        b=oEkmqrEgKuLOLJno//kA1/EbRemiE7HbpKkGkNOfHTqL/vQrs/+fCNgc+LEOWrNHKg
         HrSW2vCrLk4EahS9wVFewVXfH06cBElG7S8/jwfbpheW8Xe40sTOYyD+H2hX07EoTzqW
         2CQ1e+ff4+54o1M70Ch3VL3bq0Zu4cjVz9Ozw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=xZibIHchlDX8um6Hy7Cj4kWao9FlflPRaFKdr8O16wtzpO5V/tGTK/9ZG7X+pBl7SF
         aAjNB+tIVkX0e5G4yjdiCaxvo3Je9c5cayfkOMg+1tLtpQoijHAcsH3Ud8X3sssJeWJU
         B8cKhYWxwhrZPXx5Mj79t2K9ddLl9eD0ki+sE=
Received: by 10.216.221.158 with SMTP id r30mr5726905wep.50.1302723507021;
 Wed, 13 Apr 2011 12:38:27 -0700 (PDT)
Received: by 10.216.22.143 with HTTP; Wed, 13 Apr 2011 12:38:26 -0700 (PDT)
X-Google-Sender-Auth: l88TjuwiDISqsCNvZo5KXxEBG_o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171478>

Hi Folks.

I'm seeing some behavior that my git-fu isn't quite capable of explaining.

On a local branch the last commit has a hash different than the remote
branch it is tracking from. Nothing has been committed locally and
doing:
$ git diff branch-name origin/branch-name
Comes up empty
git pull also says my branch is already up to date.

It seems that git pull has generated a bogus commit (a merge commit),
but I can't quite figure out why.
This is specially important since we need our app servers to have the
same commit hash once git pull is done.

Anything obvious I'm missing out? Any extra info that can help
pinpoint what the issue is?

Thank you,
Arthur Debert
