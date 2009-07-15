From: davidb@quicinc.com
Subject: Re: Dividing up a large merge.
Date: Tue, 14 Jul 2009 17:29:26 -0700
Message-ID: <20090715002926.GA26630@huya.quicinc.com>
References: <20090714233246.GA25390@huya.quicinc.com> <3e8340490907141716j77df346es1f894d6a7f6cb0aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 02:29:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQsNi-0007vu-4T
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 02:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526AbZGOA33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 20:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754181AbZGOA33
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 20:29:29 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:14295 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbZGOA32 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 20:29:28 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5676"; a="20725957"
Received: from pdmz-ns-mip.qualcomm.com (HELO numenor.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jul 2009 17:29:28 -0700
Received: from msgtransport01.qualcomm.com (msgtransport01.qualcomm.com [129.46.61.148])
	by numenor.qualcomm.com (8.14.2/8.14.2/1.0) with ESMTP id n6F0TSUp006736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Tue, 14 Jul 2009 17:29:28 -0700
Received: from huya.qualcomm.com (huya.qualcomm.com [10.46.166.122])
	by msgtransport01.qualcomm.com (8.14.2/8.14.2/1.0) with SMTP id n6F0TQBC011569;
	Tue, 14 Jul 2009 17:29:27 -0700
Received: by huya.qualcomm.com (sSMTP sendmail emulation); Tue, 14 Jul 2009 17:29:26 -0700
Content-Disposition: inline
In-Reply-To: <3e8340490907141716j77df346es1f894d6a7f6cb0aa@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123278>

On Tue, Jul 14, 2009 at 05:16:54PM -0700, Bryan Donlan wrote:

> What do you mean by describing a merge? git is designed to have all
> the information needed for a merge inherent in the repository history.

Yes, provided you can actually do the merge all at once.

> Why are there so many conflicts to make this an issue?

Because I have to work in the "real world".

> If the commits are isolated to small changes, rebasing the developer
> topic branches instead of merging may help, by allowing you to take
> conflicts one commit at a time. For example, if your problems are
> primarily conflicts between developer branches and upstream:

No real developer branches with conflicts (I make those be
fixed), but several upstreams.  We have many developers busily
doing work, and one or more other companies is also working on
the same code.  Meanwhile, the mainline kernel advances at it's
own astounding rate.

Unfortunately, paying customers will always get priority of work,
even when that position is actually somewhat shortsighted and it
makes for a lot of merge effort later.

The real issue is that there isn't any single individual who
understands all of the code that conflicts.  It has to be divided
up somehow, I'm just trying to figure out a better way of doing
it.

Thanks,
David
