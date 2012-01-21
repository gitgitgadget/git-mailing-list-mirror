From: David Brown <davidb@codeaurora.org>
Subject: Re: [Q] Determing if a commit is reachable from the HEAD ?
Date: Fri, 20 Jan 2012 20:58:03 -0800
Message-ID: <20120121045803.GA29328@codeaurora.org>
References: <201201201433.30267.brian.foster@maxim-ic.com>
 <m2ehuu8nrt.fsf@igel.home>
 <20120120180620.GA8504@codeaurora.org>
 <7v7h0mfahx.fsf@alter.siamese.dyndns.org>
 <20120120233335.GA20302@codeaurora.org>
 <7vzkdhdiot.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Brian Foster <brian.foster@maxim-ic.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 21 05:58:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoT1n-0001wq-KK
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 05:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866Ab2AUE6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 23:58:07 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:47888 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561Ab2AUE6F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 23:58:05 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6595"; a="156858678"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 20 Jan 2012 20:58:04 -0800
Received: from codeaurora.org (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 981A210004DC;
	Fri, 20 Jan 2012 20:58:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzkdhdiot.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188919>

On Fri, Jan 20, 2012 at 04:04:50PM -0800, Junio C Hamano wrote:
> David Brown <davidb@codeaurora.org> writes:
> 
> > Hmm, I thought I'd convinced myself that this was possible.  Now, I
> > can't come up with a way of doing it that doesn't involve improper
> > commits with earlier timestamps than their parents.
> 
> I'd actually want to see a way to do so that *does* involve timestamp
> skew.

Sorry, I guess I shouldn't tried this with a recent version of git.  I
can't cause this, and it looks like there's some pretty sophisticated
stuff in there to deal with this.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
