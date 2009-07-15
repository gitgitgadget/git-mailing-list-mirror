From: davidb@quicinc.com
Subject: Re: Dividing up a large merge.
Date: Wed, 15 Jul 2009 14:01:13 -0700
Message-ID: <20090715210113.GA18036@huya.quicinc.com>
References: <20090714233246.GA25390@huya.quicinc.com> <3e8340490907141716j77df346es1f894d6a7f6cb0aa@mail.gmail.com> <20090715002926.GA26630@huya.quicinc.com> <alpine.LNX.2.00.0907151429490.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Donlan <bdonlan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jul 15 23:01:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRBbT-0007i7-8j
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 23:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbZGOVBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 17:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbZGOVBS
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 17:01:18 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:51646 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323AbZGOVBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 17:01:17 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5677"; a="20771131"
Received: from pdmz-ns-mip.qualcomm.com (HELO ithilien.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Jul 2009 14:01:17 -0700
Received: from msgtransport02.qualcomm.com (msgtransport02.qualcomm.com [129.46.61.151])
	by ithilien.qualcomm.com (8.14.2/8.14.2/1.0) with ESMTP id n6FL1HP3002330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Wed, 15 Jul 2009 14:01:17 -0700
Received: from huya.qualcomm.com (huya.qualcomm.com [10.46.166.122])
	by msgtransport02.qualcomm.com (8.14.2/8.14.2/1.0) with SMTP id n6FL1E1x015511;
	Wed, 15 Jul 2009 14:01:16 -0700
Received: by huya.qualcomm.com (sSMTP sendmail emulation); Wed, 15 Jul 2009 14:01:13 -0700
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0907151429490.2147@iabervon.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123334>

On Wed, Jul 15, 2009 at 11:57:59AM -0700, Daniel Barkalow wrote:

> It sounds to me like you're maintaining an internal version that everybody 
> merges their stuff into, and you periodically merge that with the mainline 
> kernel (generating a lot of conflicts which have to be resolved at the 
> same time). Instead of merging the branch that contains a lot of merges, 
> it would probably be easier to merge into a clone of mainline each of the 
> things that was merged before. That is, instead of merging less than all 
> of two trees, you'd merge commits which are not the newest commit on the 
> branch, choosing ones that individuals can resolve.

That's part of it, although I have a pretty good handle on that
part.

The place where this comes up is that people in company X are
working on an internal version and company Y are working on a
similar internal version.  We need to share back and forth
between these more frequently than stuff gets into the mainline.

We do rebase at various points, but it takes quite a bit of work,
and it's fairly different work than the conflicts I'm concerned
with here.

Thanks,
David
