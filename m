From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 16:04:47 +0200
Message-ID: <AANLkTikcQJjwFtsWhr+75vcZbwVxFVzqMttHX1Rz0rw7@mail.gmail.com>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
	<4D908170.2020207@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Mon Mar 28 16:04:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4D3x-0006xL-RP
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 16:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409Ab1C1OEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 10:04:49 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37470 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab1C1OEt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 10:04:49 -0400
Received: by wya21 with SMTP id 21so2866427wya.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CxQxoS/w7kGlOjKlHUP4lKCgh7m9Gdie5RPUNHZGP7s=;
        b=EWes3a3mjrNIkWXsJBmVVwwTIOTgjG9nnqBh9WuMEYXHzLkAMPbRcMPdBH3Go+hftt
         Pi1VyTT8dsT/ZElrCWPmc1Vx2ZJ0tniQNC1BvGWl+y/Q3aFTxaERVkvJ2ojxz+bN3H6I
         60dq3xOs4fcPAl2NaGac1Q0NTAogsO665LzZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PWh4SZtlpIJ99G8j8qk4BYl5ApLumtQ0zYwW/3zjZBDgGSpiGnVepwZZ570NjF9NuZ
         MNVRg2LnWjGbC0R9wWEyVqWHB7jTkQxcND/9m1mSnjzTCmJls3hWvla2yNYH0DL8osQd
         O+uu66g9blsWjd/BoGFcidI9OdAFTr8PtQpxw=
Received: by 10.216.121.208 with SMTP id r58mr2681830weh.61.1301321087788;
 Mon, 28 Mar 2011 07:04:47 -0700 (PDT)
Received: by 10.216.89.12 with HTTP; Mon, 28 Mar 2011 07:04:47 -0700 (PDT)
In-Reply-To: <4D908170.2020207@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170129>

On Mon, Mar 28, 2011 at 2:39 PM, Vincent van Ravesteijn <vfr@lyx.org> wrote:
>
>> Why can't bisect just do the right thing here and accept that your
>> more recent revesion is the good one, and the old one is the bad one?
>
> There was a recent discussion about this:
>
> http://article.gmane.org/gmane.comp.version-control.git/165433

The recent discussion about this topic is rather this one:

http://thread.gmane.org/gmane.comp.version-control.git/165141

and it refers to this one that started with Dscho's patch:

http://thread.gmane.org/gmane.comp.version-control.git/86063

Thanks,
Christian.
