From: Dov Grobgeld <dov.grobgeld@gmail.com>
Subject: git-grep while excluding files in a blacklist
Date: Tue, 17 Jan 2012 11:14:59 +0200
Message-ID: <CA++fsGHGrNQzR-schP0yTXnD4jkYJjHHVk6QoJvfxPX9mguJPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 10:15:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn58K-0002n3-Eb
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 10:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572Ab2AQJPC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 04:15:02 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56029 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab2AQJPA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 04:15:00 -0500
Received: by bkas6 with SMTP id s6so1393037bka.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 01:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=u8NrKVFqylnIwVv2Q4Wo/3ZEnyPs+V5J5xYhg2/nBJk=;
        b=BNocNmW0mUxrPm+LY21GhDRM4TcoxGhZZZr4PM8wVLVV7wTndqOdE4VmDSib/JERAM
         9944FZT5ZtI0bsw4KSka5IcRqCOgose2/fbFCapqxn7jgA4Jd9htWs2wgEx/2JHUKKKm
         bqgDwxkhqhgsW90jjylG8H5b+nS/TC29eBn1I=
Received: by 10.204.141.14 with SMTP id k14mr6184111bku.67.1326791699285; Tue,
 17 Jan 2012 01:14:59 -0800 (PST)
Received: by 10.205.33.203 with HTTP; Tue, 17 Jan 2012 01:14:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188701>

Does git-grep allow searching for a pattern in all files *except*
files matching a pattern. E.g. in our project we have multiple DLL's
in git, but when searching I would like to exclude these for speed. Is
that possible with git-grep?

Thanks,
Dov
