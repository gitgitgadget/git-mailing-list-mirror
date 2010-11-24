From: Ilyas -- <umask00@gmail.com>
Subject: Re: Versioning configuration files on a server: fatal: Unable to
 create '//etc/.git/index.lock': No such file or directory
Date: Wed, 24 Nov 2010 12:46:38 +0300
Message-ID: <AANLkTinpwM=3P0Zz-t_j1sh=7s8h6mh-oiymuxdU9HL_@mail.gmail.com>
References: <AANLkTikfg9fLtqC6V3hQkiSZ+RfWqViJsHPxrt6ycoRR@mail.gmail.com>
	<AANLkTim_sPyVGK3XWEVseseRzcmNM-YS=aFSWZeBiB7n@mail.gmail.com>
	<20101124085030.GB22067@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ilyas -- <umask00@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 24 10:46:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLBw8-0002jP-AD
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 10:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab0KXJql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 04:46:41 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44473 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab0KXJqk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 04:46:40 -0500
Received: by wyb28 with SMTP id 28so9292268wyb.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 01:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=TQg7V6775JDeztOzvp5bFkX66jEDcBng2UXwsOq/gwk=;
        b=Qnx5WOn99B74WSQa/upjzXcSfp0f6RsF8wzUlTtRBvciG7HXBHsOa75ZuUbUvdUf8T
         c9Q35hyjIYX2xnXodIdP5gJ5chpcNUsYGIk9NmN3kxaRKquE1knFX991nJX1VNf3hsY3
         VcRq2UzUmNJp/zIXKa6S8wpIxNtOPqvp3w3NI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=RdyhTLCJ863SCrJmal8MDnYqVbSC01kHAvudHQV6sx9/kjzyfjLZAwfJ2wTJGAWumK
         8fUZUa9m36oPBwbwyyjyv2nts4haWn49xpTidQbcViUr+ZTQUrkamCIwo14OZeBbis4p
         dTy+G8NjwMQNPE2bEh4gMtxDotw3qpgrR/uqM=
Received: by 10.216.11.205 with SMTP id 55mr2042714wex.72.1290591998893; Wed,
 24 Nov 2010 01:46:38 -0800 (PST)
Received: by 10.216.234.216 with HTTP; Wed, 24 Nov 2010 01:46:38 -0800 (PST)
In-Reply-To: <20101124085030.GB22067@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162055>

Yes, patch which I sent provided by Matthijs Kooijman in other thread
(with the same subject).

We use git on many servers for track configs and when we get troubles
with /.git we was really stressed.



I hope that this issue will be fixed in upstream soon.


Thank you.


On Wed, Nov 24, 2010 at 11:50 AM,  <matthijs@stdin.nl> wrote:
> Hi folks,
>
> On Wed, Nov 24, 2010 at 03:45:43PM +0700, Nguyen Thai Ngoc Duy wrote:
>> On Wed, Nov 24, 2010 at 3:01 PM, Ilyas -- <umask00@gmail.com> wrote:
>> > The patch bellow for problem 'Versioning configuration files on a
>> > server: fatal: Unable to create '//etc/.git/index.lock': No such file
>> > or directory' works fine on FreeBSD/Linux.
>> > Please fix this problem in upstream.
>>
>> I also have another patch to fix this [1]. Hopefully Junio will pick it up soon.
> The patch sent by Ilyas is mine and it was just a quick hack. Please use
> the patch sent later by Nguyen instead, it solves the problem properly:
>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/161825
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkzs0dYACgkQz0nQ5oovr7xKwQCgqd/l6cuub7zXlnbepYCDRwEW
> i88AniNyZFrWeYS5gNlKJfEnENo6ml2p
> =uRWs
> -----END PGP SIGNATURE-----
>
>
