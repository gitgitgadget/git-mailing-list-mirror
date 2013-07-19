From: =?ISO-8859-1?Q?Adam_Brengesj=F6?= <ca.brengesjo@gmail.com>
Subject: Documentation/git-checkout.txt: Inconsistent naming of paths arguments
Date: Fri, 19 Jul 2013 09:16:10 +0200
Message-ID: <CAJTcR-1RxLEaUe+c5yXEuKeC5Ert4FGm0=kUi7H-M-a+-Cp9-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 09:16:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V04vM-0006Zt-U7
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 09:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759785Ab3GSHQN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jul 2013 03:16:13 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60883 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759779Ab3GSHQL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jul 2013 03:16:11 -0400
Received: by mail-qc0-f174.google.com with SMTP id m15so2167852qcq.19
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 00:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Az5D8i4haR3Hstv9r9N7dStCXfIV0jhDu+JHM7uF7bA=;
        b=y3L1YWxNl11aOK5k7PeO2b43u1gDfUnrD+NU1aPceoG75sy0PmZS5AQJNyazWkXTJu
         fQHhb1yOUCh+qu24hgcL/93r5kkHhQpco63wP9xvg/NWkAa6Fzp5F/XJRaDP7II/aYIv
         hpeWc4sXGWoLO0k10RLRl6ffp2ZWDKT8hYFDeYAaeaJjFgxoJULUVLg9HhZOfreby0Vs
         PrnY2EZy+0xQSgwtJQaw4ezA7EmVnFnL2nsmVYgAKHHTd/cSMdCjI7lFNt+YFY5zMs3s
         XMRNRriCJaXnafZGo01o6/GYbnyxIySWut0Hqxpu3LFr3Q5LSUFC/YISrJ3RGMK/G3JQ
         WABw==
X-Received: by 10.224.32.131 with SMTP id c3mr4381691qad.62.1374218170611;
 Fri, 19 Jul 2013 00:16:10 -0700 (PDT)
Received: by 10.49.0.131 with HTTP; Fri, 19 Jul 2013 00:16:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230781>

=46rom SYNOPSIS:

git checkout [-p|--patch] [<tree-ish>] [--] [<paths>=85]


=46rom DESCRIPTION

git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>=85



1. Named <paths> in SYNOPSIS, but <pathspec> in DESCRIPTION. (It's
referred to as <path> in the body text).

2. <paths> is marked as optional in SYNOPSIS, but <pathspec> is not.

I'm not submitting a patch now, as I'm not sure which is correct.
