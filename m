From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCHv3 1/2] Make xdi_diff_outf interface for running xdiff_outf diffs
Date: Thu, 14 Aug 2008 01:34:12 -0500
Message-ID: <20080814063412.GF4396@lavos.net>
References: <20080814053156.GE4396@lavos.net> <1218692211-26045-1-git-send-email-bdowning@lavos.net> <7v1w0sf7bl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 08:35:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTWQh-0007oI-F5
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 08:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbYHNGeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 02:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbYHNGeT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 02:34:19 -0400
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:54612
	"EHLO QMTA03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751527AbYHNGeS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 02:34:18 -0400
Received: from OMTA01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by QMTA03.westchester.pa.mail.comcast.net with comcast
	id 26Q81a0030EZKEL536aDCy; Thu, 14 Aug 2008 06:34:13 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA01.westchester.pa.mail.comcast.net with comcast
	id 26aD1a0034BqYqi3M6aDyA; Thu, 14 Aug 2008 06:34:13 +0000
X-Authority-Analysis: v=1.0 c=1 a=YTq5XthBrPEA:10 a=9yyhHhZq3XEA:10
 a=X5jBzCw7D74as-JG2akA:9 a=cZVmxDEmwHoM_uj67c4wcL3vwk4A:4 a=LY0hPdMaydYA:10
Received: by mnementh.lavos.net (Postfix, from userid 1000)
	id CF1E1309F23; Thu, 14 Aug 2008 01:34:12 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7v1w0sf7bl.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92326>

On Wed, Aug 13, 2008 at 11:18:22PM -0700, Junio C Hamano wrote:
> I wonder if something like this on top of your patch would be worth doing
> as a further clean-up.
> 
> -- >8 --
> xdiff-interface: hide the whole "xdiff_emit_state" business from the caller

Nice, looks good to me.

-bcd
