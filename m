From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 04/25] contrib: remove 'buildsystems'
Date: Fri, 09 May 2014 03:14:27 -0500
Message-ID: <536c8e63448c2_25d198d30c55@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-5-git-send-email-felipe.contreras@gmail.com>
 <CABPQNSYZ4eWS_9_omZGK5wCD7ap_siEkC10e4ayT8Jp9w1bOSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Erik Faye-Lund <kusmabite@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 10:14:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wifx5-00022A-LS
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 10:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbaEIIOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 04:14:37 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:43727 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbaEIIOb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 04:14:31 -0400
Received: by mail-yh0-f54.google.com with SMTP id i57so3398521yha.13
        for <git@vger.kernel.org>; Fri, 09 May 2014 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=25EGeSvfoWOokuFkt20UUjQXUlb8KAbKchU0t4BHBF0=;
        b=wkYsYKCzEYfUYXbgsizYm8iDLwMpaj9RcH1tTC0S2DpAUhTxsUf5Mmo/NFoEZRop6t
         xccqzdW1yc9s+VUn0/T4hWDYAqG7mUeHgjym9cMT2QhmxayqQUOjkzl36VP3ZUx0L1U5
         b5FZhAWTp2hasQj1F7B6N/hOLbJUrJgeQwThJjoo037OfvYUS8u1lkDGytmMLBt/jTGV
         Yw7wU0ZYM3NCzQM6MSEeBSUGwN2EW5okljCO52JoGaJEosW+05fu6E+/S9jh5SSVySzW
         3XmAljECVb7saz0FY/kgvFB8Tpwt4lPASyJqVpoLN+U9bIPsuFw23lTYfYZJH9y2ZIWX
         Uynw==
X-Received: by 10.236.19.99 with SMTP id m63mr12345896yhm.134.1399623270364;
        Fri, 09 May 2014 01:14:30 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d62sm5199431yhq.2.2014.05.09.01.14.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 01:14:29 -0700 (PDT)
In-Reply-To: <CABPQNSYZ4eWS_9_omZGK5wCD7ap_siEkC10e4ayT8Jp9w1bOSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248530>

Erik Faye-Lund wrote:
> On Fri, May 9, 2014 at 2:58 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > No activity since 2010, no documentation, no tests.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  contrib/buildsystems/Generators.pm        |  42 --
> >  contrib/buildsystems/Generators/QMake.pm  | 189 ---------
> >  contrib/buildsystems/Generators/Vcproj.pm | 626 ------------------------------
> >  contrib/buildsystems/engine.pl            | 359 -----------------
> >  contrib/buildsystems/generate             |  29 --
> >  contrib/buildsystems/parse.pl             | 228 -----------
> >  6 files changed, 1473 deletions(-)
> >  delete mode 100644 contrib/buildsystems/Generators.pm
> >  delete mode 100644 contrib/buildsystems/Generators/QMake.pm
> >  delete mode 100644 contrib/buildsystems/Generators/Vcproj.pm
> >  delete mode 100755 contrib/buildsystems/engine.pl
> >  delete mode 100755 contrib/buildsystems/generate
> >  delete mode 100755 contrib/buildsystems/parse.pl
> 
> Please don't. This script is useful to build with the MSVC IDE, which
> enables us to use their excellent debugger.

If you want this script to remain in contrib, please:

 a) Write at least a few tests
 b) Write some documentation
 c) Explain why it cannot live outside the git.git repository like other
    tools. [1][2][3]

Cheers.

[1] https://github.com/visionmedia/git-extras
[2] https://github.com/mislav/git-deploy
[3] https://github.com/git-ftp/git-ftp

-- 
Felipe Contreras
