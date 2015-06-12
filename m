From: =?UTF-8?Q?Nico_Schl=C3=B6mer?= <nico.schloemer@gmail.com>
Subject: merge master into the subtree branches
Date: Fri, 12 Jun 2015 08:27:53 +0200
Message-ID: <CAK6Z60ceAsaGkH9b=VLese=nEcCz7rDzsvCiKpfQHT9+jOd4eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 08:28:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3IRy-0006GA-8b
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 08:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbbFLG2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 02:28:17 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34369 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbbFLG2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 02:28:16 -0400
Received: by lbcmx3 with SMTP id mx3so14393684lbc.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 23:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=54paAW3O7/mKxFBgeMMLusV2jS8CS2M++XPUGHkm2CU=;
        b=CTfeL78+fSNOyXi4kRlIJEMz3NaiIAGip3ECjOW+MhkqoY3nkojCdPuGeOVjyVYpFz
         dGPNxPgc7zXUPJ/BTpugkWzhc2Z6KvtIIe2QGUX1VHG5hZg7bg4g6vDU61e9I7gmUhmt
         0Gimx8HuttPUHXs6zcrJiRFFbHEduCt3cz5Dh+hS138iUQTnn40Rz9GqeO16pDo5azr6
         VJ+4iHr+GE9lxEuGVuZ2DdPjJGtuOKkWiavAOMu3Dv/yqvUFzfhXrtpmeV81h3Dg+VLg
         meSK3VdlkbzZtNZZkUragdQVFRDGV6UyWHaahuMBYI195k8ZIfG3RyZoIYH2ZWPACpdi
         eJpw==
X-Received: by 10.152.44.132 with SMTP id e4mr13805188lam.34.1434090494687;
 Thu, 11 Jun 2015 23:28:14 -0700 (PDT)
Received: by 10.112.155.41 with HTTP; Thu, 11 Jun 2015 23:27:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271473>

Hi everyone,

I have a large Git project which I would like to dissect into
subprojects with their own repositories. Git subtrees are ideal for
this task: I first

 * create a branch with the contents of only one subfoldergit subtree
split -P <name-of-folder> -b <name-of-new-branch>

and then

 * pull this branch into another repository.

For a transitional phase, I would like to have the subprojects
read-only and sync them from master. The question is how to organize
this. For every commit to master, I could of course perform the above
procedure repeatedly for all subprojects, but this seems less then
ideal since it does all the work all over again.

Is there a way to merge master into the subtree branches?

Cheers,
Nico
