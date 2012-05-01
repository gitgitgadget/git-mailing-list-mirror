From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Is there any way to make hooks part of the repository?
Date: Tue, 1 May 2012 13:24:28 -0700
Message-ID: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 01 22:24:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPJcf-0004W9-Tm
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 22:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab2EAUY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 16:24:29 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:40349 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2EAUY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 16:24:28 -0400
Received: by qadb17 with SMTP id b17so1035618qad.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=UFJHA1halfN2ntaZXRGmpnKfHvPQ0pGtV/g+FQP+bkw=;
        b=cEC7byFasvy1ARPLxIZW6YpnNLfc7wHHOFkiXfVw1usZzXq+djnXvq4tXDfA41zur5
         YnDBdakJYpyErC1+8hsNdOOugJQWsAZ4VMsFiuKuci160JBZCv84vCZq3+Y6pbKZB6cm
         ajzsBo1hyb8bh/eUx4qctyWK9MVoDHTz1n2GZ8U9Zx7+tEfehGis6pfQszin1MlNYRTS
         waIFfp0/RmB4js6OtFgy1p/vgeup72OEBnT7WGW2g3CAMEFcZghpqgpn10yDC2FXwFm3
         Y/0Y5ZwxX+3TX+umkbitxVZOMBROnBxi8NtZJtD3R6ik/IRqDd+SfhE4fvlwnZ5AAbT2
         HFkQ==
Received: by 10.224.182.78 with SMTP id cb14mr22423522qab.56.1335903868117;
 Tue, 01 May 2012 13:24:28 -0700 (PDT)
Received: by 10.229.228.20 with HTTP; Tue, 1 May 2012 13:24:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196740>

Hi all,

There are a couple of things that keep going wrong while we are
working on our code base. Some of them are very simple to check for in
a Git hook. However, I get the impression that it is not possible to
"include" the hooks with the Git repo itself (so that "git clone"
would automatically set them up). Normally, this would not be such a
big deal: I would simply add the hooks on the server. Unfortunately,
this is not an option (we use Unfuddle and they do not support that).

Is there any way to get (some of) the Git hooks to run for everyone
without everyone having to install them separately? If no, is this by
design or simply a feature nobody has asked for (yet)?

Cheers,
Hilco
