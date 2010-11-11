From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: How to recover a lost commit...
Date: Thu, 11 Nov 2010 12:34:13 -0500
Message-ID: <AANLkTikqBXjAf44O0QERH39rK+7nNA8uD2CwtPKJTTyV@mail.gmail.com>
References: <AANLkTinfYTMKicr3V=T=scVpOte_XrmaDgVA_oMj2fYU@mail.gmail.com> <201011111649.oABGnjca019731@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Thu Nov 11 18:34:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGb2x-0000Xi-Ny
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 18:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093Ab0KKReg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 12:34:36 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48149 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081Ab0KKRef convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 12:34:35 -0500
Received: by fxm16 with SMTP id 16so1530737fxm.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 09:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=iCgsqa9OPsDBe9FoIslhjUIswgHXfrcIHqm7UrUdx9U=;
        b=nldiuw8Cs8ssQGocWq1WCtNd3jWn7OFb9yuHkcbZFBjveYjqp0zwLLR+E3ilqUJ3fn
         SjFy3ou2lB4EGeN48DcGcuXYoA8tgIuTbthun4jIBGeEcGi/8rfUXbdC/GSVrEKqU9RL
         S3XCQIgz65KXXuVvuj23u9A3fA7/7/+23CWkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tDjXNPlOheWhvRBqZovbrnkZnKGJDapjltU41n5q0VS6ADQTwuubtCYdUIIGNtsCjl
         ac4TlOQw6SWSYasdEblaoAbCvzEdClU0F1qJvEVsvUDGD7FkLKCRF+2CDBEG2mHHCfxH
         qr/FjEGOn9JNyFLw5bj8VZvYeDn+xRlEY32s0=
Received: by 10.223.118.132 with SMTP id v4mr423567faq.87.1289496873623; Thu,
 11 Nov 2010 09:34:33 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Thu, 11 Nov 2010 09:34:13 -0800 (PST)
In-Reply-To: <201011111649.oABGnjca019731@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161274>

On Thu, Nov 11, 2010 at 11:49 AM, Seth Robertson <in-gitvger@baka.org> =
wrote:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0-Seth Robertson
>
> HEAD@{27} was your original problem. =A0You made the commit on @{32}
> then for some reason did (probably) a `git reset HEAD^` That was the
> source of all of your problems. =A0You should only use `git reset` if
> you have not pushed and if you are very sure you want to get rid of a
> commit or changes. =A0It is a powerful command and with great power
> comes great responsibility.
>

Hello Seth,
Thank you for your reply and cogent explanation.  Yes, in fact, I did
do a "git reset HEAD^".  Somewhere along the way, I decided that was a
way to make my working copy look like it did prior to a commit.

I thought that git reset only affected HEAD.  I didn't realize that it
also affected the branch pointer.

Your "great power, great responsibility" comment will make me treat
"git reset" with a lot more fear and respect.

It is confusing though, because I frequently see advice (such as that
offered by Jonathan Nieder (and very much appreciated, by the way) to
do things like:

$ git merge --no-commit
$ git reset

Why is that "git reset" benign, when the "git reset HEAD^" wasn't benig=
n before?

--wpd
