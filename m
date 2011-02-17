From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: set-upstream for existing branch...?
Date: Thu, 17 Feb 2011 02:45:07 -0500
Message-ID: <AANLkTi=GPeo9Xr2taF6bsTF554SguDKGHo_S4P62xyxX@mail.gmail.com>
References: <buoei77xmpc.fsf@dhlpc061.dev.necel.com> <AANLkTikqj8NjLwR647E1tHUuDO=OitUJ1dm5Fs7gtXXt@mail.gmail.com>
 <buo8vxfxhhy.fsf@dhlpc061.dev.necel.com> <AANLkTim6HDCaeTDuEtK+3niKKoz6A3KA=m=UCr4DaY-V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Feb 17 08:45:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpyYa-0006JX-Qe
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 08:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743Ab1BQHpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 02:45:39 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50797 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab1BQHpi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 02:45:38 -0500
Received: by iyj8 with SMTP id 8so2081192iyj.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 23:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=dPILuYwY2iVuV3WYqT8+SiH6ShykvEke/QGvlCwn0pQ=;
        b=ofZ1aEw2wJ5L+wyRwJfuUYqqAHIqfS2Ngj/+pWBi2aEw3tfLfvwUjWJVdcMpZ6x/dx
         sCknVeUdTvp9PmUWeJKFCYYXObOPlvASGqeAWJh+Md1gTtU41bR1Z4H00Dv5jaOOplBL
         qN514OgXbRYCVMchEK8g0bLxGaoEj+4cIBDaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=w+V/rDrJz+JoSQY3S9G+QefiOlaDARQZwradw6vrskUxRsO5JYN0TOy1894AIrcgN9
         X0+4XJQIBaCPcZo/L7wN98295RQcjmmwx4WpIS61RG1VPWWVJE4ZioE8ShgATO2NTJNs
         JT465tVc+6JllyVrLnOuoRHBq+o9ips4606gw=
Received: by 10.231.36.69 with SMTP id s5mr1283173ibd.167.1297928737569; Wed,
 16 Feb 2011 23:45:37 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Wed, 16 Feb 2011 23:45:07 -0800 (PST)
In-Reply-To: <AANLkTim6HDCaeTDuEtK+3niKKoz6A3KA=m=UCr4DaY-V@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167050>

On Thu, Feb 17, 2011 at 2:24 AM, Miles Bader <miles@gnu.org> wrote:
> Hmm, on a related note, is there an obvious way to _show_ the current
> branch's upstream...?
>
> [I mean, which just prints out "origin/master" or whatever...]

git rev-parse --abbrev-ref @{u}

j.
