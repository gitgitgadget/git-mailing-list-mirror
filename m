From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] gitignore(5): explain how to stop tracking a file
Date: Thu, 11 Nov 2010 06:40:14 +0530
Message-ID: <AANLkTikpSoMGKDzUWXK-XGNZ8cp9Ltz+n8hNd9Z6FQ2E@mail.gmail.com>
References: <1289387440-8509-1-git-send-email-sitaram@atc.tcs.com>
	<20101110185555.GA12365@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sitaram Chamarty <sitaram@atc.tcs.com>, gitster@pobox.com,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 02:10:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGLgG-0007Qk-JP
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 02:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076Ab0KKBKR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Nov 2010 20:10:17 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55342 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719Ab0KKBKQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 20:10:16 -0500
Received: by eye27 with SMTP id 27so861927eye.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 17:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FdJLZXYEwG5Sn4Ggc4lI2jKdy4LTzwDkBS05QFPR+N0=;
        b=OkLxnGooAteAYvnkxu+GvDwoamf2TzXZgRb7By0LB+kVLpIpcOxAXDEMDFGQemBhgm
         v5GxDjd6goVFtthvt5cJWW1jtZwAkvrh6KxkO/2i/nCkQ7lvMiS6yZDlOoxm9aJgbCIP
         xVXTPS3lCGlcyXSNuRhl9TAldgvZLBXNo/9BI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RvNI01KQ1iZJObx7qFK4gWezc/Y1Dpcw/vq4C83PY2Gc1xqW8GCDkMFQdM2dO9/4V/
         FWisTiC1RtpHPVhiUPq+keBX2WX7Wba5pm74xuxy6RY28rn+mw1WxcPCigVAY+OqQxFO
         6qQsnv/bqmlu/IneB26RHK8BgUcGTFVsSqUh0=
Received: by 10.213.30.20 with SMTP id s20mr306399ebc.16.1289437814306; Wed,
 10 Nov 2010 17:10:14 -0800 (PST)
Received: by 10.213.35.68 with HTTP; Wed, 10 Nov 2010 17:10:14 -0800 (PST)
In-Reply-To: <20101110185555.GA12365@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161199>

On Thu, Nov 11, 2010 at 12:25 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Sitaram Chamarty wrote:
>
>> --- a/Documentation/gitignore.txt
>> +++ b/Documentation/gitignore.txt
>> @@ -18,7 +18,8 @@ Note that all the `gitignore` files really concern=
 only files
>> =C2=A0that are not already tracked by git;
>> =C2=A0in order to ignore uncommitted changes in already tracked file=
s,
>> =C2=A0please refer to the 'git update-index --assume-unchanged'
>> -documentation.
>> +documentation. =C2=A0To stop tracking a file that is currently trac=
ked,
>> +use 'git rm --cached'.
>
> Ack. =C2=A0But I fear this makes the gitignore page feel even more to=
p-heavy
> than it already is.

Oh... I hadn't thought of that.  I was looking at "what's the minimum
change needed to at least mention 'git rm --cached' somewhere".
You're right though, and I think your approach is good.

> The current structure is:

[snip]

> It's a wonder people can find anything there. :) =C2=A0So how about t=
his?
>
> Patch 1 splits the description into three sections. =C2=A0Yes, having=
 the
> PATTERN FORMAT section is not part of the conventional list in
> man-pages(7), but I think it's easier to find the interesting part
> this way.
>
> Patch 2 puts the comments about related commands in a separate NOTES
> section.
>
> This way, one could expand on the "stop tracking file" procedure
> without interrupting the flow of the basic description of what
> excludes files do, by adding to the NOTES or EXAMPLES section.

++ from me on this approach.

regards

sitaram
