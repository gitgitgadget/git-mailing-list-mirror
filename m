From: "Yin Ping" <pkufranky@gmail.com>
Subject: Issues for git-submodule
Date: Sat, 20 Oct 2007 15:31:00 +0800
Message-ID: <46dff0320710200031x2a58706cl7d3df11cad12d4d2@mail.gmail.com>
References: <46dff0320710200027o5fe434b4i9bd4f3ffc17f03f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 20 09:31:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij8oF-0001FL-GG
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 09:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757115AbXJTHbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 03:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763306AbXJTHbD
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 03:31:03 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:9801 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763023AbXJTHbB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 03:31:01 -0400
Received: by py-out-1112.google.com with SMTP id u77so1392910pyb
        for <git@vger.kernel.org>; Sat, 20 Oct 2007 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ji214LzpDmNsJpHdLFOFUcHHIuuL6P9nmrFpQPe9ZDs=;
        b=OSHhR1jKrgNvFrL1shwDjqoo/iJr3RULMxpb+xwS2qi7f0ue6rFeevtqp0k3c/ieIT/apWuTcA1p8Yufx7jSgAPeIO4qOJJ7T6nZy9K+vjGdMSPVE7H00olRYXd3Qw3hq4jV+eUs7Riu6HlXgnHKSMLjOogQYsrDXLUpeLBM4Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tCDD6dXwRGso0VajHuPo9fVMWALi71acKcsgb8WDVLFeurQakVOmjn4AbVtBt0unZAYBXlM42AJGhZmy9Wd/gVgIIoDrWBkM+qL+aoTHErYbLx2p2nw8G6CfJLFCV+EoVpQlBsRHQZUQKkzo22l4+l+w1LwAcxk8fINYrgscwSc=
Received: by 10.35.12.10 with SMTP id p10mr3101605pyi.1192865460306;
        Sat, 20 Oct 2007 00:31:00 -0700 (PDT)
Received: by 10.35.52.7 with HTTP; Sat, 20 Oct 2007 00:31:00 -0700 (PDT)
In-Reply-To: <46dff0320710200027o5fe434b4i9bd4f3ffc17f03f6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61805>

1. gti-submodule status
   As the manual says, '+'  is shown if the currently checked out
submodule commit does not match the SHA-1 found in the index of the
containing repository.

  However, not matching has two cases: one is a new commit in the
submodule, the other  is update of index of the submodule after a
command such as "git-pull".

  So which is the case when a '+' is seen? Should i run 'git-commit'
or 'git-submodule update'? As a suggestion, I think git should tell
the user which commit  is newer (the one in supermodule index or the
HEAD of the submodule) and even give the log entry between the two
commits.

2. As I first saw 'git-submodule status submoduepath',  I thought it
should do the following thing
   cd submoduepath && git-status && cd -

   This is actually what i need, espacially when i have a lot of
submodules and has made changes in some modules. How do i know which
modules have been changed and how they have been changed?

  So, In some degree, I even think current 'git-submodule status'
should be replaced by git-status and the right thing 'git-submodule
status' should do is to show the status of submodule itself as i just
said above.


--
franky
