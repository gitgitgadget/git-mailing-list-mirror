From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Worktree vs. working copy
Date: Tue, 20 Sep 2011 16:26:08 +0530
Message-ID: <CALkWK0mHQZEPKk3Dy3RSp70thcsw3x6RSvUxTuPVzzRjgsM8-A@mail.gmail.com>
References: <1316505022.13996.12.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Sep 20 12:56:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5y0B-0003cE-KN
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 12:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696Ab1ITK4b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 06:56:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61796 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab1ITK4a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 06:56:30 -0400
Received: by wyg34 with SMTP id 34so369326wyg.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 03:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GYdJfJFgYvIUz+PQnK5A5OuAuhEEYHImHIx8hjlopJg=;
        b=VKpAt3OvhpklXwHTBWXRz2M+uLgZ7y+QJKH7iXYdBjfoZqf38ZFz2BGH2P0bYIaBQF
         YInPJUsxHFZnTBbqZtLSsKM/wwav4d43gxW8M45F9nNZ8YkCdzjD0crqXoeQlNcbsdqI
         Q7/47fSQ/cED7Ym7se9digVdyGfWpPcOmKQSM=
Received: by 10.216.80.69 with SMTP id j47mr675178wee.102.1316516189108; Tue,
 20 Sep 2011 03:56:29 -0700 (PDT)
Received: by 10.216.51.207 with HTTP; Tue, 20 Sep 2011 03:56:08 -0700 (PDT)
In-Reply-To: <1316505022.13996.12.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181754>

Hi Carlos,

Carlos Mart=C3=ADn Nieto writes:
> [...]
> =C2=A0 =C2=A0$ git grep 'worktree' | wc -l
> =C2=A0 =C2=A0412
> =C2=A0 =C2=A0$ git grep 'working copy' | grep -v ^git-cvsserver | =C2=
=A0wc -l
> =C2=A0 =C2=A032
> [...]

You might like to refer to a related discussion [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/159287/focu=
s=3D160083

-- Ram
