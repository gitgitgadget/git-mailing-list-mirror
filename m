From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v5 3/4] format-patch: introduce --base=auto option
Date: Sun, 24 Apr 2016 12:32:48 +0800
Message-ID: <20160424043247.GB1258@yexl-desktop>
References: <1461303756-25975-1-git-send-email-xiaolong.ye@intel.com>
 <1461303756-25975-4-git-send-email-xiaolong.ye@intel.com>
 <xmqqk2jpnwc7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 06:33:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auBk6-0006jQ-47
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 06:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbcDXEdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 00:33:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:45840 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbcDXEdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 00:33:53 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP; 23 Apr 2016 21:33:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,525,1455004800"; 
   d="scan'208";a="961494713"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.139])
  by orsmga002.jf.intel.com with ESMTP; 23 Apr 2016 21:33:51 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com
Content-Disposition: inline
In-Reply-To: <xmqqk2jpnwc7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292312>

On Fri, Apr 22, 2016 at 02:54:16PM -0700, Junio C Hamano wrote:
>Xiaolong Ye <xiaolong.ye@intel.com> writes:
>
>> +		if (upstream) {
>> +			unsigned char sha1[20];
>> +			if (get_sha1(upstream, sha1))
>> +				die(_("Failed to resolve '%s' as a valid ref."), upstream);
>> +			struct commit *commit = lookup_commit_or_die(sha1, "upstream base");
>> +			struct commit_list *base_list = get_merge_bases_many(commit, total, list);
>
>This introduces decl-after-statement.

will fix it.

Thanks,
Xiaolong.
