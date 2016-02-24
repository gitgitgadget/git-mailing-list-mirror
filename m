From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree
 info
Date: Tue, 23 Feb 2016 17:40:45 -0800
Message-ID: <56CD0A1D.9050207@zytor.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
 <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
 <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
 <20160223014741.GA21025@wfg-t540p.sh.intel.com>
 <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
 <20160223091740.GA3830@wfg-t540p.sh.intel.com>
 <xmqq1t8319z0.fsf@gitster.mtv.corp.google.com>
 <87d1rnjil4.fsf@x220.int.ebiederm.org>
 <xmqqtwkzyxkv.fsf@gitster.mtv.corp.google.com>
 <3FAB2030-8106-4114-99A4-B04A8A0D22FB@zytor.com>
 <87bn77hzbp.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Feb 24 02:41:32 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYOSK-0002mn-0r
	for glk-linux-kernel-3@plane.gmane.org; Wed, 24 Feb 2016 02:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbcBXBlZ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 20:41:25 -0500
Received: from terminus.zytor.com ([198.137.202.10]:53640 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899AbcBXBlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 20:41:23 -0500
Received: from anacreon.sc.intel.com (jfdmzpr04-ext.jf.intel.com [134.134.137.73])
	(authenticated bits=0)
	by mail.zytor.com (8.15.2/8.14.5) with ESMTPSA id u1O1f37b018863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Tue, 23 Feb 2016 17:41:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <87bn77hzbp.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287155>

On 02/23/2016 01:49 PM, Eric W. Biederman wrote:
> 
> So I could really respect a patch header line that said:
> tree abcdef0123456789...0123456789abcdef
> 
> Where the numbers where the truncated tree hash before and after a patch
> was applied.  That would seem to give a little bit of extra sanity
> checking in the application of git diffs as well.
> 

I would rather have the untruncated base tree ID.  The truncated file
IDs already provide the verification component, and it is *way* cheaper
to search for an untruncated ID.

	-hpa
