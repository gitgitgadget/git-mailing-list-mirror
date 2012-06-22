From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Master and origin/master diverged
Date: Fri, 22 Jun 2012 10:53:29 -0700
Message-ID: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 19:53:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si83P-00029Y-Hj
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 19:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077Ab2FVRxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 13:53:51 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:38731 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866Ab2FVRxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 13:53:50 -0400
Received: by gglu4 with SMTP id u4so1763419ggl.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 10:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=7bB1PS4UL3b65W3ONmIObkXCalh3jlVMpc149D/Gq9g=;
        b=T8d/4tjqaWW7ZgV536GgjzgBTZKdsM9ohRWr9SYOPE7SyxersOYZOko9YalPa+M+/R
         UN3UsA2fLubLBykuNhcCvIZ+vuQlH8RiYkGmr1I+g4ehyytZQBvpr/Vn3O2/aAj+SY+u
         rnOrjZub321dDRpSP+D+0WxIkfcKkOSPam76nU6Saz55XilRFEOhC5qANb9wjSKXxq4W
         Y3R1jaQAsjt4BNy1SJzdLJS01uF3H+ZPyJfLXnomGFG3Hgp0bmHy62hZ5xZZ8hmk1jYZ
         JwEMXx5wQtUtUs17U7thFIJFdqTFhNWJ4kqvCsMKuAn0YRM7QEHpeySDScimE88+6ir9
         mYuA==
Received: by 10.101.134.6 with SMTP id l6mr1064721ann.21.1340387630238; Fri,
 22 Jun 2012 10:53:50 -0700 (PDT)
Received: by 10.236.29.230 with HTTP; Fri, 22 Jun 2012 10:53:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200451>

Hi all,

One of my developers managed to push something that somehow "diverged"
origin/master from everyone else's local master.

A --> B --> C --> D (everybody's local master)
|
\--> B' --> C' --> D' --> E (origin/master)

(i.e., A is the commit where things diverged; everyone's local master
points to D but the new commit (E) that was pushed to origin/master
uses different SHA1s for B, C, and D). I hope I explained it clearly
enough.

Now running git pull creates a merge commit joining D and E.

When I asked the developer what he had done he told me everything had
looked normal. No Git warnings, nothing strange in gitk (i.e. normal
linear history). So I do not understand what went wrong.

Does anyone have any idea as to what might have happened? Perhaps if I
understand how this happened I might be able to prevent it from
happening again.

Cheers,
Hilco
