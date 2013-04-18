From: Sivaram Kannan <siva.devel@gmail.com>
Subject: Re: Git crash in Ubuntu 12.04
Date: Thu, 18 Apr 2013 20:46:45 +0530
Message-ID: <CAJiNi_HA5bNO8gMHkts_e+dWG26n=S7MRF5wc_L+v=rbnM91oQ@mail.gmail.com>
References: <CAJiNi_FfU9Gsr2D9CcC0wWwgO1oKBXwxp87-wBUJBU2kyGaQNQ@mail.gmail.com>
	<87mwt6ltia.fsf@linux-k42r.v.cablecom.net>
	<CAJiNi_EgjgKs7oNJyGcamUFz=ARDAuBTb+bJ0uVsPFBMbZF3YA@mail.gmail.com>
	<20130411170659.a35d2c581cf34ade13448bfa@domain007.com>
	<CAJiNi_Gju2aJkVJJmoxnEAubfPvjaVhVF6DisaLn5kUJ3YRD=w@mail.gmail.com>
	<20130412180525.aa5b8eacd691a427244d6ab5@domain007.com>
	<CAJiNi_GQZf8BRkTR8+j6YjdcqUH1J1NATSrNUjZ=65V+ip6okQ@mail.gmail.com>
	<CACsJy8AfVjhsBtfwJomRmoYsA3EMPja--y5Twq=T7-bCUQRU-w@mail.gmail.com>
	<CAJiNi_FBzz2Tqp_P8BB=X7UnAaHiNH8s0FyzW4K9Xp6WZijECw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 17:16:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USqZw-0000b5-5E
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 17:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967297Ab3DRPQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 11:16:48 -0400
Received: from mail-vb0-f47.google.com ([209.85.212.47]:37169 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966917Ab3DRPQq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 11:16:46 -0400
Received: by mail-vb0-f47.google.com with SMTP id x13so2490208vbb.20
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=rwJZeHpwhnYLF7dDQl19NNr3/QrfNTcLhUd4davxak4=;
        b=sCP+rE3CA/9TamU7wCLvic6a1/Hlp5lyvrLNfodnxteBf7cO2s6pK8qzdh3X5B908y
         VQaN56O24RfsQhh7CNoTH56gd/i/fq8ET1R71bftnRmgAV2Uy8LttOoTwD8lXwR+dU+i
         9if7vLmD8ypZ3eeCnsmtm44tg8R71q7olSkZkxJOo58BJh2K5F8JnMRESQYIFWObN6y6
         zyoMg4/lpl68VVRCbFmCJhpHWi1vlZtZe79kDA4F3nFKHbOYYXajxYCRSu2ZP16i9jXd
         tTcB/ymMudFOt+0ohxA38HiSzE/ImrfP3xp3WoL/j8mGbbJ/brMBNug0cUGs8+cvPoAp
         UO6A==
X-Received: by 10.58.85.134 with SMTP id h6mr8629333vez.18.1366298205570; Thu,
 18 Apr 2013 08:16:45 -0700 (PDT)
Received: by 10.221.3.131 with HTTP; Thu, 18 Apr 2013 08:16:45 -0700 (PDT)
In-Reply-To: <CAJiNi_FBzz2Tqp_P8BB=X7UnAaHiNH8s0FyzW4K9Xp6WZijECw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221663>

Hi,

The git crashed during one of the commits by a developer I think, the
remote is not even showing the working branch. The local branch of is
all right, but the remote repo is corrupted and could not git fsck
also. Is restoring the last night's backup is my only option??

$ git remote show origin
* remote origin
  Fetch URL: git@gitserver:sggroup/sgrid.git
  Push  URL: git@gitserver:sggroup/sgrid.git
  HEAD branch: master
  Remote branches:
    SGRID_5_5_0_BRANCH                 tracked
    master                                 tracked
    refs/remotes/origin/4_4_Release_Branch stale (use 'git remote prune' to remo
ve)
  Local branch configured for 'git pull':
    4_4_Release_Branch merges with remote 4_4_Release_Branch

Thanks,
./Siva.

On Thu, Apr 18, 2013 at 5:02 PM, Sivaram Kannan <siva.devel@gmail.com> wrote:
> Hi,
>
>> Probably not because there are no debugging symbols. Not sure how
>> ubuntu packages these symbols..
>
> Would recompiling the source packages and debugging would give
> different results?
>
>>
>> Any chance you could publish the repository that causes the crash?
>> --
>> Duy
>
> I don't think I can publish the repo online. But I am willing to try
> any steps on the repo to get more info. Most likely I would restore
> the latest repo to the stanby server I tested which works with any
> crash. Let me know what I can do to get more information.
>
> ./Siva.
