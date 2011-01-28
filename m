From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: [PATCH] git-p4: Corrected typo.
Date: Fri, 28 Jan 2011 16:19:33 +0100
Message-ID: <AANLkTikeB724f_vE6qvu1h1o5JG150mcmaHVBjLkOEWP@mail.gmail.com>
References: <1290130693-30855-2-git-send-email-vitor.hda@gmail.com>
	<1290648419-6107-1-git-send-email-vitor.hda@gmail.com>
	<AANLkTimQhFzEXr=T9F8TJzTeWwKroTt_BG87RtQCLivv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 16:20:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Piq7g-0000i4-QC
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 16:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab1A1PTf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 10:19:35 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45016 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab1A1PTf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 10:19:35 -0500
Received: by qyk12 with SMTP id 12so3714149qyk.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 07:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NwpFr0rS77i6MVWJTpcYTc8PgmXowwcfXFEFoOR9fO4=;
        b=Ri2UllYCNneYzwf3WwBfMp2QTdn5X805MYpO5Sg5gf7i7QkQgGnX9uE0K5f9ICibx5
         Pq8PgCNo/ukDWmAMuRdv+mfeSOeopn8dvHzGJyVF3DsSxZrfGm1wXWLG4HqMdJ578i/n
         JhIusaYjwMn8Eba3CChEIfg9z6Idfoy/RW+/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SL8xi/2B10fkwmnX1qO2pQsZf8PyQr0GSlMYFqPT6U/T0k4l05JMZJ9MmkfE9Kn6bU
         eKtHWmmknWPCPL0eC4NgfGllL3i5g/IB82D2C4NGnW/2aDUo1QVQJvhnsAwwY0ClTXYo
         Z24Stu2aFFrwD37+c5hc1ZZNvxtotpeVtlgr8=
Received: by 10.229.88.82 with SMTP id z18mr1030634qcl.221.1296227973944; Fri,
 28 Jan 2011 07:19:33 -0800 (PST)
Received: by 10.229.223.131 with HTTP; Fri, 28 Jan 2011 07:19:33 -0800 (PST)
In-Reply-To: <AANLkTimQhFzEXr=T9F8TJzTeWwKroTt_BG87RtQCLivv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165620>

Hi,

On Fri, Jan 28, 2011 at 12:35 AM, Vitor Antunes <vitor.hda@gmail.com> w=
rote:
> Hi everyone,
>
> Could anyone comment the 3 patches I sent (being this the last one)?
>
[...]
> On Thu, Nov 25, 2010 at 1:26 AM, Vitor Antunes <vitor.hda@gmail.com> =
wrote:
>> ---
>> =A0contrib/fast-import/git-p4 | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
>> index 0ea3a44..a466847 100755
>> --- a/contrib/fast-import/git-p4
>> +++ b/contrib/fast-import/git-p4
>> @@ -618,7 +618,7 @@ class P4Submit(Command):
>> =A0 =A0 =A0 =A0 if len(detectRenames) > 0:
>> =A0 =A0 =A0 =A0 =A0 =A0 diffOpts =3D "-M%s" % detectRenames
>> =A0 =A0 =A0 =A0 else:
>> - =A0 =A0 =A0 =A0 =A0 =A0diffOpts =3D ("", "-M")[self.detectRenames]
>> + =A0 =A0 =A0 =A0 =A0 =A0diffOpts =3D ("", "-M")[self.detectRename]
>>

This appears to me to be a bugfix for one of the other patches you
sent, is that right?

If so, maybe you could squash it with the previous patch and re-send
it all to the list?

My other comments for now are:
- you have forgotten to sign off on the patches
- commit messages are normally in imperative rather than past tense
(see Documentation/SubmittingPatches in git)

- In your first patch you wrote:
> The detectRenames option should be set to the desired threshold value=
=2E
I'm not sure what threshold value you refer to here, and what values
you can set it to. Am I missing something?
(I'm not very familiar with git rename detection options)

I'm a git-p4 user, so I can test your changes and look a bit more at
your code. Someone verifying it could help getting the patches
applied.

Thanks for improving git-p4!

Cheers,
Thomas Berg
