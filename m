From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [offtopic?] xdelta patch format wrapper
Date: Tue, 12 Feb 2008 19:56:53 -0800
Message-ID: <7vprv1y0e2.fsf@gitster.siamese.dyndns.org>
References: <47B24D8A.5090703@catalyst.net.nz>
 <7vy79py1it.fsf@gitster.siamese.dyndns.org>
 <47B26830.6090501@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jmacd@cs.berkeley.edu
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Feb 13 04:58:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP8lM-0005ld-LE
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 04:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbYBMD5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 22:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322AbYBMD5r
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 22:57:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbYBMD5q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 22:57:46 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BA2A224F;
	Tue, 12 Feb 2008 22:57:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 BF3112232; Tue, 12 Feb 2008 22:57:06 -0500 (EST)
In-Reply-To: <47B26830.6090501@catalyst.net.nz> (Martin Langhoff's message of
 "Wed, 13 Feb 2008 16:46:56 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73742>

Martin Langhoff <martin@catalyst.net.nz> writes:

> Junio C Hamano wrote:
>> I am lost as to your objective because you seem to be keeping a
>> whole LOT more than I would have imagined for a specialized
>> purpose file format.
>
> My source files are 2 zipfiles that I know contain 1 xml file, and then
> may contain any arbitrary files. As a specialised file format is a
> pretty general case ;-) Because of compression, xdeltas of the zipfiles
> aren't good. So what I want to do is to diff the 2 unzipped directories
> - nothing git-specific, I could use diff -urN.
>
> Git diff *is* better in that it handles binary files, but we pay a
> sizable cost in being reversible.

Did I forget to say that I am Ok with --oneway option?

In fact, we started as oneway but we _fixed_ it to make it
reversible soon after the initial version ;-)  So "git apply"
still can grok oneway format.
