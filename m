From: Brad Larson <bklarson@gmail.com>
Subject: Re: .git as file pointing to directory?
Date: Thu, 4 Nov 2010 16:07:00 -0500
Message-ID: <AANLkTinMiSNCC0EUDRvxiW0V+upjEemP_xYwjcWcNC6L@mail.gmail.com>
References: <AANLkTikB4p9=EQRsAJTe4-nAw5udz2pfcRd4WPsfms86@mail.gmail.com> <20101104184321.GA16929@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 22:07:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE71t-0007QA-SL
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 22:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135Ab0KDVHZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 17:07:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43781 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117Ab0KDVHY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 17:07:24 -0400
Received: by bwz11 with SMTP id 11so2080815bwz.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0OPhQahLJAge3qXhsmN0COgAfEtPwqghRfJlcz6a7ak=;
        b=meG68XWonUpsTmLjSRgcMF2pJT26xLE8eIaE66957FWh1+kYI+D6wz5jUbMCrwSqN4
         oEkM7qYhrfxJpRtvu5ueuWBpZFmkwOjU265vYrTY5/j81jx19Vf4PZM9TZfJzEp4PKxB
         psOVs3td5O1z4qvbT609dMdJBfbHAGlJK2bg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Pz7CQk6qs6glbgg4ZKQpyPupwDrfOEWSy3Kpk5okncpSjQMjCWtGUKThRUxdQQ/T5P
         LSsRd1T7UYlt/4hJ2FpDj3WWhIIEArIouZdJueM+zqyWLjSqjNsxq5TgYu54+XjKzQg2
         UEXp8RlNv3auQ7iuhu4skM18QHk/u4DybmJKo=
Received: by 10.204.53.142 with SMTP id m14mr1101800bkg.147.1288904841147;
 Thu, 04 Nov 2010 14:07:21 -0700 (PDT)
Received: by 10.204.75.72 with HTTP; Thu, 4 Nov 2010 14:07:00 -0700 (PDT)
In-Reply-To: <20101104184321.GA16929@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160768>

On Thu, Nov 4, 2010 at 1:43 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Hi Brad,
>
> Brad Larson wrote:
>
>> At gittogether there was some talk about having .git be a file, not =
a
>> folder, with contents pointing to the real .git directory. =A0Simila=
r to
>> a symlink, but supported in Windows.
>
> It is called a .git file. =A0See gitrepository-layout(5), v1.5.6-rc0~=
93^2~3
> (Add platform-independent .git "symlink", 2008-02-20), and the recent
> rebase not handling core.worktree thread[1].

Thanks so much Jonathan.  We were just listing the location of the
folder, but prepending it with "gitdir: " fixed things.

Thanks!
Brad

>
> Hope that helps,
> Jonathan
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/160488/foc=
us=3D160567
>
