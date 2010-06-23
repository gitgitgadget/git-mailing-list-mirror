From: Laszlo Papp <djszapi@archlinux.us>
Subject: Re: Uncommitted source and header files disappeared after a git mv 
	operation
Date: Wed, 23 Jun 2010 12:34:07 +0200
Message-ID: <AANLkTinernf5BMowVb-iJZi0c9d6SlsGSoy2L3p4H-3E@mail.gmail.com>
References: <AANLkTikeW1-Kzdyu1APSqzKGsNnny6InueWluXsKMccU@mail.gmail.com>
	<AANLkTiloMDccUDObmPXPGWI_HYVDMk57EoHxZjFUiSvi@mail.gmail.com>
	<AANLkTilNI0lq0rUqvUIdNRpubNUNqKf3_5nX3TGauvQv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Jun 23 12:34:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORNHd-0002Xk-ER
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 12:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab0FWKeM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jun 2010 06:34:12 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:48320 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab0FWKeL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jun 2010 06:34:11 -0400
Received: by wwc33 with SMTP id 33so861753wwc.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 03:34:07 -0700 (PDT)
Received: by 10.216.158.147 with SMTP id q19mr5735662wek.11.1277289247419; 
	Wed, 23 Jun 2010 03:34:07 -0700 (PDT)
Received: by 10.216.163.6 with HTTP; Wed, 23 Jun 2010 03:34:07 -0700 (PDT)
In-Reply-To: <AANLkTilNI0lq0rUqvUIdNRpubNUNqKf3_5nX3TGauvQv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149504>

On Wed, Jun 23, 2010 at 12:31 PM, Santi B=E9jar <santi@agolina.net> wro=
te:
> On Wed, Jun 23, 2010 at 12:24 PM, Laszlo Papp <djszapi@archlinux.us> =
wrote:
>> Hello,
>>
>> I have got a very big trouble, so please help me if you can :(
>>
>> I have done a git mv operation for a whole directory, so I have put =
it
>> into another subfolder and all my uncommitted/unpushed source and
>> header files were lost ... How can I regain them ?
>>
>> So I did "git mv some-directory-containing-lots-of-uncommitted-chang=
es
>> total_different_folder/some-new-name". If I remember well then I did
>> commit/push for that git mv operation.
>>
>> git status doesn't show my changes either.
>
> I can't reproduce it. Can you provide a test case so we can reproduce
> it. Additionally you should tell us more information, like git
> version, architecture.
>
> Santi
>

http://www.archlinux.org/packages/extra/i686/git/

So the version is 1.7.1 and the architecture is i686.

I have tried the following commands:
git log -1
git log -1 --stat
git reflog

Only this commit happened and I can't find the files in the new directo=
ry.

Best Regards,
Laszlo Papp
