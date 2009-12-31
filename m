From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Need some help with git rebase
Date: Thu, 31 Dec 2009 13:01:00 +0800
Message-ID: <be6fef0d0912302101ta010dfamab05b751a0ceee76@mail.gmail.com>
References: <4B38B3A7.6010900@steek.com> <1262211866.7068.1.camel@kheops>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: sylvain@abstraction.fr
X-From: git-owner@vger.kernel.org Thu Dec 31 06:01:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQD9o-0004y7-7h
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 06:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbZLaFBD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2009 00:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbZLaFBD
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 00:01:03 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:37805 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbZLaFBB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Dec 2009 00:01:01 -0500
Received: by iwn1 with SMTP id 1so8889686iwn.33
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 21:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EM4AE8BRSzDlvPZh82D+m0VF1SlCJu2gbMSaZF8hqL8=;
        b=gg2VM83JnaaO4K/7daB8hnU9+vnB8tvVJPovjSn8JOwDqxpss1g/YKrzWzWMieoJNF
         2k4adF+TBCv1KFyWwwczQTrL2cx3OtV7aFEOx6TW3ZPpfFKa30sxnhQ0qKdRVE1Mwox+
         1GAWjBNJaQ17bRD1TaJMDa8g6WgDW385lK1HI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i39q2rlnf9O86vIElQKhPX1UpD0cgZbLqdK6edX+fvch0h4SNAx6SHv1NFxhX3Xlla
         XmxLm8cQsdn+8iRA7dy9AojglooKZZzlAH4nLugEJifq3FfY+PPP3qYo2xBWloAxGiY5
         OxBD8uNh/x7SuKCNIiGoFpySm75zasMrriJTo=
Received: by 10.231.125.28 with SMTP id w28mr224801ibr.50.1262235660357; Wed, 
	30 Dec 2009 21:01:00 -0800 (PST)
In-Reply-To: <1262211866.7068.1.camel@kheops>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135931>

Hi,

On Thu, Dec 31, 2009 at 6:24 AM, Sylvain Rabot <sylvain@abstraction.fr>=
 wrote:
> And then, at the end of the rebase, without me doing anything, featur=
e
> branch is checked out and it seems that its HEAD has been reset to th=
e
> new 12.72.1 HEAD.
>
> --x--x--x--x--x--x--x--x--x--x--x--x master
> =A0 \
> =A0 =A0o--o--o--o--o--o--o--a--a--a--a--a--a--a--a--a 12.72.1 feature
>
> Is that normal ? If it is, how do I do to avoid my feature branch to =
be
> reset at 12.72.1's HEAD ?

reading the manual, I think this is normal.

According to the third paragraph of the description of git-rebase, the
branch feature will be reset to 12.72.1.

You can just rename the branch back to 12.72.1, and retrieve the old
tip of feature by examining the reflog.

--=20
Cheers,
Ray Chuan
