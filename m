From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Convert isatty() calls to git_isatty()
Date: Fri, 3 Feb 2012 16:59:59 +0700
Message-ID: <CACsJy8CHwSyWqMOB9LKxK2fqa0gP7TamnesMTR-D2Tny57C=Vg@mail.gmail.com>
References: <1328258101-10636-1-git-send-email-pclouds@gmail.com> <4F2BAD8B.1080403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 03 11:00:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtFwc-0001Oj-BW
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 11:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393Ab2BCKAc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 05:00:32 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37102 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab2BCKAa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 05:00:30 -0500
Received: by bkcjm19 with SMTP id jm19so2913425bkc.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 02:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Vq4V2ijTJ03xbUWODGGfIucewpE29Q2CWmlp7adwn3E=;
        b=gwqI1nuQ3pd0UGCY0aSp0boE84j7Cd8NWvyijqYKXcDyt3KGRAPJivJ4bvgjWdDYrn
         OAn/CbZ7YlkB0YL4QP97DjQdEeVQiuPqOxoU0+/xoo8i84IkCWuxp2/z+pPnUOgsvCol
         Lir+pMTm/8n2Ub8ZmSnUIBUxHGdcHd0cYXNIs=
Received: by 10.204.129.71 with SMTP id n7mr3006860bks.91.1328263229154; Fri,
 03 Feb 2012 02:00:29 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Fri, 3 Feb 2012 01:59:59 -0800 (PST)
In-Reply-To: <4F2BAD8B.1080403@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189746>

2012/2/3 Johannes Sixt <j.sixt@viscovery.net>:
> Am 2/3/2012 9:35, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
>> isatty() is used to check for interactive use cases. However if page=
r is
>> set up, standard file handles may be redirected and istty() calls la=
ter
>> on no longer reflect the original state.
>
> So what? What's wrong with this behavior?
>
> You converted many cases involving progress indicators. Wouldn't the =
new
> code pipe progress output to the pager where earlier it was not shown=
 if a
> pager was present? That is plainly wrong: Progress output is destined=
 only
> for the terminal, not for the pager.

Yeah right. My mistake.
--=20
Duy
