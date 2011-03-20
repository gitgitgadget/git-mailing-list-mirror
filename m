From: Daniel <daniel@netwalk.org>
Subject: dependable submodules
Date: Sat, 19 Mar 2011 17:53:26 -0700
Message-ID: <AANLkTi=JVO+KhnLKR-PvNQQFaZLhUmiVbKFxuytYEpmc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 20 01:53:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q16tl-0005ba-9X
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 01:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375Ab1CTAx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 20:53:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58067 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab1CTAx1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 20:53:27 -0400
Received: by wya21 with SMTP id 21so4876194wya.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 17:53:26 -0700 (PDT)
Received: by 10.227.2.148 with SMTP id 20mr2668253wbj.220.1300582406174; Sat,
 19 Mar 2011 17:53:26 -0700 (PDT)
Received: by 10.227.2.148 with HTTP; Sat, 19 Mar 2011 17:53:26 -0700 (PDT)
X-Originating-IP: [216.228.174.132]
X-Google-Sender-Auth: FBL8YRhIck5e-vGo9h6nnT_jJlc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169482>

I have a submodule from, example, github. I do not however want to be
reliant years from now, that this remote repository on github is in
existant. Yet, I want to be able to easily do a git pull in the
submodule as long as it's around.

Is there a way to achieve this?

IOW, I may have

    myrepo/somefile.txt
    myrepo/another_project/.git/...
    myrepo/another_project/another_project_file.txt

and I'd like to, when I clone repo, to be able to get all files from
repo=A0independently of the remote repo's existence.

Currently, if I do=A0`git clone --recursive myrepo new_repo`=A0I can ge=
t
almost the behavior I want with the exception of the other project
being pulled remotely, which means I would *have* to have a network
connection to do so, but as mentioned, I don't want that dependency.

-d
