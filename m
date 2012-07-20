From: Thiago Farina <tfransosi@gmail.com>
Subject: pushing branches
Date: Fri, 20 Jul 2012 12:26:09 -0300
Message-ID: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:26:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsF5s-0007dF-80
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999Ab2GTP0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:26:11 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41056 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab2GTP0K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:26:10 -0400
Received: by obbuo13 with SMTP id uo13so4968708obb.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=GnASkSJmog3gaLgRZMajx+gIsx3FxWaTv8iUkiw4oG4=;
        b=i1r6fmsitf8dw4p/RqmSAEyWm+hG0yWh1swPLyYp9vtgzM1M64bFYonHmSdR0F7d4s
         1Rn1EMPo/o9n7jiAF+GQ49cEKBFrpggVoYQFC+vVRwU2NVydXL3f1JWCzcop1I14cdsT
         NqUrY9jKOMoxS4oH2A4xcLUQWCqxswm5BbK91vpqC5y+M4kV7Epn8pqZwkvDkb3IHZUy
         PyxbFUTXwWCGUPVFdz6urSlRt+LAqrNeHIG3/YQkGEWWaJnSYk0jubHiFLUSqlb2fT/z
         yknvs+RQf0FMz33b/lDz2EBk8uj8SHVQWyYEXBJyQz12XPXK3oomeZ9rK62ygjJcFHsx
         WRBw==
Received: by 10.182.17.99 with SMTP id n3mr7708985obd.8.1342797969533; Fri, 20
 Jul 2012 08:26:09 -0700 (PDT)
Received: by 10.182.212.67 with HTTP; Fri, 20 Jul 2012 08:26:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201772>

Hi,

How can I push a working branch to github inside it?

E.g:

# On master:
$ git checkout -b feature-work

# On feature-work
# vi, hack, commit, ready to push
$ git push origin master # here I expected it would working pushing my
commits to a feature-work branch in github. Or if I omit master it
gives me a [rejected] error.
Everything up-to-date.

$ git checkout master
$ git push origin feature-work # Now the branch is pushed.

Thanks,
