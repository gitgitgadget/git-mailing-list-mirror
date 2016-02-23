From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree
 info
Date: Tue, 23 Feb 2016 13:32:53 +0300
Message-ID: <20160223103253.GE5273@mwanda>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
 <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
 <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
 <20160223014741.GA21025@wfg-t540p.sh.intel.com>
 <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
 <20160223091740.GA3830@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christoph Hellwig <hch@lst.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Feb 23 11:33:37 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYAHh-0006FO-44
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Feb 2016 11:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbcBWKd1 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 05:33:27 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:40377 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbcBWKdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 05:33:23 -0500
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u1NAWwvP009483
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 23 Feb 2016 10:32:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u1NAWwka021482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Tue, 23 Feb 2016 10:32:58 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u1NAWvFH001833;
	Tue, 23 Feb 2016 10:32:57 GMT
Received: from mwanda (/154.0.139.178)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 23 Feb 2016 02:32:56 -0800
Content-Disposition: inline
In-Reply-To: <20160223091740.GA3830@wfg-t540p.sh.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287041>

So this is the format for the first patch?

base commit: 0233b800c838ddda41db318ee396320b3c21a560

Can we change it to include the name of the public tree we are starting
from?

applies-to: 0233b800c838 git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git#master

Of course, my absolute prefered format would be:

applies-to: net-next 0233b800c838

I don't think that's possible though?  I often write that sort of a line
in my emails to Dave already.

Fengguang was suggesting something like this if we have to include
unmerged patches:

applies-to: net-next 0233b800c838
private patchset 1
private patchset 2

I don't think git knows what a patchset is.  We would have to include
the subject line for each unmerged patch.  I think we should only do
that if there is a cover letter, otherwise the it's too noisy.

regards,
dan carpenter
