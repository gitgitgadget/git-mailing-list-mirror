From: david@lang.hm
Subject: Re: Does anyone have any benchmarks against CVS?
Date: Mon, 11 Jun 2007 15:06:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0706111505030.6457@asgard.lang.hm>
References: <20070611090451.26209.qmail@science.horizon.com>
 <46a038f90706111454i5f4898b5kd77d18f4a893904e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 00:09:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxs4O-0004g2-5g
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 00:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbXFKWI4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 18:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753712AbXFKWI4
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 18:08:56 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:54568
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbXFKWIz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 18:08:55 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l5BM835r009778;
	Mon, 11 Jun 2007 15:08:03 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <46a038f90706111454i5f4898b5kd77d18f4a893904e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49892>

On Tue, 12 Jun 2007, Martin Langhoff wrote:

> Date: Tue, 12 Jun 2007 09:54:50 +1200
> From: Martin Langhoff <martin.langhoff@gmail.com>
> To: "linux@horizon.com" <linux@horizon.com>
> Cc: git@vger.kernel.org
> Subject: Re: Does anyone have any benchmarks against CVS?
> 
> On 11 Jun 2007 05:04:51 -0400, linux@horizon.com <linux@horizon.com> wrote:
>>  It seems to be common knowledge that git is a heck of a lot faster than
>>  CVS at most operations, but I'd like to do a little evangelizing and
>>  I can't seem to find a benchmark to support that claim.
>
> It _will_ be a bit of an apple-to-oranges comparison, but you could
> use a few large-ish projects that have a published GIT gateway.
> Measure time and bw use of
>
>   - cvs co vs git clone

given that the result of this is that cvs gives you one version and git 
clone gives you the entire history you should probably also test what it 
takes to checkout an older version after doing the first one.

David Lang

>   - cvs status vs git status
>   - cvs update vs git pull
>   - cvs log (at top level) vs git log
>   - cvs log path/to/file vs git log path/to/file
>
> I would suggest
>
> - Moodle (for which I maintain an http-fetchable repo at
> http://git.catalyst.net.nz/git/moodler2.git )
> - PostgreSQL (repo.or.cz hosts a repo)
>
> cheers
>
>
> m
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
