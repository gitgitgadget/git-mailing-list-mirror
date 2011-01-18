From: Ilyes Gouta <ilyes.gouta@gmail.com>
Subject: Manually turning a --bare local repository to a real mirror
 repository (--bare --mirror)
Date: Tue, 18 Jan 2011 22:59:58 +0100
Message-ID: <AANLkTikE-sDhzw8=ybKhYhHtTH84V8EEOptMaq8xxRHc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 18 23:06:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfJhQ-0001t5-7n
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 23:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab1ARWGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 17:06:43 -0500
Received: from mail-yi0-f42.google.com ([209.85.218.42]:57960 "EHLO
	mail-yi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab1ARWGn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 17:06:43 -0500
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jan 2011 17:06:43 EST
Received: by yia28 with SMTP id 28so50766yia.1
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 14:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=MATpU3YURWjWvSsQ2njJKJ/Eq5PpaVp85HlP94dhZjo=;
        b=ZlfjhDcarK4BL7Qwms6b4vF+qFx0MluH9eY4goQk/r+un2THGavH9BZuLxqIlEBSZr
         11qkZrz6DokPF3injj8gvzG4WrEUIZYt9CuAeRrIjf8oc3HtyjBa1sFDOm6ULQSEE1AM
         HKwvt76ZrI5GCj1zpLzOHvCMNVWo85w6GkpsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=XLmnodXPaEcnjUAJ11hsWyUoTV9zZr1rnRq7ebWB3RlApyKELvFBSyZb2YiE6upGvv
         nKT4n6yuXpHWS0Q3YEF4XKm8ykarHwTw2Qv43iGJytRcwivxbV8a1S6WoR2uRxtNScfK
         Hoj59VlHtRwkuMEGMDlYbVT+Vm9UUJb/zvyco=
Received: by 10.90.116.1 with SMTP id o1mr7024332agc.127.1295388018652; Tue,
 18 Jan 2011 14:00:18 -0800 (PST)
Received: by 10.90.235.10 with HTTP; Tue, 18 Jan 2011 13:59:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165228>

Hi,

I'm setting up a local git repo which should mirrors the branches of
the original repo and at the same time hosts the local private
developement branches of the team.

At first step I did create a local copy by issuing:

git clone --bare <original_git_repository>

I found out later that fetching the various refs lead the local master
ref not automatically following the remote/master ref, after every git
fetch --all. I found that I have to use:

git clone --bare --mirror <original_git_repository>

instead to get that effect. Now please keep in mind that I intend to
also create local private branches where developers will push their
custom code.

My question: given that I don't have enough bandwidth and constant
Internet connectivity, I'd like to ask if it's possible to manually
turn a pure --bare local repository into a --bare --mirror one? If
yes, how to do that?

Please CC me when replying, because I'm not registered to the mailing list.

Thanks,

-Ilyes
