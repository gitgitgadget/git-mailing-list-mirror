From: =?ISO-8859-1?Q?Daniel_Nystr=F6m?= <daniel.nystrom@timeterminal.se>
Subject: [Q] Mark files for later commit?
Date: Tue, 29 Mar 2011 08:04:00 +0200
Message-ID: <AANLkTi=rPAQas3gvHJ+EFYTXP_YXuULQMk8o8pgkj=9T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 08:04:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4S2R-0002vP-IH
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 08:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509Ab1C2GER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 02:04:17 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37206 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab1C2GER (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 02:04:17 -0400
Received: by iyb14 with SMTP id 14so3907216iyb.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 23:04:16 -0700 (PDT)
Received: by 10.231.16.135 with SMTP id o7mr5096401iba.66.1301378656080; Mon,
 28 Mar 2011 23:04:16 -0700 (PDT)
Received: by 10.231.33.65 with HTTP; Mon, 28 Mar 2011 23:04:00 -0700 (PDT)
X-Originating-IP: [85.24.181.147]
X-Google-Sender-Auth: aDNY0ZqPeTqYVVmrjQvpYJHqXYk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170225>

Hi folks!

I just hit into an situation where a certain file contains a human
written changelog, which is modified (not prepended) for each single
commit in the project, is being committed along with the actual patch.

This approach makes it very difficult to backport the commits, since
it will always try patching the changelog file as well.

The changelog is only supposed to be committed at new releases, but is
kept maintained continuously so stuff won't be forgotten.

So this makes me wonder, is there a way to mark certain files for
being committed later on? Which does not automatically get added to
the staging area (on "git commit -a" or "git add ." and so on) unless
it's specifically mentioned by "git add"?

We've discussed making it generated automatically, but that's not as
easy as it may sound.

How would you like a git feature like described above, marking files
for later inclusion?

Thanks!
--
Daniel
