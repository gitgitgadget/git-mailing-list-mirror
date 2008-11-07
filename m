From: "Yaser Raja" <yrraja@gmail.com>
Subject: Re: Setting Up a GIT Repository Mirror
Date: Fri, 7 Nov 2008 12:17:58 +0500
Message-ID: <e97d51700811062317s351e165eh14d4343223a8e91f@mail.gmail.com>
References: <e97d51700811060706t40433bb9k7a3704429f244164@mail.gmail.com>
	 <e97d51700811060708y5deb9e9ek4a36c012726b3a63@mail.gmail.com>
	 <adf1fd3d0811060733t28008f0cld1a3b3c5bf4ff4d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Nov 07 08:19:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyLci-0000V6-TJ
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 08:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbYKGHSB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2008 02:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbYKGHSA
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 02:18:00 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:51614 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbYKGHSA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Nov 2008 02:18:00 -0500
Received: by yw-out-2324.google.com with SMTP id 9so428070ywe.1
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 23:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4nNMoSv/16INHZGqFieaE9uJZxc9DFX3gLQYhcDJE/0=;
        b=tHFCEx03SHUPcBsv/KSJqY+xnJCiKSgX0R9unPs/9oZXO3YyCpPcxvTm8r+l47tRyt
         UAagwTTc+aj76SClu9FWMJHTC6pTrk79y+4cJFdkU4VGJ+vJoIfh6P1lLrP2bT+9vOgR
         88zrBKkXCXDNDhzUZ0TGMYaafj/6+40SZg2Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XPp7morKf54aCO8O+yX7UpOSZ8Gp9WXU5tWVizL6yFIOTUqzOn9eQx5jCOIyFZl/ph
         pfq/OjGFX6I63+fQr3D5f4rX18ung7Yhf1tFgfs8UOwBHZjzQFBbiSCmhjE3f09QHGT7
         YKhO6u9u6/1KNJCGXzrG9sxOgpQMSehB+/PQo=
Received: by 10.150.150.3 with SMTP id x3mr2994460ybd.10.1226042278687;
        Thu, 06 Nov 2008 23:17:58 -0800 (PST)
Received: by 10.150.190.12 with HTTP; Thu, 6 Nov 2008 23:17:58 -0800 (PST)
In-Reply-To: <adf1fd3d0811060733t28008f0cld1a3b3c5bf4ff4d8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100291>

On Thu, Nov 6, 2008 at 8:33 PM, Santi B=E9jar <santi@agolina.net> wrote=
:
> On Thu, Nov 6, 2008 at 4:08 PM, Yaser Raja <yrraja@gmail.com> wrote:
>> Hi
> [...]
>
>> I came to know about --mirror option of git-clone and used it to mak=
e
>> a bare repository replica of the MainRep. Now i am not sure how to
>> keep it in sync with the MainRep.
>
> $ git fetch
>
> as it is bare you cannot merge, so you cannot pull.
>
> HTH,
> Santi
>

Here is what i get when i try to use git-fetch:

# git fetch
ssh: : Name or service not known
fatal: The remote end hung up unexpectedly

=46ollowing is the current content of my config file:

[core]
        repositoryformatversion =3D 0
        filemode =3D true
        bare =3D true
[remote "origin"]
        url =3D ssh://gituser@<addr removed>
        fetch =3D +refs/*:refs/*
        mirror =3D yes

I also tried git-fetch with the url as argument but that also gave the
same error. Do i need to do some additional configurations to make
fetch work?

Thanks
Yaser
