From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: The shared Git repo used by git-new-workdir
Date: Sat, 14 Jan 2012 12:59:14 -0800
Message-ID: <CAE1pOi3fBUBeNuhJqtJhxuMfz2G3iYOJy7U2HX6Nv4kqjcbnhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 14 21:59:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmAh6-0007DY-0L
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 21:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271Ab2ANU7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 15:59:15 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63568 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413Ab2ANU7O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 15:59:14 -0500
Received: by yenq4 with SMTP id q4so722456yen.19
        for <git@vger.kernel.org>; Sat, 14 Jan 2012 12:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=zMNlsyGypwys+Me1+NsFsMpGXNqlvFdfwUy/NBHyeoU=;
        b=Sq/jNY+zXn6zvb7339Z9CYIdqiTmlkts/pKplb/Wj9D8L/l4kGD8/vkE0+Z/z6LXVv
         jaKM4XitBEU/2+1XKyG4kmWyr/RoJ5MDATw1xtyrPINAHl/9b0jCdSGrplov4HXLzZwB
         xNjITyd5ZQ/vUdUxmW9FE16EaRYlpqidsmnbo=
Received: by 10.236.80.74 with SMTP id j50mr9585221yhe.2.1326574754189; Sat,
 14 Jan 2012 12:59:14 -0800 (PST)
Received: by 10.236.63.40 with HTTP; Sat, 14 Jan 2012 12:59:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188579>

Hi all,

First off, I use git-new-workdir a lot and it's working great. Kudos
to its developers!

I have been looking at the Git clone that is at the root of
git-new-workdir (i.e. the repository that is reused by all my
git-new-workdir created directories). This repo shows a lot of
activity when I run "git status" there.

So now I'm wondering. Should I simply ignore this completely? Or is
there some "clean up" I can do so that "git status" shows nothing? Or
would I destroy my git-new-workdir directories doing that? So far I've
only used this repo to create branches (i.e. to run git-new-workdir).

I would like to understand a bit better how I should treat this repo.
Whether it's basically a "do-not-touch" environment or whether I can
safely treat it as a normal Git repo.

Cheers,
Hilco
