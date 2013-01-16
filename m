From: Jay Vee <jvsrvcs@gmail.com>
Subject: Re: real git pull grief
Date: Tue, 15 Jan 2013 17:50:00 -0700
Message-ID: <CADq_mb-tjya_Vd-V9nXSckzjbz1m9g0QXX=Ma28-j0TsZD8jtw@mail.gmail.com>
References: <CADq_mb8LwzbjvaXGCR-6TZbTShf2nzw5wtNZ66_XmOM00-=xzQ@mail.gmail.com>
	<20130116002046.GF12524@google.com>
	<CADq_mb_OngJbkf_9_xp1D2RsjS_N23=R1Cpw-w5SxixB-zGWnQ@mail.gmail.com>
	<20130116004534.GG12524@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 01:50:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvHD0-0003g9-Ci
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 01:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251Ab3APAuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 19:50:03 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:44666 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107Ab3APAuB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 19:50:01 -0500
Received: by mail-qc0-f170.google.com with SMTP id d42so523312qca.29
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 16:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=8p0Ep1YDH+/yvoPlQHfck7kc6UkTtpnhG/KtxRgCJAI=;
        b=nFjAKnTVvqvNXKl+Sa8nmURaM6Ye3PB+jbXJyWF6PTZjvyZMaOfhhMU/UHELAVSsEH
         slFaAgZzxdUVpaySpXDJ2KwndX6vnokx4o302n7/t0jZ6bklSbNi2TgZxPFLN3Ugx9IK
         vgDMPcecQ6qroNAENIY9MrW6Rk/Awbp5Q+z7WTP6XAR5s3YS5mIJPL/98I2jj+7E4tO3
         O6UPUM6iUJ2UkRvBYVtBqsZaElhhst4KTPavPqI+qDFsY+q9xgi3zsJF4VQuYF01EBlV
         eOB5PmR/tQL5/2OuI0llJzUZCufp13NRA8+F6vgI0Vgd36EJh92cLYjx/a0mvNQc7K7h
         Z3Dg==
Received: by 10.229.105.152 with SMTP id t24mr19058270qco.131.1358297400663;
 Tue, 15 Jan 2013 16:50:00 -0800 (PST)
Received: by 10.229.75.194 with HTTP; Tue, 15 Jan 2013 16:50:00 -0800 (PST)
In-Reply-To: <20130116004534.GG12524@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213697>

git diff shows a list of files that I have made some changes to and
the diff for files that I have not changed.

The files I have made changes to (config files), I never want to
commit or push and sometimes I may want them overwritten.  for now I
simply want to leave them there (changes to .sql files that are
specific to my environment).

What I want to know is why git is reporting that changes will be
overwritten to files that I have not touched or changed.


>> $git diff spews a lot of information.
>
> Just a representative first 20 lines or so would be fine. :)
>
> Jonathan
