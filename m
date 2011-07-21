From: rupert THURNER <rupert.thurner@gmail.com>
Subject: git svn v1 migration, avoid re-clone whole repo
Date: Fri, 22 Jul 2011 00:47:27 +0200
Message-ID: <CAJs9aZ-h8J_WYC1cXy9HojwArO8EqWSZnoZ1=LdrqHxeJxz_BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 00:47:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qk224-0003ju-Ov
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 00:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481Ab1GUWrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 18:47:48 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60592 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab1GUWrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 18:47:48 -0400
Received: by iyb12 with SMTP id 12so1273259iyb.19
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 15:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=auj68TArLT1E4unJuiVoWHE6zHIhyM5sphMW6FSJ/YU=;
        b=cXttWCbrVhHLjdHDfwntH65yFox6P7A+8sMuygFAkVWfz6H0Zw3w+ikBlGjBwQa6xZ
         OfEOR8T9owNLAmjpUjglzQrx38VKRbrG2RUeu1VzqPPhzoxKOPzZNVEMgyc4pAroXaSS
         6M8HA+ZkJu5Hdz9RTiQVdlfsSDdM0ctYxud9s=
Received: by 10.231.114.104 with SMTP id d40mr629296ibq.114.1311288467126;
 Thu, 21 Jul 2011 15:47:47 -0700 (PDT)
Received: by 10.42.96.193 with HTTP; Thu, 21 Jul 2011 15:47:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177629>

hi,

is there any other means of upgrading to the new svn layout but
cloning the repository afresh again? the error message i get is:

$ git svn rebase
Migrating from a git-svn v1 layout...
Data from a previous version of git-svn exists, but
        .git/svn
        (required for this version (1.7.5.4) of git-svn) does not exist.
Done migrating from a git-svn v1 layout
Unable to determine upstream SVN information from working tree history

rupert
