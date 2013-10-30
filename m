From: Karl Wiberg <kha@treskal.com>
Subject: Show patch in gitk --first-parent ?
Date: Wed, 30 Oct 2013 13:39:08 +0100
Message-ID: <CAFAOj7p49pQo=hXZT3TmMFF+KThKY-PZ2cgsZasH=e8rgjri1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 30 14:10:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbVXL-0008Q2-81
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 14:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab3J3NKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 09:10:07 -0400
Received: from mail1b.space2u.com ([194.218.23.146]:52522 "EHLO
	mail1.space2u.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754195Ab3J3NKF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 09:10:05 -0400
X-Greylist: delayed 1849 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2013 09:10:04 EDT
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com [74.125.82.170])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.5/8.14.4) with ESMTP id r9UCd8ku023946
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 30 Oct 2013 13:39:09 +0100
Received: by mail-we0-f170.google.com with SMTP id u57so1221772wes.29
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 05:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=JqGWH3E72KTa0zcTKct7e3zy5zwmJMXRG/jny35tcjo=;
        b=LGrGoEOV9uxog1+uCVyAz2O9Z/qYYlW0JznZB2qsO6e4uSmSmZGthmqj77E0eS0ct6
         7wJ2tMeFxVMsmj7kNldFeu3aLAS7NfDm/QcdaFgG72kGCEnudzVwlCgz1XQ8fG9wo9sp
         ghyu7T1uIlN+QfJsSBsva6cbPB0CNM+3TOwxvG8aFREZ9VcllwCWFqVe3m3XUhDW9reP
         6tUy03+KwIKR4UqV3PS/xAxuGa+qvY3knLnU4QTF0AeDy24TMBk36pMi7/p0PrDePvN9
         r7RwwdAuZ4I2/Vcl9dveOH5MPq64e9ikWlUf8yHSwyafhnwfeV2NcNMjeaHBuuQGxi7R
         NL5w==
X-Received: by 10.194.202.230 with SMTP id kl6mr4461207wjc.9.1383136748673;
 Wed, 30 Oct 2013 05:39:08 -0700 (PDT)
Received: by 10.216.207.141 with HTTP; Wed, 30 Oct 2013 05:39:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237017>

Hi all,

With "gitk --first-parent", I get a graph that only follows the first
parent of every merge---perfect if you always merge topic branches
into the main branch. However, the diff shown is still the normal
merge diff, and not the diff between the new tree and the first
parent's tree---is it possible to make it do that instead?

(With "git log --first-parent -p -m", I get precisely the diffs I
want, but everything is fully expanded so it's hard to navigate.)

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
