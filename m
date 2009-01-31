From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: understanding index
Date: Sat, 31 Jan 2009 15:45:29 +0100
Message-ID: <81b0412b0901310645t4307f67vf546e9c1c8c07701@mail.gmail.com>
References: <20090131111011.GA29748@ultras>
	 <adf1fd3d0901310409y28dc493ak358749e0c29154cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s-dev@laposte.net>, git@vger.kernel.org
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sat Jan 31 15:47:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTH7Z-00082S-4R
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 15:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbZAaOpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jan 2009 09:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbZAaOpb
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 09:45:31 -0500
Received: from ik-out-1112.google.com ([66.249.90.178]:59545 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbZAaOpb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jan 2009 09:45:31 -0500
Received: by ik-out-1112.google.com with SMTP id c28so233780ika.5
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 06:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XgwPCUWgmnl1HfcbjCkckFkMcI+rlNGLXVXU9yx0NBE=;
        b=X9RyXpm5thJiy+KpalgNW8bQGg6wVMWxoo+FoQBDL/4pS48BqH4PIQdq76yJTKJcv2
         lZw68GrAlzO4deomY916ID6Q1dppLgp3soSHPqlU7p8hFqZvv6t0hlHC5VjrRrByIeRZ
         9b2V9wq3znnzcAUAaKuxi0cNOyvfqhgK5vRis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=t+Ujzc1radJK7DmmBUrjbB3dKshcsMXpU4cFBNLrYXDkswWuVu7wkJmQ8/E5KtGOKS
         S2aNmCa731KYBPMlB48oy0aKHBB8Ccp/a/Mp+IlNJKelxcfVeD2CTAc183mTVzxDC+Xe
         3xKW/g7nZIqK13EQc0q1U3b/XdFaf+nrHUYVA=
Received: by 10.210.29.17 with SMTP id c17mr439706ebc.44.1233413129622; Sat, 
	31 Jan 2009 06:45:29 -0800 (PST)
In-Reply-To: <adf1fd3d0901310409y28dc493ak358749e0c29154cc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107929>

2009/1/31 Santi B=C3=A9jar <santi@agolina.net>:
> 2009/1/31 Nicolas Sebrecht <nicolas.s-dev@laposte.net>:
>> I'm having some understanding trouble with git index. As I understan=
d,
>> 'git rm --cached' is not strictly the opposite of 'git add'. It's a
>> little embarrassing in this particular case : what if you want to
>> commit and did a wrong 'git add -u' command ?
>>
> So to not commit foo at all:
>
> git reset HEAD foo
>

Or look at git gui, which allows you to select the not-to-commit parts =
visually
