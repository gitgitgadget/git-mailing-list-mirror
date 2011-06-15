From: Aaron Gray <aaronngray.lists@gmail.com>
Subject: Re: no autocrlf on Visual Studio subdirectory
Date: Wed, 15 Jun 2011 16:27:40 +0100
Message-ID: <BANLkTin99+GYd_CViNRo3tg8AA5sUOi6og@mail.gmail.com>
References: <BANLkTikbnKNHxt5wKDjUWYby+p3w0cHcgg@mail.gmail.com> <5843516.7553.1308147368895.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 17:28:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWs0l-0005LS-VP
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 17:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528Ab1FOP2D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2011 11:28:03 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49923 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796Ab1FOP2B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 11:28:01 -0400
Received: by eyx24 with SMTP id 24so206105eyx.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=DQ5xwykv8S8ha8sd8gTd4gA/o/glTYiG/kiQYh1voRg=;
        b=lT0E0knIusCy2Tw0Y6TPedWLWj2Qr2PNMuZkIbcOtb0annvDFyTp/aF96pndpKIXnE
         FFuMWgg2MSsLZyOidcdiS+c/JJFgMtzskniYpEu0Jbaand0tLp+RKtTeHTQUHOp+pibM
         oDMZ49HVNWnkvm6JRZtggXzJPYGZichYHE0Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=APCyEtzj+IJEyou/r2WxM4Y3IBGvMSGQOXSONVLLexB+OGA4+ORQAj0Z94sGq3NiaZ
         sZPMrtgkROcaLLnbKRnwSNXvHgErTOArMu+mYYkbUkwGnLwXZ/C5qbnilDcyW2bPYJUb
         Fr3wfsPC4REKmXe00lqQ4kRKUNdl4om5ErL28=
Received: by 10.14.15.78 with SMTP id e54mr359246eee.80.1308151680264; Wed, 15
 Jun 2011 08:28:00 -0700 (PDT)
Received: by 10.14.127.70 with HTTP; Wed, 15 Jun 2011 08:27:40 -0700 (PDT)
In-Reply-To: <5843516.7553.1308147368895.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175837>

On 15 June 2011 15:16, Stephen Bash <bash@genarts.com> wrote:
> ----- Original Message -----
>> From: "Aaron Gray" <aaronngray.lists@gmail.com>
>> To: "Git Mailing List" <git@vger.kernel.org>
>> Sent: Wednesday, June 15, 2011 9:52:58 AM
>> Subject: no autocrlf on Visual Studio subdirectory
>>
>> I am wondering if there is a way of keeping CRLF's under my
>> VisualStudio2010 subdirectory but applying core.autocrlf on all othe=
r
>> repository directories.
>
> Short answer is gitattributes eol setting. =A0Git will fallback to co=
re.autocrlf for files that aren't named in the .gitattributes file.
> Potentially useful is this [1] thread.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/174413/foc=
us=3D174496

Many thanks,

Aaron
