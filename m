From: Fred <fred@akafred.com>
Subject: Fwd: git+svn - repo upgrade from 1.6.6.4 to 1.7.1 fails
Date: Mon, 31 May 2010 13:09:54 +0200
Message-ID: <AANLkTikYYjl6Gv8SRMvtmzW1pyzkyu_mwLyEGHdWuH00@mail.gmail.com>
References: <AANLkTin-k5zIDZysiLbTusqDwqxGWDxxAOPljLuRlIMD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 31 13:20:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ32w-00065R-4M
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 13:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287Ab0EaLUg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 May 2010 07:20:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40309 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab0EaLUg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 May 2010 07:20:36 -0400
Received: by gye5 with SMTP id 5so131718gye.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 04:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=v+Atr/Tx71ga+NTR/k3TD4WwLnY9ER/pzy6x0udFaE4=;
        b=n56WdLpWlsT5FGNX6VNb847XkX9V4sy1gK5xDJCh5c36dUGNGz10DgiERy7LuJZ9Of
         MjvVDzFBCfbxBH9i68v+Z/Bj9WUso+kYHWEihxQOLq0AbdrLf7lh/LKaX6Uj2tJwxzzy
         jvZzlWDxwNw1ixpMDJgj+6Z7XTtY/lD8obr7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=s42eV1Et6zK23Fmi1wS+2FHTa+PljfnTDrrcLtJT0u3E/x9sO0vg2IwQCpA+swlMWO
         5sDc8aKKW2Nacu5hku3pbdCV/4aHkm8XqtGecWIhkC7CdsQfo+jDr8x0EuRfestdkkYz
         qJgn3vtV9iy0Enuj5Fiql+j4mcpaAs1cWIGag=
Received: by 10.101.201.37 with SMTP id d37mr4589556anq.56.1275304509707; Mon, 
	31 May 2010 04:15:09 -0700 (PDT)
Received: by 10.100.210.10 with HTTP; Mon, 31 May 2010 04:09:54 -0700 (PDT)
In-Reply-To: <AANLkTin-k5zIDZysiLbTusqDwqxGWDxxAOPljLuRlIMD@mail.gmail.com>
X-Google-Sender-Auth: wKBNp9kGieCbrAE-BLIzz-kSRjs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148037>

Hi,=A0I have a project with two remotes - one git and one svn. One
branch is only used for "git svn rebase", and then I cherrypick or
merge from it into my master branch. Most work is done in the master
branch (or other topic branches only available in git)

The repo was created under git 1.6.6.4. After updating git a while
back (to 1.7.1) it was time to merge inn a few things from svn - so i
switched to my "subversion" branch and did a

$ git svn rebase

Migrating from a git-svn v1 layout...
Data from a previous version of git-svn exists, but
=2Egit/svn
(required for this version (1.7.1) of git-svn) does not exist.
Done migrating from a git-svn v1 layout
Unable to determine upstream SVN information from working tree history
---
I read this as: "I see your repo has some svn stuff and that it is
backlevel. I'll fix it for you. Oh shit, now I can't determine what
svn revision you are on."

Any ideas on how to resolve this? We're a dozen developers relying on
this so it would be nice find a way with minimal impact to the
users...

=46or now I'll do the rebasing in a back-level git client...

- Fred
