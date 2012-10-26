From: Steven Penny <svnpenn@gmail.com>
Subject: git rebase -i and final newline
Date: Thu, 25 Oct 2012 21:09:20 -0500
Message-ID: <CAAXzdLUvDkdPJqF+xgnZ51LQ-vfB1Jea5Pf9PvRS+qHx1+RZuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 04:09:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRZMb-0000wL-LJ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 04:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab2JZCJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 22:09:21 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42223 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab2JZCJU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 22:09:20 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3155314iea.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 19:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=wKs+OrEO/ulOXGCKXpBxIjZzWvZyzMzZlfaEr+eoX7I=;
        b=anCoEhStobnF1g7pO5phvEzhEqR1NibY1YvAqXfld3Fc8txsE6/gSVVoYxhWupS2k5
         chQM7OmxdtdeJu/brmMwxJB1OBpsbHzx+5PCj6SdL8hr73kaBbZxKfQ2jIUyEpoTT+gS
         cCzSgjrucILbHjozlECmVGNxySnZE693ODhNWpYkO7pGGYLkNkDVCWC8fYoi3DIZRHCc
         /UN6RaIQlT6Oo981wbmoaUJzxJkU5b+90kAXev1d79gizxLKIgquOF0qeMFe83wsgYM4
         rPxhY74Y7cavcW8UzFL3EH+R0Rdc7oXOsNfOfng72E2wp2qbMVzjDYj699iDxdilwyuW
         jsEw==
Received: by 10.50.56.139 with SMTP id a11mr661882igq.3.1351217360520; Thu, 25
 Oct 2012 19:09:20 -0700 (PDT)
Received: by 10.231.241.7 with HTTP; Thu, 25 Oct 2012 19:09:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208429>

Sorry if I am drumming up and old issue here. I have noticed that with
"git rebase -i", if your final line contains a commit and no newline, git
interprets that as "remove this commit please".

I feel that a commit should be removed only if the entire line is removed, that
is the commit hash and title as well as the newline.

I have noticed that the behavior is "correct" with "git commit". Even if you
omit the final newline after the commit message body, all text lines will be
included.
