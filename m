From: Computer Druid <computerdruid@gmail.com>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Tue, 1 Mar 2011 12:11:26 -0500
Message-ID: <AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
References: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
	<AANLkTinCjaGMe3TnheqORe7Y_qWYTAr3p6UEsK3u4VyE@mail.gmail.com>
	<AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
	<AANLkTimw+TLYv3ANf_Gx6G3SaLwRnRf6PF1YUv86rC5J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Chad Joan <chadjoan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 18:11:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuT6o-0001kJ-53
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 18:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916Ab1CARLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 12:11:33 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63806 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab1CARLc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 12:11:32 -0500
Received: by eyx24 with SMTP id 24so1745575eyx.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 09:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=p4e5hWiGMO/qEPAFWhcU3p2KhtCioZF5O/zXf2DpOCE=;
        b=CKd00SbF5crrj7/sezUmAcicfxx6cpBFY00DS1RGvaSKZP5mIECsMLIi8N0sMuAdgs
         jR0Mv1szXWLae3kMhuUlA7xAQD5soJpF2SoO2MKa3Jyi3F5NxZT/5301JeuWF3udjTyN
         0Dql/2kQDC8SzyAa+CE3bRJz/gW27/XZ9I5rM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=uEx8reUv6mbNomhARSQd3Q4+pGJHWCtpAdyedmZgBe8sGCsjB2DbwMbY+cmHcx38tC
         vmQ/bOndjN9/2QEsbkrGVZc5sxwUD+KTvm/NbkM0iq+scuwf/azka7Bh9YhrzNm5upzt
         s0I2JnoJ2JM+cmc7csPclqoUjzEtyR/ZXTfMY=
Received: by 10.216.178.138 with SMTP id f10mr5919550wem.98.1298999487050;
 Tue, 01 Mar 2011 09:11:27 -0800 (PST)
Received: by 10.216.161.79 with HTTP; Tue, 1 Mar 2011 09:11:26 -0800 (PST)
In-Reply-To: <AANLkTimw+TLYv3ANf_Gx6G3SaLwRnRf6PF1YUv86rC5J@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168231>

On Tue, Mar 1, 2011 at 10:51 AM, Chad Joan <chadjoan@gmail.com> wrote:
> More info:
>
> $ mkdir foo
> $ mkdir foo/bar
> $ echo "test" > foo/bar/baz.txt
> $ echo "somestuff" > foo/bar/somefile.txt
What happens if you "rmdir foo/bar" here? (while there are files still in it)

-Dan Johnson
