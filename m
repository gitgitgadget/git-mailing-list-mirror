From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 06/25] contrib: remove 'diffall'
Date: Fri, 09 May 2014 10:20:34 -0500
Message-ID: <536cf242394eb_ce316372ec42@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-7-git-send-email-felipe.contreras@gmail.com>
 <CAFouetj=30Wd_CDiXA0UqqKNdfJSv+C5mWbMJPOkEdqxr7k54w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tim Henigan <tim.henigan@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 17:20:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WimbQ-0004CZ-H6
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 17:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836AbaEIPUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 11:20:43 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:37156 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818AbaEIPUm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 11:20:42 -0400
Received: by mail-yh0-f54.google.com with SMTP id i57so3900006yha.27
        for <git@vger.kernel.org>; Fri, 09 May 2014 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=iyAMOscAmq3eHFVXZ47NwbPjjyY3dPpA4dTG3etyDe0=;
        b=IVw7quoa+K261oJ8sREJcamGI5QOapnyLpC3M++B0TR0A1H5OWU3J8VRIEAlMih0Jv
         pbHvL9vqQEoTwPZWzlpPfHxg7/NTXm9JoEfSw5xS6jL2xGxzjftd1ec8CByPWgAbDU+z
         xzDS3ZjI2pnI7DAzaIzyiFClQzb6bRB+f4pnY5TCI2lwwTpOfHCW52dOMsmtFGg6bJkP
         K6vIcKLRyRMJDldt4HQYKiYfNP2Xj1CZVHwQ5ZzH6b2cdQycr+6buaIYzGs0Nh5GB+9p
         NjmVIlAiBHkp8wWxjar4IuexqPtNsx/C052ScpE6LHT2xuUJea4hOFvr6F5wJQabM1ok
         rsGA==
X-Received: by 10.236.230.41 with SMTP id i39mr15877089yhq.14.1399648841483;
        Fri, 09 May 2014 08:20:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id g1sm6554898yho.37.2014.05.09.08.20.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 08:20:37 -0700 (PDT)
In-Reply-To: <CAFouetj=30Wd_CDiXA0UqqKNdfJSv+C5mWbMJPOkEdqxr7k54w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248571>

Tim Henigan wrote:
> On Thu, May 8, 2014 at 5:58 PM, Felipe Contreras <felipe.contreras@gmail.com
> > wrote:
> 
> > No activity since 2010, no tests.
> >
> > Cc: Tim Henigan <tim.henigan@gmail.com>
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  contrib/diffall/README      |  31 ------
> >  contrib/diffall/git-diffall | 257
> > --------------------------------------------
> >  2 files changed, 288 deletions(-)
> >  delete mode 100644 contrib/diffall/README
> >  delete mode 100755 contrib/diffall/git-diffall
> >
> 
> 
> I see no problem with removing this script from contrib.  However, the
> commit message should mention that git-difftool learned all the
> features of git-diffall when the '--dir-diff' option was added in
> v1.7.11 (ca. June 2012).

Will do.

> Also, the script was first added to contrib in Feb. 2012, so "no
> activity since 2010" is incorrect.

Ah, sorry about that.

-- 
Felipe Contreras
