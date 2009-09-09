From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Add import -p option
Date: Wed, 9 Sep 2009 23:09:51 +0100
Message-ID: <b0943d9e0909091509i16b556f0x9dd3aa6788054298@mail.gmail.com>
References: <b0943d9e0909081443g47978cb7mee241d74dc52adf7@mail.gmail.com>
	 <20090908223714.GA6364@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 00:10:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlVMb-0000UZ-65
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 00:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbZIIWJu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2009 18:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752815AbZIIWJu
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 18:09:50 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:60321 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbZIIWJt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2009 18:09:49 -0400
Received: by bwz19 with SMTP id 19so771899bwz.37
        for <git@vger.kernel.org>; Wed, 09 Sep 2009 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rxNweuc7DcH2GzEfvqY7fisguot+O2LEJ7vpf7aELUk=;
        b=l+ZPug0JbGPCC3RhkDGrBTjIjOKaKaW4Ychd6bMqe2gvu3ZX672j7uDq/1PTYbjGeg
         BzNCUFBjiBHK/PJJZKSU5ewAU4GFtK8jL+8+UPs6Bru33GKoWk75CpCnxja49OI+er7N
         0Qs/CFVatBmbrMPyZPeil6/z9sM8vLeQxQ+vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wExyd2qTsyv6vTvVyeLQrOCG/7wWTVBLp/OjseoreqR7cZKFqWoqYKwXNFt89+dBQO
         4MrWtc8frXEotG1vJBe/GbA5CK3Xk9RO6aYUrBK8+fJ4lVxvDcFuoX79QZ2qLAFtjG88
         /y/GzPKF/tdamLrLTSjQLw3ylMNWkrdgx8VNw=
Received: by 10.223.92.153 with SMTP id r25mr743666fam.99.1252534191618; Wed, 
	09 Sep 2009 15:09:51 -0700 (PDT)
In-Reply-To: <20090908223714.GA6364@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128087>

2009/9/8 Karl Wiberg <kha@treskal.com>:
> On 2009-09-08 22:43:39 +0100, Catalin Marinas wrote:
>
>> This patch renames some of the existing import options and adds the
>> -p (--strip) option which allows stripping the leading slashes of
>> the diff paths.
>
> Looks good (and the intent is very good). The import test should
> probably be augmented with a test case for -pN, though.

Yes. I'll try to add one. As you noticed, not all options are tested.

>> + =A0 =A0if strip:
>> + =A0 =A0 =A0 =A0cmd +=3D ['-p', strip]
>
> This test should probably be "if strip !=3D None". It doesn't _really=
_
> matter, technically, since -p0 is the default, but still ...

I modified it after posting the patch. The git default is -p1, so we
would miss the -p0 case.

--=20
Catalin
