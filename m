From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree
 info
Date: Tue, 23 Feb 2016 17:32:21 +0800
Message-ID: <20160223093221.GC7150@wfg-t540p.sh.intel.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
 <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
 <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
 <20160223014741.GA21025@wfg-t540p.sh.intel.com>
 <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
 <20160223091740.GA3830@wfg-t540p.sh.intel.com>
 <56CC2507.7060300@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christoph Hellwig <hch@lst.de>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Feb 23 10:32:48 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aY9Ko-0004Ki-0K
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Feb 2016 10:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbcBWJce (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 04:32:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:41850 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbcBWJca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 04:32:30 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP; 23 Feb 2016 01:32:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,488,1449561600"; 
   d="scan'208";a="657723878"
Received: from liquan1-mobl1.ccr.corp.intel.com (HELO wfg-t540p.sh.intel.com) ([10.254.214.237])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2016 01:32:22 -0800
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.86)
	(envelope-from <fengguang.wu@intel.com>)
	id 1aY9KP-0001yR-N2; Tue, 23 Feb 2016 17:32:21 +0800
Content-Disposition: inline
In-Reply-To: <56CC2507.7060300@zytor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287037>

On Tue, Feb 23, 2016 at 01:23:19AM -0800, H. Peter Anvin wrote:
> On 02/23/16 01:17, Fengguang Wu wrote:
> > 
> > However we are facing a new situation: in test robot POV, IMHO there
> > are values to test exactly the same tree as the patch submitter.
> > Otherwise the robot risks
> > 
> > - false negative: failing to apply and test some patches
> > - false positive: sending wrong bug reports due to guessed wrong base tree
> > 
> 
> Wouldn't the important part here be the git hash, rather than the tree?
>  If you have the same hash then it by definition is the same contents?

Yes. Sorry for the partial wording! We should be talking about the
same thing: the hash of the tree object. The commit SHA1 will also
do the work.

Thanks,
Fengguang
