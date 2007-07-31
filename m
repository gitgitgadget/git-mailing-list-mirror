From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Git error on Cygwin
Date: Tue, 31 Jul 2007 09:51:25 +0200
Message-ID: <81b0412b0707310051n4e62257bt279f65d159757876@mail.gmail.com>
References: <46AE1D77.8040609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Claudio Scordino" <cloud.of.andor@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 09:51:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFmVv-0001ud-Eh
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 09:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbXGaHv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 03:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbXGaHv2
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 03:51:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:64552 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbXGaHv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 03:51:27 -0400
Received: by nf-out-0910.google.com with SMTP id g13so201697nfb
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 00:51:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FdORGlb2qyhAQqBfCB9ISVtNZsT8Ovs2OG6iHmewIop8AJsIEg8vqqkv86+eZjtE51l5uwdzsOi3ueJnpqC0ykKR7+gCZTTf9vLoJE2qQQG9/p99rddVCg2hX9km0ly0mFTL+ePGhkgqz9znb2azUDJhayo7mF5cO4BzmVutrRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MNRSW2qhDf13QERxdSjNnubbzAF3XkNoIRoJkaVDGRLTUIgIbXQzWEG2510Xa5ywRNzQ3JYBfKoyMJE+u3RRo+9qMiFYEYftO3xxioNREMn5KNCTxbAugxvLdttnojJ5iE+U6ZOw/qGvX435451b1ibv7H3VcytsQu8fwe14ZF4=
Received: by 10.78.165.16 with SMTP id n16mr1715056hue.1185868285653;
        Tue, 31 Jul 2007 00:51:25 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Tue, 31 Jul 2007 00:51:25 -0700 (PDT)
In-Reply-To: <46AE1D77.8040609@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54325>

On 7/30/07, Claudio Scordino <cloud.of.andor@gmail.com> wrote:
> Hi all,
>
>    I just installed cygwin on Windows XP and I have the following error when
> using git-clone.
>
> (Consider that the same command on the same repository works on Linux).

Definitely.

> $ git-clone <username>@<host>:/<path>/<project>
> Initialized empty Git repository in /home/Claudio/<project>/.git/
> <username>@<host>'s password:
> remote: Generating pack...
> remote: Done counting 30387 objects.
> remote: Deltifying 30387 objects...
> remote:  100% (30387/30387) done
> Indexing 30387 objects...
> remote: Total 30387 (delta 4446), reused 30188 (delta 4351)
>   100% (30387/30387) done
> Resolving 4446 deltas...
>   100% (4446/4446) done
>        3 [main] git-read-tree 2160 C:\cygwin\bin\git-read-tree.exe: *** fatal
> error - could not load shell32, Win32 error 487
> /usr/bin/git-clone: line 404:  2160 Hangup                  git-read-tree -m -u
> $v HEAD HEAD

Report this to cygwin team. Try rerunning the command, usually
it helps (typical workaround for cygwin).
