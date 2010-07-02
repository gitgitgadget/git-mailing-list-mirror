From: Eugene Sajine <euguess@gmail.com>
Subject: global hooks - once again
Date: Fri, 2 Jul 2010 12:23:42 -0400
Message-ID: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 18:23:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUj1p-0006jk-LA
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 18:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759179Ab0GBQXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 12:23:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51109 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758919Ab0GBQXo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 12:23:44 -0400
Received: by gye5 with SMTP id 5so475896gye.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=b68jxK51JsPrlDQA6wm6mg+iw7kuHZx8jqOST9fVWp8=;
        b=eQfjelYARzAgA/7mXKh/Lrbp3xvJ7RNY5Re0pmrwjxUyU0yN/Bt9nXdPyvJkHvZrei
         4yp99c3Gt0r9lVMtQH29QKApCxdEXIaOZyImLJO+7tqT8bLZPA/6CwSIvnkrVHvowQBR
         k1TtbdvkDstRodPtyxL/f5Zko9UsnXQ+aCn4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Nejz3Pgu+zDxHQWhT2qP5r1hKMNX6Ewbf2l1/we5IieHvfUfLrJeVedbP/SceiztDH
         coxkpLOCRDAewPR/iCrRXoS3EcEseWdjD5bFGi0vd9jmgpcLAoMz2EJIflcEW5derXrY
         Q9NVWwIPuU1APlkA52549bDekhQYrONc3/Bw4=
Received: by 10.224.113.201 with SMTP id b9mr549431qaq.328.1278087822734; Fri, 
	02 Jul 2010 09:23:42 -0700 (PDT)
Received: by 10.229.212.209 with HTTP; Fri, 2 Jul 2010 09:23:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150141>

I have found a thread dated March 2008 about the subject, but there
was no acceptable solution provided.
Template directory doesn't seem to be interesting.

Is there a better way now?

If there is no better way now Is it possible to create a git config
property specifying where the global hooks folder is and then look for
hooks there first and then in the repo or vice versa?

For example, so i could say
$ git config --global hooks.dir ~/git/hooks

It could even attempt to create the specified folder and create
necessary structure in it like below if necesary
/pre-commit
/post-commit
/pre-rebase
/post-rebase

etc...

Thanks,
Eugene
