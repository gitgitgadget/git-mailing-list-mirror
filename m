From: "Ian Dees" <undees@gmail.com>
Subject: Completion message for git-clone?
Date: Thu, 7 Feb 2008 19:09:54 -0800
Message-ID: <ad4f9af90802071909s4dad180as26b2dd8b7600342f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 04:10:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNJdI-0004bu-Hw
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 04:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755942AbYBHDJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 22:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755266AbYBHDJ5
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 22:09:57 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:28511 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbYBHDJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 22:09:56 -0500
Received: by wx-out-0506.google.com with SMTP id h31so3924179wxd.4
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 19:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=7L3ESA0cfCiP1ukHbiic+W0cbbGmmbnEtUICjH2uJbI=;
        b=v7+lNngC6mTy6RV5Q+z1m2UJDclft2N3+21cg0YZ2/by8fY1MhW80JWXtk2Q5I2JEh0p3ipYzj/0kTI6Fh+rJZP0atJ75T4mv3oditpf0teLRqgroqTsZW6gRkb6qsSxwq28NMWLEneXyru6EQD2MCdu6TwSr1NCCyvMB6v9J8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PJHpZS25i00J2oHTrpEISIk3fS2B0Nv8w4slb7qOb9kuwkmz3ww9x9Oh9NbHuRqau5/zq56w4LIIcVA3LRKMM96WRB7wyFG94jVLR5PbyWc+jNZluwnDhFu+0fpFYIf/Uvkg7B070eF3p5evljjcQHvlAlXXgqxWUrf218/k8os=
Received: by 10.142.147.15 with SMTP id u15mr6651201wfd.149.1202440194640;
        Thu, 07 Feb 2008 19:09:54 -0800 (PST)
Received: by 10.142.238.18 with HTTP; Thu, 7 Feb 2008 19:09:54 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73029>

Hi, all.  Upon cloning a repository, the initial message reads:

  Initialized empty Git repository in path/to/new-repo/.git
  0 blocks

I'd wager "empty" means, "empty because Git is about to populate it."
Even so, this wording could be a bit surprising to new adopters,
especially coupled with the "0 blocks" suffix (is it really creating
hardlinks on NTFS?).  The impression is that the clone didn't work.
The impression is, of course, eventually dispelled by looking inside
the new directory.  Is there a way to clarify the overall status of
the clone operation?

One other minor thing I noticed while futzing with clones: if you try
to clone an empty repository, you get the same "Initialized empty
repository" message, even though no such second directory is created.
I'm not suggesting Git should suddenly start allowing empty cloning,
but perhaps a "Empty repository; skipping clone" message would be
helpful.

--Ian
