From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] diffcol.sh: Use /bin/bash explicitly
Date: Fri, 5 Sep 2008 22:35:46 +0100
Message-ID: <b0943d9e0809051435g23fa3b83u2a1e8f2a3a6b955f@mail.gmail.com>
References: <48BEB185.2080505@ruby.dti.ne.jp>
	 <20080903162123.GA874@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shinya Kuribayashi" <skuribay@ruby.dti.ne.jp>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 23:37:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbizB-00062s-VH
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 23:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbYIEVfs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 17:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbYIEVfs
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 17:35:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:24550 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbYIEVfr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008 17:35:47 -0400
Received: by rv-out-0506.google.com with SMTP id k40so611938rvb.1
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 14:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=o1waVZFoZgTU2WOi83dJmEHfbqudTtbA78aEQ5gZ/Dk=;
        b=job7K21Dl9eMbxwkTZBaaceeDm5WBKmGDY4ImNwK0AHnJyBTMwXVTwtqwbrhFJnIUe
         ZTd2yc2Yki6f85WIJNaXQ7TLIQCLePa8g+FfhbUQP9rUXQCnsnUDfbln7edtIeQQ1u5U
         cNu6mIhe8kOSZKOZu23A8KLq9SsaVnZ3vBnJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NtbpISploinxcEMcJxjmWGGrxzSqj5Mr3NDZVTkhOWR2M1m4lnUk9rHqy/AXFo4SzF
         vaMhq73UZvVv+/zyVPUD7R3T3eIYYS3qb56EA+vJ1jyFHrQqOZ/q3GoEtFwo9HQcMToU
         N4lKuvO7RRDMFdk05InqXnQqY7n38fjMFT8co=
Received: by 10.114.148.2 with SMTP id v2mr10521008wad.202.1220650546367;
        Fri, 05 Sep 2008 14:35:46 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Fri, 5 Sep 2008 14:35:46 -0700 (PDT)
In-Reply-To: <20080903162123.GA874@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95043>

2008/9/3 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-09-04 00:47:17 +0900, Shinya Kuribayashi wrote:
>
>> diffcol.sh is based on Quilt, and Quilt is dependent on bash;
>> Actually all Quilt scripts use /bin/bash without exceptions. Then
>> it's good for diffcol.sh to use /bin/bash.
>
> Thanks for this, and the other patch you sent. I'll be picking them u=
p
> this weekend, unless Catalin beats me to it.

BTW, I think at some point we could change to using Git's native
colouring. The diffcol.sh script is from the days when Git didn't have
this feature. We currently generate a diff string and pass it through
the pager but I'm not sure how to do this.

--=20
Catalin
