From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: [BUG] aliases not working outside of a working copy
Date: Mon, 31 Mar 2008 17:19:10 +0200
Message-ID: <8aa486160803310819r3a905bbeg5f993a55aaf6efbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 17:20:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgLo7-0005nm-7p
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 17:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbYCaPTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 11:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbYCaPTQ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 11:19:16 -0400
Received: from gv-out-0910.google.com ([216.239.58.188]:39996 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbYCaPTP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 11:19:15 -0400
Received: by gv-out-0910.google.com with SMTP id s4so142091gve.37
        for <git@vger.kernel.org>; Mon, 31 Mar 2008 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=0Z4XnTYtQ8VgkAdPefmkPiCZUnrwRV80po7CH4WFNUg=;
        b=aGas4PiqSjJ4S0IR7LQSVlRH9mG4QOOjf5X6Gc7DrP2LqcyC4ON2NQMQEVOcU5OtjCvpmNfACPzcGtApIAeNJPFZgLAHey7I6wZX1fteyJm/zikD8Srh05wUVfX/KXMD5ZSIUwwU/G5sTrdsnIFkQZB4eMrzHpoeft5BTzJRVfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SuL0Xupsi2EBu19gRlGaUf6TE0pU/SZIbCuUg5gZZfFnKRKQXG8NbsoJyGt/tiM1mHgq3z0gWyz2gcQ14n2TroLvB60dlWAkp1FStBV1Jz2C31RtFFWmq6tMehuRDCaid19xPdR8VdHeoD0+2bf1nklSp7hxa8/dyH1fyWkJ9k8=
Received: by 10.150.150.3 with SMTP id x3mr3417644ybd.93.1206976751007;
        Mon, 31 Mar 2008 08:19:11 -0700 (PDT)
Received: by 10.151.14.14 with HTTP; Mon, 31 Mar 2008 08:19:10 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78586>

Hi *,

  I use the following alias:

[alias]
        wdiff = diff --color-words

and it no longer works outside of a working copy since:

af05d67 (Always set *nongit_ok in setup_git_directory_gently())

The problem is with the alias system that detects if you are in a
working copy, not with the command, as the
command just works fine.

Santi
