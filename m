From: Angus Hammond <angusgh@gmail.com>
Subject: Re: git stash destroys hard links
Date: Tue, 22 May 2012 18:52:00 +0100
Message-ID: <CAOBOgRYtMi38f63G2Nzd3--FsmN0F8geFi-AHxL2L2MMHWHFHA@mail.gmail.com>
References: <CAAXzdLWadNg9d_i8fZTawaxYm3ytcGCT4pzeth=LxrQYEO-3ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Steven Penny <svnpenn@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 19:52:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWtFy-00054Q-LX
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 19:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab2EVRwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 13:52:22 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:55796 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753183Ab2EVRwV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 13:52:21 -0400
Received: by lahd3 with SMTP id d3so4502511lah.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 10:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zXKDm3GAJSK7XdMseEvdq50dZPevEqjm0Kn36Fp5fjM=;
        b=cnMh+chzU6m0SxOl4PmHcA8Lm3ys1KkKvss0HRzqp+2zImEVBCFY/br6CYYexxjBua
         Gv+h14CloJXzZ69QD4C+tY7ITDQMZoV1ypc9pu/BJlFwOTyLJzdzZLH7IFkogrxtK/G4
         wXOlcheTdSoEhtf2WW6QROeYJMS00gHfLEVcadMbjJ44CFVZ99RkMvhwJgLNsT/6RVn2
         ZAtp8+L1o5KolkJEfelxSEpjjpNeGDStqXTmSALvWwIZ/uUT5GfcI6VrlRauof9QczEW
         hhT6VTrMpVACgL3PyL3N9ruIXB94F5nAmldaqNLZn0EH5oy8zyidnGbTVtsRQDk9LwOw
         sFZA==
Received: by 10.152.111.200 with SMTP id ik8mr23859396lab.15.1337709140301;
 Tue, 22 May 2012 10:52:20 -0700 (PDT)
Received: by 10.114.12.1 with HTTP; Tue, 22 May 2012 10:52:00 -0700 (PDT)
In-Reply-To: <CAAXzdLWadNg9d_i8fZTawaxYm3ytcGCT4pzeth=LxrQYEO-3ww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198215>

>From the very quick and unscientific test that I just did, it doesn't
appear that git commits hard links, it just collapses them into
separate regular files (presumably to avoid changes in one place
mucking things up elsewhere without git knowing about it). I don't
think it makes much sense to stash hardlinks if the policy is to
forget them in commits.
Thanks
Angus
