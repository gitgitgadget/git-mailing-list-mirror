From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 15:32:03 -0800
Message-ID: <7vljsdkgwc.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0902101427300.19665@iabervon.org>
 <20090210201203.GU30949@spearce.org>
 <alpine.LNX.1.00.0902101520240.19665@iabervon.org>
 <20090210212539.GV30949@spearce.org>
 <alpine.LNX.1.00.0902101628140.19665@iabervon.org>
 <20090210213612.GW30949@spearce.org>
 <7vprhqkjrr.fsf@gitster.siamese.dyndns.org>
 <7vfxillxiu.fsf@gitster.siamese.dyndns.org>
 <20090210230950.GX30949@spearce.org>
 <7vtz71khoi.fsf@gitster.siamese.dyndns.org>
 <20090210231653.GY30949@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:33:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX26l-00085E-Vt
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159AbZBJXcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755946AbZBJXcM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:32:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbZBJXcM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:32:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1092F2ADDD;
	Tue, 10 Feb 2009 18:32:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 101562ADBB; Tue,
 10 Feb 2009 18:32:04 -0500 (EST)
In-Reply-To: <20090210231653.GY30949@spearce.org> (Shawn O. Pearce's message
 of "Tue, 10 Feb 2009 15:16:53 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0A1475BA-F7CB-11DD-914E-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109343>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> The patch can and should go to maint, right?
>
> Yea, maint.  Don't forget the ';' I forgot in sha1_file.c.
>
> Clearly, I failed to compile-test it before sending.  :-)

That's Ok, I always compile test before merging the result of "git am" to
any other place ;-).
