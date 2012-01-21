From: Harry portobello <harryportobello@gmail.com>
Subject: Including git-describe info as version strings for generic "-v" output
Date: Sat, 21 Jan 2012 19:09:56 +0000
Message-ID: <CAG_NL2So7cf6o+en9ktHGr94Eu5WJ9giWq6OmSxK+ZL4RdtaGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Harry portobello <harryportobello@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 20:10:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RogKF-0001bn-Ic
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 20:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454Ab2AUTJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 14:09:58 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52681 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab2AUTJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 14:09:57 -0500
Received: by eekc14 with SMTP id c14so786170eek.19
        for <git@vger.kernel.org>; Sat, 21 Jan 2012 11:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=UlwGiRK7ZoLEgHoO7nA2vwwdNYsLftrQoZg8lZdtAA4=;
        b=a0Qo6IwKXAKsjHgPAvvLmsZCaSCsmktqu3RqNZK9/uPGRSASuSolf8pCdsmPtxiRPw
         Xqw2egaOkPX0Yd82R4oXgLtxIJQeNfgcRtlR5NnGaDuDXVhXX+053McIXpoyknJxbaOU
         EpLNzxEaQ5bevEpPQd4xdiF/vK6MWtWYY1P+M=
Received: by 10.14.95.71 with SMTP id o47mr867018eef.95.1327172996368; Sat, 21
 Jan 2012 11:09:56 -0800 (PST)
Received: by 10.213.108.141 with HTTP; Sat, 21 Jan 2012 11:09:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188927>

Hi all,

I hope the subject makes sense -- I'll explain what I'm trying to do.

I'm wondering what the best approaches are to being able to include
output from git-describe [1] for generic version strings in projects
managed by Git? This would have to work from within an
autotools-managed project.

At the moment, I've managed to hook the output from git-describe in to
a few .m4 files, which works only at ./configure time -- but of
course, with this being Git, I'd ideally like the same mechanism to
work in a situation where someone does:

$ git pull && make

It's knowing how to plumb this in to the Makefile.am part I'm hazy over.

Any help would be much appreciated.

Harry

[1] I know it's "git describe"; I'm using its hyphenated form for
clarity of context.
