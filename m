From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Re: need to create new repository initially seeded with
 several branches
Date: Wed, 31 Aug 2011 11:45:02 -0500
Message-ID: <yOArP4qOaF5Yee5Bgcafl_795D9Xnz_IaUH21_GToggoTEy0uLzpGd3OA-rFJt2MlFFYbhvSBNDlv5C_GjSvXfcw7SRn4Ut12giha2cV4yM@cipher.nrlssc.navy.mil>
References: <1314804325568-6746957.post@n2.nabble.com> <uvMkLVapQYcSvOHVhcHX8CqGzEDajPEPvBbkL_DctzZvxm7aI-PjCQ@cipher.nrlssc.navy.mil> <201108311624.p7VGOWWq018472@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "ryan@iridiumsuite.com" <ryan@iridiumsuite.com>,
	Git Mailing List <git@vger.kernel.org>
To: in-git-vger@baka.org
X-From: git-owner@vger.kernel.org Wed Aug 31 18:45:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qynug-00005Y-UR
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 18:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108Ab1HaQpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 12:45:13 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:56053 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932100Ab1HaQpM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 12:45:12 -0400
Received: by mail3.nrlssc.navy.mil id p7VGj3gG018586; Wed, 31 Aug 2011 11:45:03 -0500
In-Reply-To: <201108311624.p7VGOWWq018472@no.baka.org>
X-OriginalArrivalTime: 31 Aug 2011 16:45:02.0560 (UTC) FILETIME=[544CAE00:01CC67FD]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180483>

On 08/31/2011 11:24 AM, in-git-vger@baka.org wrote:
> 
> In message <sDZ5pnWzh3ZbFYS6GK-NcPdn09kF53MJ2eRkBnzInzdL8-cvCiF5beUw2k9Pz6BTq-Y3i_XwpYfgTOvXNlP1vPjLSHJ6FIzxL0jN1W0d0M8@cipher.nrlssc.navy.mil>, Brandon Casey writes:
> 
>        rm -rf * &&               # remove the files in the working dir
> 
> I just note (for your information only) that this doesn't get rid of
> any . files which might exist.  That is the advantage of the
> git-read-tree;git-clean or the `find | xargs rm` alternatives I
> mentioned in my post.  99% of the time it doesn't matter of course,
> since it would only fail on . files which were deleted in the data
> stream you were replacing.

I was just crafting a reply to your message to say the same thing.

Note also that the dot files would not have been copied into the
working directory in the first place, using a command like this:

   cp -a /some/path/* .

So, Ryan, if your project contains dot files that you would want
to track, take care that they are actually copied and deleted
with the other files while you are creating your repository.

-Brandon
