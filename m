From: "rocketscienc01100101 ." <rocketscienc01100101@gmail.com>
Subject: Bug in git-diff output
Date: Tue, 1 Apr 2014 12:49:00 +0200
Message-ID: <CALgQ2n-vPK6_0LnWA_AAD2GLvepjLN4A3UZFCAWzEp9r_=XOVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 12:49:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUwFg-0000Dk-Kf
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 12:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbaDAKtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 06:49:01 -0400
Received: from mail-ie0-f196.google.com ([209.85.223.196]:45775 "EHLO
	mail-ie0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaDAKtB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 06:49:01 -0400
Received: by mail-ie0-f196.google.com with SMTP id rd18so2531492iec.7
        for <git@vger.kernel.org>; Tue, 01 Apr 2014 03:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=sjI+VxqWIKofUIJ2ZnYNRWPp+Cg9/RR+dYAjx1ldyI4=;
        b=aut+84J3TP2lK8MLLGzELfgKT3B+xny/KMfSYDARpCpozmexjSsPnQ51RxJeXNWptL
         7/blyCfXxW1JET3425XvwfUzeKvlujis7gMcy41GoaeVHkni6IDVXafm8D6D9Sriv4wD
         k+TKUjW+u85SjQyA9hofLGKa11DYj5ORG+6bF/SPP0jJOAKHGWIV+gbkT4u0gLWNrm4N
         Fr5qoExZL4Jw212ynVecrdcey1U8NyxK7JZA1y7UKGSWDYV9VAg35NXMYu906GJMxlr6
         wOHyzyO7IHbLNWUtdtLW1ixezOLhw6+pg4te5rrV3VSZf6ioIsM55fmgRYgN9NtHr4VD
         rexA==
X-Received: by 10.42.15.142 with SMTP id l14mr22736700ica.64.1396349340575;
 Tue, 01 Apr 2014 03:49:00 -0700 (PDT)
Received: by 10.50.25.165 with HTTP; Tue, 1 Apr 2014 03:49:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245580>

I tried to get a diff between HEAD and the current version of my
project, so I did "git diff".

It's a web project with a CSS file that contains the following CSS rule:

a[href^=tel] {
    color:inherit;
    text-decoration:none;
}

Now, whenever I do "git diff", it will always show the a[href^=tel]
part and mess up the output, even when I didn't change anything near
that line. The problem is easily reproducable in a newly created
repository.

git --version
git version 1.9.1
