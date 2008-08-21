From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCHv3 1/2] Make xdi_diff_outf interface for running xdiff_outf diffs
Date: Thu, 21 Aug 2008 01:29:14 -0500
Message-ID: <20080821062914.GD31114@lavos.net>
References: <20080814053156.GE4396@lavos.net> <1218692211-26045-1-git-send-email-bdowning@lavos.net> <7v1w0sf7bl.fsf@gitster.siamese.dyndns.org> <20080821033756.GC31114@lavos.net> <7vzln7j5yx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 08:30:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW3gf-0008Nr-7U
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 08:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbYHUG3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 02:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbYHUG3U
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 02:29:20 -0400
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:48745
	"EHLO QMTA04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753167AbYHUG3U (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Aug 2008 02:29:20 -0400
Received: from OMTA09.westchester.pa.mail.comcast.net ([76.96.62.20])
	by QMTA04.westchester.pa.mail.comcast.net with comcast
	id 4uMK1a00A0SCNGk54uVFHh; Thu, 21 Aug 2008 06:29:15 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA09.westchester.pa.mail.comcast.net with comcast
	id 4uVE1a0084BqYqi3VuVEMw; Thu, 21 Aug 2008 06:29:15 +0000
X-Authority-Analysis: v=1.0 c=1 a=YTq5XthBrPEA:10 a=9yyhHhZq3XEA:10
 a=Ry3rdOmtvG6cgdKy9CsA:9 a=8nghseIXDIo8lApsERs_Uog5xdoA:4 a=LY0hPdMaydYA:10
Received: by mnementh.lavos.net (Postfix, from userid 1000)
	id 950FF309F23; Thu, 21 Aug 2008 01:29:14 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vzln7j5yx.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93114>

On Wed, Aug 20, 2008 at 10:24:22PM -0700, Junio C Hamano wrote:
> Is the reason why you mention "incremental" specifically because you only
> tested incremental, or you get identical result in non-incremental mode?

I've only tested incremental at this point.

> If your material is repetitive, say you have lines "A A A B C A A A" in
> the parent blob and "A A A B A A A" in the child blob, and you are trying
> to pass blame on three line block "A A A" at the beginning of the child,
> we can pass blame to the three lines at the beginning part, or to the end
> part, without Linus's common tail trimming optimization.  But there is no
> way it can match the end part with the optimization.
> 
> You cannot say one result is more correct than the other --- both are
> equally correct.  Of course, you could argue that with such a highly
> repetitive material, it may be better to match closer ones, but it's a
> judgement call.

Okay, that makes sense.  Thanks.

-bcd
