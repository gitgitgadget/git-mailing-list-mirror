From: "Jay Soffian" <jaysoffian+git@gmail.com>
Subject: Re: [PATCH] Improve git-help--browse browser support under OS X
Date: Sun, 10 Feb 2008 21:13:47 -0500
Message-ID: <76718490802101813n5b2121fcp25b4c65eb32ab14e@mail.gmail.com>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com>
	 <76718490802091815s45c19113t938f5257aad3f46c@mail.gmail.com>
	 <20080210124336.GH30368@dpotapov.dyndns.org>
	 <200802101445.16033.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 03:14:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOOBc-0000Uy-Af
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 03:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbYBKCNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 21:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbYBKCNt
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 21:13:49 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:2235 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbYBKCNs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 21:13:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1872808wah.23
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 18:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=rmiDKw850G3Ckd2cvBQwjZ4+SrmkxTNKXeOtdwpazGY=;
        b=wXpwEt7MwuAiOqqXgucis5lYnrpjV5DJ18wK/iZWujLOLD6CiRa+RY2WuvTXN+M19q8aHQ7e5E0uWQpwP3JdfwtIoMLPo8MXXrXfPGLXMZs3IMUncsT+WzEyVjE1tDA5OsiqIH5q2z7pBJ6HZbSMNIxKhG/HbgGdPxZaaAgJmfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=tcCg42fYoAJXBqIWSGSEH4wuQzIN5jxC4Ay1VVeeusDykOugjNqNPizrom3sdk+k0MAZt+k2kZST7wklACJokxAWlMihv57hf6+1XXpedJmz1yb4dEMMP3YO+oJ7R8o9Mv5Bi2gnWFrI1dL1ECmOko2hauowUa34D/Pikn4Gi2M=
Received: by 10.114.175.16 with SMTP id x16mr8682310wae.12.1202696027721;
        Sun, 10 Feb 2008 18:13:47 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Sun, 10 Feb 2008 18:13:47 -0800 (PST)
In-Reply-To: <200802101445.16033.chriscool@tuxfamily.org>
Content-Disposition: inline
X-Google-Sender-Auth: 4e8a0621f0345d5a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73456>

On Feb 10, 2008 8:45 AM, Christian Couder <chriscool@tuxfamily.org> wrote:

> I wonder if "open" works on OS X outside the OS X GUI environment. (And do
> people use OS X outside the OS X GUI environment ?)

"open" simulates double-clicking on a document icon, so, no it does
not make sense to use it unless the GUI is active. What I was
referring to though is that you can't ssh into another OS X host and
use open, even if there is a user logged into the GUI on that host,
for obvious security reasons.

> In the git "next" branch, "git-help--browse" has been
> renamed "git-web--browse". And the original patch is
> against "git-web--browse" except in the title where it is
> about "git-help--browse".

Yeah, my typo in the title.

> Anyway now in "next", "git-web--browse" is used by both "git help" and "git
> instaweb", so the documentation of both commands need an update.

The git instaweb documentation update should be in a separate patch.
Though I think maybe the right way to handle this is add a new doc for
git-web--browse and then have the instaweb and help docs refer to
that, no?

BTW, what is the reason for the two-dashes in git-web--browse's name?

j.
