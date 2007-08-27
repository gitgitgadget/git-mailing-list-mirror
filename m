From: David Kastrup <dak@gnu.org>
Subject: Re: Git and OpenDocument (OpenOffice.org) files
Date: Mon, 27 Aug 2007 15:58:04 +0200
Message-ID: <866431rser.fsf@lola.quinscape.zz>
References: <vpqk5rh5mp5.fsf@bauges.imag.fr> <7vps19jnm1.fsf@gitster.siamese.dyndns.org> <vpqtzql17gd.fsf@bauges.imag.fr> <20070827130346.GA8821@glandium.org> <Pine.LNX.4.64.0708271440500.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 16:00:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPf8U-0006Xb-9e
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 16:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbXH0OAG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 10:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbXH0OAG
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 10:00:06 -0400
Received: from main.gmane.org ([80.91.229.2]:50455 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753366AbXH0OAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 10:00:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IPf8M-0002T1-7J
	for git@vger.kernel.org; Mon, 27 Aug 2007 16:00:02 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 16:00:02 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 16:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:kePWHXT/1l8Ps8v8d6ChN0KyL5g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56840>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 27 Aug 2007, Mike Hommey wrote:
>
>> BTW, wouldn't it be more efficient to store the odf files unzipped ?
>
> Efficient how?  Speed-wise: no.  Space-wise: yes.

Huh?  At least the "Space-wise: yes" seems rather nonsensical.
"Speed-wise" is not as clear: it depends on the relation between
memory/disk bandwidth and decompression speed.

-- 
David Kastrup
