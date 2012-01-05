From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git-subtree
Date: Thu, 5 Jan 2012 16:58:22 +0530
Message-ID: <CALkWK0nU9iO_6CCbWw8c_Fz=xodkaAW4300Jpc7M7D+kBP=QRg@mail.gmail.com>
References: <nngaa638nwf.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: David Greene <dag@cray.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 12:28:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RilV6-0002kU-BM
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 12:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838Ab2AEL2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 06:28:45 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:44280 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab2AEL2o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 06:28:44 -0500
Received: by werm1 with SMTP id m1so278161wer.19
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 03:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Njcujrec4zydO0EBKUuk1DCTkShLreKNW/QlvfEXSQE=;
        b=UqZB3hywfaVNfnqEGS7c3fDSu5ln7l4waOjspRBQRuis0DOCRcBGXCnp9yHLS8kQ0M
         oz/5OwBQb+ASzV7xMCdk/4SBQxmvQ5abKu4zXqOIXXb7UJB0RqaKGH74kfOi2eswu5G4
         h4ZuQHWVNtTnfKlhINTL9XZDEABmtLeE5aWk0=
Received: by 10.216.209.99 with SMTP id r77mr777940weo.25.1325762923240; Thu,
 05 Jan 2012 03:28:43 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Thu, 5 Jan 2012 03:28:22 -0800 (PST)
In-Reply-To: <nngaa638nwf.fsf@transit.us.cray.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187972>

Hi David,

David Greene wrote:
> I have a patch ready.
> How does the git community want the patch presented?

Please read and follow the guidelines listed in
Documentation/SubmittingPatches.  The TL;DR version is: break it up
into logical reviewable commits based on the current `master` and use
git format-patch/ git send-email to send those commits to this mailing
list.

Cheers!

-- Ram

[1]: https://raw.github.com/git/git/master/Documentation/SubmittingPatches
