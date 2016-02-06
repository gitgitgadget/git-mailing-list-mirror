From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: Re: git show doesn't work on file names with square brackets
Date: Sat, 6 Feb 2016 17:29:20 +0300
Message-ID: <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
References: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com> <alpine.DEB.2.20.1602061518220.2964@virtualbox>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 06 15:29:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS3rc-0002FV-HT
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 15:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbcBFO3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2016 09:29:25 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35114 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbcBFO3Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2016 09:29:24 -0500
Received: by mail-lb0-f169.google.com with SMTP id bc4so63485575lbc.2
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 06:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-type:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Te8oh07M0wx+vnxltzWaGJN07eLsP+AyPxqnvzm+0lk=;
        b=lY+si2KyaMbZHa5uzDd15Hr5vS7tyYeZ+M4Yvbq3aFFYIFTqN+XvtjnOZD47z2qo6R
         aWNWf9qqO5Do54jgqH3xX8RSviMyFwIU6NyggGA/MY4zUP8ruerQIpuJnwighAMw6To9
         VxaJMlUCkZLGKOmtfDU3j0MP6QTbN3K8gokCKnFtI0/uRzAqymbQ5wlyqvHQojOC1pVU
         eJgl6p30rVMY6JViNScFxt8TcxGNPgedG0hD5t12EMTJhn/lsZD6phkfWg9rlPY2X5rf
         6D/A41hQF1sTasjJ3Hi+J1aMypLz+HTvux+CszEXKDhb6JXb0MV5oYTe2tkpHNgpf7RE
         pUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:mime-version:subject
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=Te8oh07M0wx+vnxltzWaGJN07eLsP+AyPxqnvzm+0lk=;
        b=OXK4zxbHU/vkOdXHc4G9ZT4byQCaRIBxmImPjLffNOtkei03lxoZo1v45QHBGm9GmH
         KcwGKoVIt8Dh93NJsR5uuMqI5J5xey17efsoRz0zhr/PCTtRRzLLR4OWbLHxa849dXUx
         0YHm6PjeUM8+e8EscNGIxgEcvRinKBg9+Py0Z4/VPypD14VAqfSYw+uBfDUjDTLgFucs
         D9TBpWIrEvKdm2mRlt6W6xFVgfcGW6nbIcNh/X8Nv5QEd36jrSiyS7cYmh6spZSicENF
         fnDMpqqBnVXoxGliM8TUKEh+nVRZZFYXqhwmUjvJExDLVB4teNg5g69XaaVNLg0rLk8p
         H3Ig==
X-Gm-Message-State: AG10YORc5QzxeryygOEwzzwq1p42f6JwLQ1rPTYEW57MNRENCNLUlKVs/mRktOB0/iunXf8w
X-Received: by 10.112.142.101 with SMTP id rv5mr7921888lbb.101.1454768962834;
        Sat, 06 Feb 2016 06:29:22 -0800 (PST)
Received: from loki.labs.intellij.net ([80.76.244.114])
        by smtp.gmail.com with ESMTPSA id i192sm2807080lfb.14.2016.02.06.06.29.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Feb 2016 06:29:22 -0800 (PST)
X-Google-Original-From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
In-Reply-To: <alpine.DEB.2.20.1602061518220.2964@virtualbox>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285690>

Hi Johannes,

thanks for your answer, but unfortunately it doesn=E2=80=99t help.

> On 06 Feb 2016, at 17:21 , Johannes Schindelin <Johannes.Schindelin@g=
mx.de> wrote:
>=20
> This is expected behavior of the Bash you are using. The commands tha=
t I
> think would reflect your intentions would be:
>=20
> 	git init brackets
> 	cd brackets
> 	echo 'asd' > 'bra[ckets].txt'
> 	git add 'bra[ckets].txt'
> 	git commit -m initial
> 	git show 'HEAD:bra[ckets].txt=E2=80=99


Nope. This command sequence doesn=E2=80=99t work for me: the same error=
 is returned:

    # git show 'HEAD:bra[ckets].txt'
    fatal: ambiguous argument 'HEAD:bra[ckets].txt': both revision and =
filename


> You could also escape the brackets with a backslash, as you did, but =
you
> would have to do it *every* time you write the path, not just in the =
`git
> add` incantation.


As I mentioned at the end of my original message, escaping doesn't help=
 either. `git add` works fine both with and without escape. It was auto=
-completed by bash completion, and I just forgot to remove the backslas=
hes before pasting the code here. At any case, escaping doesn=E2=80=99t=
 work with `git show`.