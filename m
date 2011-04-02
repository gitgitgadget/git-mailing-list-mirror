From: Frederic JECKER <frederic.jecker@gmail.com>
Subject: Git enterprise setup on a large project
Date: Sat, 2 Apr 2011 21:50:55 +0200
Message-ID: <BANLkTikv4h3GBGB+hTHjJyAqwEmqZETyEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 21:51:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q66qg-00055O-0o
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 21:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756838Ab1DBTu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Apr 2011 15:50:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44116 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518Ab1DBTu5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Apr 2011 15:50:57 -0400
Received: by bwz15 with SMTP id 15so3204077bwz.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 12:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=Zjrz6g4fBWyFsifRzgOTFNr8VJlgtnoJU/k0VwVlWfg=;
        b=maFsSw9lrVEgfH6MzRzQg6r/FtImYhmc5abpvrOyi+iaSTNkF57s6Ne7LXjd2TJeFM
         Nhhi8ZUFdOcjADUdT0oCnAlSHrFTI48iSN1CTMwrWb0ZrwRwZKSx1Gg26Tf309PCaoeW
         7daIeGINY1eUbMlPKWJN5gTPxh9WPXaecaA2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=t2wFm1Ixsz2DJ3+cLgUwMeR0TN7Egz5+3yu5Zmj8xPLdjJNAVdnPf/CW7AXYUqEvmQ
         CuVGSSnFvBNH00366t2Xq+WXF1CopjFK7CW+LY2gSqX8fd90KvsOtBjUfczC0zZEcU1A
         ldU/l4R1ME1GzctTw/mVU/h/+aO36xvAJJ5eo=
Received: by 10.204.172.129 with SMTP id l1mr1128960bkz.99.1301773855746; Sat,
 02 Apr 2011 12:50:55 -0700 (PDT)
Received: by 10.204.137.211 with HTTP; Sat, 2 Apr 2011 12:50:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170659>

Hi,

I'm looking to replace my team's old and clumsy CVS server, as a GIT
user for personal projects I'm wondering what would be the best way to
achieve this using GIT. I've googled the subject a few times and read
books but I still have a handfull of questions

Our team is composed of 10 developers.
A common developer workspace takes about 1Go of space and contains
about 50 modules (up to 100 if the developer is working on=A0satellite
applications/modules) - we're=A0maintaining=A0a large java-based
healthcare system.
Each module is a CVS project.
Our use of CVS is.. well..clumsy too (don't ask me why we do things
like this, those were decided about 10 years ago before I started
working in this company).
=46eatures to be delivered in the next release are committed directly o=
n the head.
The project leader cherry picks the commits on his local working copy
within a dedicated workspace.

I first thought of creating a single project in order to group the
100+ modules and to ease the creation of maintenance branches.
Each developer would clone the full workspace from a "blessed" reposito=
ry.
The "blessed" repository would be managed by the project leader which
would simply pull changes from each developer pubic repository.
I tested this scenario but, as the workspace is really big, each
operation is really slow.

What could I do then ?
- Use submodules ?
- Create a blessed per-project repository and instead of a public
repository for each=A0developer=A0create a per-project public and share=
d
repository ?
=2E..I'm a bit lost

Thanks for your help

=46red
