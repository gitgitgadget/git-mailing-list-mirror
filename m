From: PJ Weisberg <pjweisberg@gmail.com>
Subject: Re: How to check out the repository at a particular point in time
Date: Tue, 23 Aug 2011 03:04:35 -0700
Message-ID: <CAJsNXTk0LaSDKCOzJgZRLYmGe8hauPbPOw4oKLKP0Xr0axZkwg@mail.gmail.com>
References: <1314085268.42103.YahooMailClassic@web25406.mail.ukl.yahoo.com>
	<201108231117.00314.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: rdiezmail-temp2@yahoo.de,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"in-git-vger@baka.org" <in-git-vger@baka.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 23 12:04:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvnqb-0000K4-QU
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 12:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab1HWKEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 06:04:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47286 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab1HWKEg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 06:04:36 -0400
Received: by fxh19 with SMTP id 19so131001fxh.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=plq2MiA+RKS9/HkzIn6JY4A+p6mmIUaO47MBGNz3e24=;
        b=FaXEHPi51pLe1VMzhevcm/pVPAGGST1QppM3eD0xnd70047B3MK61YnZJcwfFTb4y0
         EFDrUdEPsgM1Dbjp6JvRJm+TYpDvI+1Pg+0Cut4IiN8XLDhAHTeahcvWdahK6dHRwYWP
         sRNF7oF5PfsEEiiI08H6cAdKsF9THBz+J6gjQ=
Received: by 10.223.63.131 with SMTP id b3mr5177714fai.68.1314093875446; Tue,
 23 Aug 2011 03:04:35 -0700 (PDT)
Received: by 10.223.72.9 with HTTP; Tue, 23 Aug 2011 03:04:35 -0700 (PDT)
In-Reply-To: <201108231117.00314.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179933>

On Tue, Aug 23, 2011 at 2:17 AM, Thomas Rast <trast@student.ethz.ch> wrote:

> I personally think that's crazy and -- if you want to avoid the work
> of "really" using submodules -- support Jens's suggestion of having
> the buildbot automatically assemble an "I tested this" superproject.

Or create a tag in each separate repository, using the same tag name
to indicate versions that were tested together.  Or you could do the
same with a branch, since a branch is basically a tag that moves.  You
would just have to make sure only the buildbot updated that branch.

-PJ
