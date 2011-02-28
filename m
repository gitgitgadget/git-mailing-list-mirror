From: David Chanters <david.chanters@googlemail.com>
Subject: git-grep to operate across who repository and not just CWD?
Date: Mon, 28 Feb 2011 00:17:28 +0000
Message-ID: <AANLkTimnOSzF1o-fX-n7b26Qx2aLP3aU3pTMGY_f5hKy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Chanters <david.chanters@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 01:17:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptqnu-0003fR-HL
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 01:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852Ab1B1ARa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 19:17:30 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48436 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab1B1AR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 19:17:29 -0500
Received: by iwn34 with SMTP id 34so2649897iwn.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 16:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=1sPdeckjXRCG7WoogLK7Pe3Gu2ibXKd+5YjT0x9HTrQ=;
        b=VAUHkT0ud0FPlydQdnT1n5Q3pcTF6n/eWIAG6hJuqgpd8z16JGl6Axkztw783DXFv+
         unO/HIdPPTIcKOOfQ7kHANlWguKjUW7cmUSzWdUyF8xCsvP4d9pPi1FIhUTlEuAlW4/A
         k+vVo9o7HAkQ//vgrXpy2xwmfTLj8Y27Rs+pA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=wkV8+0h4FDDCXn/yXAMv3iWaOJEV2V6VZSx9oOY+02rWNX99Wr9GE68Ir0BPwuhBfj
         b+AIIwzjXGBx3NPjum7rRlS6XLArx9Lx97YznehcS274IYg5zn0yWihQanysbI99q7r5
         JWDnt/UpzOdFbTMIMybv+CPFpEcxbLh8C6IZo=
Received: by 10.42.155.70 with SMTP id t6mr1189283icw.418.1298852248529; Sun,
 27 Feb 2011 16:17:28 -0800 (PST)
Received: by 10.42.170.196 with HTTP; Sun, 27 Feb 2011 16:17:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168063>

Hi all,

[ Please Cc me as I am not subscribed to this list, thanks. ]

I'm wondering if there's an easy way to get git-grep (and I suppose
other commands which operate on a per-repository level rather than
per-tree) to work across the whole repository?

Often I will be in the depths of my git repository, run "git grep
--options 'search string'", to find no results.  Of course, then I
remember that git grep doesn't work across the whole repository, it
works like normal grep, and only considers the CWD onwards.
Typically I end up cursing, using {push,pop}d to recall where I am,
cd'ing to the root of the repository and running "git grep" from there
and then poping my CWD to go back to where I was.

Is there some clever trickery or command-line flag I've not read about
in the "git-grep" man page to make this idea more seamless?

TIA,

David
