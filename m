From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Re* Regulator updates for 3.3
Date: Mon, 16 Jan 2012 16:43:22 -0700
Organization: CAF
Message-ID: <201201161643.23211.mfick@codeaurora.org>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com> <4F136BE4.4040502@pcharlan.com> <7v62gbussz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Pete Harlan <pgit@pcharlan.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junio@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Jan 17 00:43:43 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RmwDB-0003V3-LP
	for glk-linux-kernel-3@lo.gmane.org; Tue, 17 Jan 2012 00:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151Ab2APXn1 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 16 Jan 2012 18:43:27 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:31513 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab2APXn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2012 18:43:26 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6591"; a="155485224"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 16 Jan 2012 15:43:23 -0800
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id AAFF110004DC;
	Mon, 16 Jan 2012 15:43:23 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7v62gbussz.fsf@alter.siamese.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188676>

On Monday, January 16, 2012 04:33:00 pm Junio C Hamano 
wrote:
> With your suggestion, they need to export
> "GIT_MERGE_EDIT=0" today, and they will need to update
> again to export "GIT_MERGE_SOMETHINGELSE=0" when such an
> incompatible change comes.
> 
> With a single "GIT_MERGE_LEGACY=YesPlease", they can be
> future-proofed today and will not be affected when we
> make another incompatible change.
> 
> So I am not sure why separating the big-red-switch into
> smaller pieces would be an improvement, especially wnen
> the scripts that want to specify finer-grained control
> of features can use "--[no-]edit" options to explicitly
> ask for it.


Then, what would I do if I write a script which uses the new 
edit functionality (without even being aware that there was 
an old way) and you introduce a new incompatibility?  I 
can't turn on GIT_MERGE_LEGACY then since it would revert to 
behavior which my script would not expect (since it was 
written after the current incompatibility, but before the 
new one)!

-Martin
