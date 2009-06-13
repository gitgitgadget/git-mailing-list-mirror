From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: running git as root
Date: Sat, 13 Jun 2009 19:49:07 +0200
Message-ID: <81b0412b0906131049v60cfbc9bm3fd26cc25acc2cd4@mail.gmail.com>
References: <3a3d9e520906130825k25815c9atafde301d9fbc1da2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Nelissen <marcone@xs4all.nl>
X-From: git-owner@vger.kernel.org Sat Jun 13 19:49:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFXLz-0003j4-Aa
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 19:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbZFMRtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 13:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbZFMRtI
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 13:49:08 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:47218 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbZFMRtH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 13:49:07 -0400
Received: by bwz9 with SMTP id 9so2614803bwz.37
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NiFi66GmGavRmvq2C5paQ3TpqvMraIFVQxYswF6dVsw=;
        b=RCcICdq4ojb2Nyjq67PSLFXXT22TfReyecDhvgOYG1E9KYJT5umv2GS4rxr5j4liGQ
         JjDuaedF7JcGmUyyDuq+2dT7pQcj1hpgb+EeBjRPhskTs8L+TDjcVubWpdSbndzuig5m
         3ZMhASRGEN0sV7me4vXuQ/WokBqAWEzqJ1HT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SEdhhpcO3FZsEHiDsL41ZFhu1tsg0/SM7APK6ROjpMrnC1Un3M/0zbXJzf0gLq6JlO
         UXhrD6Y7vJZsMBN9i888QzUqK905ebs5d5KJnRWttODhWX573LarQ/RktUg2FL8Q9yD3
         nUz6yGFDnoGLyY/M5kYCTc+VihlHvdXEn0AAs=
Received: by 10.204.72.129 with SMTP id m1mr4971716bkj.61.1244915347595; Sat, 
	13 Jun 2009 10:49:07 -0700 (PDT)
In-Reply-To: <3a3d9e520906130825k25815c9atafde301d9fbc1da2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121512>

2009/6/13 Marco Nelissen <marcone@xs4all.nl>:
> When running as root, git fails a number of test cases that expect it
> to fail on read-only repositories (for example 't0004-unwritable.sh').
> I was thinking of either changing the code so that it checks
> permissions itself when opening files as root, or add a prerequisite
> to those test cases so that they are skipped when running as root.

There is such a prerequisite already (POSIXPERM), but what caused
you to run the _tests_ as root?

> What would be the preferred way?

Use the prerequisite would sound right when not the
strangeness of the idea.
