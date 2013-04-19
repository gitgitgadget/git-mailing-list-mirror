From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git crash in Ubuntu 12.04
Date: Fri, 19 Apr 2013 18:48:56 +1000
Message-ID: <CACsJy8CVC4RBtgCFShoGLsVm-B49TcECtL_RRExzECF69Ak5cg@mail.gmail.com>
References: <CAJiNi_FfU9Gsr2D9CcC0wWwgO1oKBXwxp87-wBUJBU2kyGaQNQ@mail.gmail.com>
 <87mwt6ltia.fsf@linux-k42r.v.cablecom.net> <CAJiNi_EgjgKs7oNJyGcamUFz=ARDAuBTb+bJ0uVsPFBMbZF3YA@mail.gmail.com>
 <20130411170659.a35d2c581cf34ade13448bfa@domain007.com> <CAJiNi_Gju2aJkVJJmoxnEAubfPvjaVhVF6DisaLn5kUJ3YRD=w@mail.gmail.com>
 <20130412180525.aa5b8eacd691a427244d6ab5@domain007.com> <CAJiNi_GQZf8BRkTR8+j6YjdcqUH1J1NATSrNUjZ=65V+ip6okQ@mail.gmail.com>
 <CACsJy8AfVjhsBtfwJomRmoYsA3EMPja--y5Twq=T7-bCUQRU-w@mail.gmail.com> <CAJiNi_FBzz2Tqp_P8BB=X7UnAaHiNH8s0FyzW4K9Xp6WZijECw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Sivaram Kannan <siva.devel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 10:49:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT70l-000215-DT
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 10:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758184Ab3DSIta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 04:49:30 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:63826 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758109Ab3DSIt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 04:49:27 -0400
Received: by mail-oa0-f51.google.com with SMTP id k14so3598179oag.24
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 01:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=x6LqWn29tB0hw6mZIoywqm+nvh2lFxCciL08e5+bsSU=;
        b=Kj/7o3x92M76Zczb4ezEPBye+m+2SZFEqypHxmL96aOXrcEMA0IOilRNbZZO3G9yhF
         gbcJLZmCiY3t8UebY97kbq2EADyNPJD+2/Uixou5HkxKrCVWYaqN1jPh8ZhCUaiwYQrG
         RJ6caz5qVZxhODnveYFatbfeCeocMjjkJNFhPm3yZsGGpZeKhAmR8mpx8Ru5fNlbIXd7
         S4Q/9iT+Fn0yfJ/gmYJJYh5kHxGcb5eezDRxMltdFmJA7TIeU9XLtLyLyWO/VAuwuzGz
         0CIy8lyOdt19gz+l7HzbDtj1k+oJZM2tCmrg7ZYUfRoqzIIxSImmh+eHJTtGaVvMhsHk
         xWvQ==
X-Received: by 10.182.19.168 with SMTP id g8mr8064961obe.21.1366361366711;
 Fri, 19 Apr 2013 01:49:26 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Fri, 19 Apr 2013 01:48:56 -0700 (PDT)
In-Reply-To: <CAJiNi_FBzz2Tqp_P8BB=X7UnAaHiNH8s0FyzW4K9Xp6WZijECw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221752>

On Thu, Apr 18, 2013 at 9:32 PM, Sivaram Kannan <siva.devel@gmail.com> wrote:
> Hi,
>
>> Probably not because there are no debugging symbols. Not sure how
>> ubuntu packages these symbols..
>
> Would recompiling the source packages and debugging would give
> different results?

Yes. Please do. The reason is a backtrace without symbols gives very
little information (at least for people who do not use Ubuntu).
--
Duy
