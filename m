From: Lin Mac <mkl0301@gmail.com>
Subject: Re: How to move a big branches to a new base?
Date: Thu, 4 Mar 2010 17:34:12 +0800
Message-ID: <10d816431003040134j103c567if10aacf0fa10701f@mail.gmail.com>
References: <10d816431002251918vf13a5e8uf0396aa861081bcc@mail.gmail.com>
	 <43d8ce651003021954o1411efd2i1a1f26e9b8ed5d54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 10:40:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn7Xh-0004rQ-HL
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 10:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380Ab0CDJkY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Mar 2010 04:40:24 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:49435 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434Ab0CDJkX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 04:40:23 -0500
Received: by pzk32 with SMTP id 32so537436pzk.4
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 01:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uikZT5c8TXEGQ4+YzjkYCD/XCRLevMWZI2u54fDr4vI=;
        b=mYyluGmcZYIZMNyjUrs07ZUSgi/wZ8wcLEMIIjSWblkf0E4ydqFqgVwBnM0kMEiZtU
         ajbmvRrc7FxjgKN0Wk/jcToeHMX6Dul7WRlHtM+Tl1v60tctkNiI2zZ7ayIgTOvtZfBV
         yk68klUc2TRsiCcVqbyEXtY/On3l7w53tydKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=L/TV5G8vIkp2BM554JL1H2/aJb19vfWFoiqdCW0/fsATNE51HKZIFyX1HwfL6UWxDV
         TihH5bT+t37RgpdhPF+GCAmn7LBGv3NkRwGTcPqqKd+b8iaLIWTJacY6Jl4wD/pu26D5
         DSe2VRQYsD7lEk0VTQB6W59V+rvySxfzXkovk=
Received: by 10.142.202.5 with SMTP id z5mr2055406wff.274.1267695252481; Thu, 
	04 Mar 2010 01:34:12 -0800 (PST)
In-Reply-To: <43d8ce651003021954o1411efd2i1a1f26e9b8ed5d54@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141517>

2010/3/3 John Tapsell <johnflux@gmail.com>:
> I tend to keep my branches as small as possible - a few commits at
> most. =A0And avoid merges like the plague. =A0This seems to work pret=
ty
> well.
> Remember you can squash your commits together to keep the branches
> clean and well-ordered.
squash is a powerful tools, but doens't help much in this situation.

In other word, one have to prevent a branch to becoming a tree.
Does it worth to have a new tool for such situation?

Best Regard,
Mac Lin
