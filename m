From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Contributing to git: cleaner git -rm & add configuration options
Date: Tue, 21 May 2013 12:50:42 +0530
Message-ID: <CALkWK0kV_wTbbb15SwVgxW5CVufqJgAjBifT_MwnJXR1-J+3JQ@mail.gmail.com>
References: <fb43f66aed3826d04b75826e187e3e6c@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, garciagj@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: =?UTF-8?Q?Mathieu_Li=C3=A9nard=2D=2DMayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue May 21 09:21:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uegsy-0003hc-0G
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 09:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088Ab3EUHVX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 03:21:23 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:39731 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529Ab3EUHVW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 May 2013 03:21:22 -0400
Received: by mail-ia0-f169.google.com with SMTP id k38so402768iah.28
        for <git@vger.kernel.org>; Tue, 21 May 2013 00:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aMslODt4pBDPyjvgGZEW/E6qp72UNaghqsC5YDJXeZw=;
        b=QD6nE5LyYCAXYa4N1mzWBYb8nSQQHGw9PGkwAYJ3lu3E212DBVQFWQzN41KxbvRbOk
         DxH/Ea88u/nr0y53xjmf1Oez6FMgcJTN+wLjB6R3NeSOFWxuIUWBT2B92JRuMpnDjjEa
         aArnQsHFMIecp+kJt7HUHDVl+8s2DYDZ1yM2m6qOoGl6ylKQxDkuhKITS655X+hcPydR
         Jd+hdHTHGKMN1GK3XZN+7fYaPsS9zaJLfFLiQ3sS/d4uKbDiH3//YZxejsnyGUHj0Vak
         ZNAbJIfx8hi18v1Gb+XpauHCAWiA/cVSTQ7k/1V0917p/4elnt81jZgxw8lfTXFNyJ3f
         1qXQ==
X-Received: by 10.50.66.197 with SMTP id h5mr7300244igt.63.1369120882435; Tue,
 21 May 2013 00:21:22 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 21 May 2013 00:20:42 -0700 (PDT)
In-Reply-To: <fb43f66aed3826d04b75826e187e3e6c@ensibm.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225020>

[+CC: Matthieu Moy]

Mathieu Li=C3=A9nard--Mayor wrote:
> -Cleaner error message when "git rm" fails with multiple files

Should be fairly straightforward to implement.  Just collect the
errors and print them out at once.

> -Add configuration options for some commonly used command-line option=
s

I'd really like status.short, status.branch, am.scissors and am.3way.
Should be fairly straightforward to implement, although others might
have different opinions on the names of the configuration variables.

Also, I've taken the liberty to remove three ideas from the list:
jk/fetch-always-update-tracking, vv/help-unknown-ref, and
rr/rebase-autostash are already in `pu` and will hit `master` soon.
