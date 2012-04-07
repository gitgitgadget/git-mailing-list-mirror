From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: bash-completion now loads completions dynamically, so __git_ps1
 is not defined when you open a shell
Date: Sat, 7 Apr 2012 08:47:49 -0500
Message-ID: <20120407134749.GA2377@burratino>
References: <CANaWP3wu3260uFNzCLJ=YSG1BWFr=ge_6CmMGrG6zLThvFnjcQ@mail.gmail.com>
 <20120328230642.GA16925@burratino>
 <CANaWP3w9KDu57aHquRRYt8td_haSWTBKs7zUHy-xu0B61gmr9A@mail.gmail.com>
 <CAMP44s0rYpVhPpaf=C_aPoLUxy=EsiSxYNf04+B0_-MxzCftFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kerrick Staley <mail@kerrickstaley.com>, gitster@pobox.com,
	git@vger.kernel.org, bash-completion-devel@lists.alioth.debian.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 15:48:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGVzo-0007Is-8G
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 15:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644Ab2DGNr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 09:47:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38255 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab2DGNr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 09:47:57 -0400
Received: by iagz16 with SMTP id z16so4146269iag.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=h1HoGaUjq7SJvY3Ica/pes4L+2gFTygTVxSKba8hSQk=;
        b=IGdfXaawQtVkSvF6j5aY+VIdI8AKyTY34C5xuUFflM46M86y8kRzoUgAcXOmxPK/1m
         YcW8xgwjTKhL7D+BTdPZMFI9MfSJI+4UiS087lsTqagu522oe41m0aWhOjrgakyGlLGE
         UXQtzQspF8V/q4keakTFcK9ryaLib6w+RzLow8/U0gS8PXJmntKE+H/d/FS85F0qr2s0
         5af10JJSN+L5GiUO32LfrnuPYb0ZlqL6huatnpeRseHSkJ76uxM1EJWRT9PheyvDHQ81
         6xMO82LrLnkf79cruDAV+I6ZBZIAtgbuNF3Z9og74NCO8eblKR+kcOv6ZW5JJ10sNFyk
         4lfw==
Received: by 10.50.195.232 with SMTP id ih8mr1058125igc.11.1333806475820;
        Sat, 07 Apr 2012 06:47:55 -0700 (PDT)
Received: from burratino (remote.soliantconsulting.com. [67.109.75.130])
        by mx.google.com with ESMTPS id wp5sm17135248igc.16.2012.04.07.06.47.54
        (version=SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 06:47:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s0rYpVhPpaf=C_aPoLUxy=EsiSxYNf04+B0_-MxzCftFw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194950>

Felipe Contreras wrote:
> On Thu, Mar 29, 2012 at 3:00 AM, Kerrick Staley <mail@kerrickstaley.com> wrote:

>> 1) define __git_ps1 (and friends) in a different script, which will
>> get installed in /etc/profile.d (this is the "proper way")
>
> I prefer this because it's useful for zsh as well

Sounds good to me.  In fact, I imagine you'll find no one it does not
sound good to.  Please feel free to make it so.
