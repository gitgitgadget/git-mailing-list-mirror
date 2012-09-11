From: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@entel.upc.edu>
Subject: Re: Git an case-insensitive Mac OS X filesystem
Date: Tue, 11 Sep 2012 10:30:28 +0100
Message-ID: <CAPLaKK4Xm8KzQ8HcM_TbbuDr1hcLjhjSOWSyJS3jFX0toFBjsA@mail.gmail.com>
References: <CAPLaKK71O3RzavOqY2uVC1tUsbs+W6WxJRWuLBDFUvTwojAN-g@mail.gmail.com>
	<1347355466-ner-6656@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 11:30:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBMnn-0007Oc-VJ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 11:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467Ab2IKJab convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Sep 2012 05:30:31 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:40757 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756479Ab2IKJaa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 05:30:30 -0400
Received: by lagy9 with SMTP id y9so171120lag.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 02:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Phw3X9+U9b3uIwZEUhQ5cFDC4S9OnLzoehHYWFFMIBo=;
        b=h5S7oEHtf4lcctBihCRYBGuDoVXi5vF51qYREe5sKm6U1rsnWIMqXyTm6CRYg2Xg85
         D68mhNg0iGzyjDHtsSX46LEz6Os391XlPPI8tjgMuIaoJWcJUOyLzz/gT984ynTKfVf5
         EPYZDbKYTMC2MX9JDrhBsW9qOWrZ12WohkvDXaTR2jeNYiIbBuCl+ZbNSofzDaAU8KlB
         cPdLd9EQB3WEryrOXX++m9xJ1tLXxcwG3u/5ZQwb1RLtQ7SFxtpi3lCZi3PwtKiiYulo
         cRyqoxXffyFuj4pKV//IgsF7ZvU3ws9qT12AyJlATe1sbLINQvP/Hx+ty/xyzDh3EC/u
         P+gg==
Received: by 10.152.135.147 with SMTP id ps19mr15295220lab.52.1347355828608;
 Tue, 11 Sep 2012 02:30:28 -0700 (PDT)
Received: by 10.114.0.20 with HTTP; Tue, 11 Sep 2012 02:30:28 -0700 (PDT)
In-Reply-To: <1347355466-ner-6656@calvin>
X-Google-Sender-Auth: dCbn_GCciw5x5BhCflFFu97_TYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205211>

On Tue, Sep 11, 2012 at 10:24 AM, Tomas Carnecky
<tomas.carnecky@gmail.com> wrote:
> On Tue, 11 Sep 2012 10:21:16 +0100, Roger Pau Monn=C3=A9 <roger.pau@e=
ntel.upc.edu> wrote:
>> Hello,
>>
>> I'm using git for all my projects, and I usually work under Mac OS X
>> with the default filesystem (that's case-insensitive, but
>> case-preserving). I'm currently working on a project that has severa=
l
>> branches, and two of them are called origin/DHCPCD and origin/dhcpcd
>> respectively, that's unfortunate, but I cannot do anything about it.
>> This completely breaks the git repository, because
>> .git/refs/remotes/origin/DHCPD and .git/refs/remotes/origin/dhcpd ar=
e
>> actually the same file, so when I try to update my repository
>> performing a git pull I get the following error:
>>
>> error: Ref refs/remotes/origin/dhcpcd is at
>> 6b371783de2def2d6e3ec2680ba731f7086067ee but expected
>> 79f701ce599a27043eed8343f76406014963278a
>>
>> So I was wondering if anyone has stumbled upon this issue, and what'=
s
>> the best approach to fix it.
>
> Make a disk image and format it with a case sensitive filesystem (use=
 the Disk
> Utility to do that). Do your work there.

Yes, I could also create a partition, or format my entire disk to
case-sensitive (although I heard it might break some OS X
applications), I guess adding a workaround for this in git itself is
not appealing (like storing the branch file using a slightly different
name?)
