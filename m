From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: does a successful 'git gc' imply 'git fsck'
Date: Sun, 2 Dec 2012 08:01:49 +0530
Message-ID: <CAMK1S_iBq1ReGkjuy2UBENSQXOWyKj2ZzSCcg7Z89FVtVL2wMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 02 03:32:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TezLi-0003AK-Ln
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 03:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808Ab2LBCbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 21:31:51 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43573 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab2LBCbv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 21:31:51 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so982466eek.19
        for <git@vger.kernel.org>; Sat, 01 Dec 2012 18:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=keQUl5xVZURz8pOkzgJf2BSC5XV+8onJtGQmUxvMn3A=;
        b=jPByHxvTXCmymUrNfBVcutInYtwmlgY5Rab451XAEF/o2WpYzz5+sG8fpCMe01BmKC
         kijXtl8xHoM05uh9KWR0Ging1fyUeLeqHBFdtEIQ1214EEeUI2nW7f/3vvvxoXeuPBD+
         rW0ogKVHRG8phxHDDSiicmNgLCFQu3JfdYCpUjyHRKocgmVcSuQOy4oidyMFDmuSOcD8
         nqikNuJO0V++1RpsJvcltB7gVzdm82nOZ/DIiIPAeZDCK59ZLnlsVHnB+wBEjW2IjTBa
         iwPItgEs3pBdO6XlEIIWaUhwG9XqO5YICU4EYLS5lPYRgl+duPN0fMx1X7+X4qhtTW33
         izkA==
Received: by 10.14.215.197 with SMTP id e45mr21764059eep.0.1354415509854; Sat,
 01 Dec 2012 18:31:49 -0800 (PST)
Received: by 10.223.157.79 with HTTP; Sat, 1 Dec 2012 18:31:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210994>

Hi,

Background: I have a situation where I have to fix up a few hundred
repos in terms of 'git gc' (the auto gc seems to have failed in many
cases; they have far more than 6700 loose objects).  I also found some
corrupted objects in some cases that prevent the gc from completing.

I am running "git gc" followed by "git fsck".  The majority of the
repos I have worked through so far appear to be fine, but in the
larger repos (upwards of 2-3 GB) the git fsck is taking almost 5 times
longer than the 'gc'.

If I could assume that a successful 'git gc' means an fsck is not
needed, I'd save a lot of time.  Hence my question.

-- 
Sitaram
