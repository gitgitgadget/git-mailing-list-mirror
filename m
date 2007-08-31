From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] filter-branch: introduce convenience function "skip_commit"
Date: Fri, 31 Aug 2007 14:32:28 -0700
Message-ID: <7vzm07wftf.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0708312005420.28586@racer.site>
	<20070831191921.GB2151@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.64.0708312204490.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRE6Z-0005Aj-EW
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966369AbXHaVcf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966360AbXHaVcf
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:32:35 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966336AbXHaVce (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:32:34 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E4E9912BEF8;
	Fri, 31 Aug 2007 17:32:51 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0708312204490.28586@racer.site> (Johannes
	Schindelin's message of "Fri, 31 Aug 2007 22:05:40 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57219>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Fri, 31 Aug 2007, Karl Hasselstr?m wrote:
>
>> On 2007-08-31 20:06:27 +0100, Johannes Schindelin wrote:
>> 
>> > It does _not_ undo the changeset corresponding to that commit, but
>> > it _skips_ the revision. IOW its ancestors' tree objects remain the
>> > same.
>> 
>> While this is true too, I'm guessing you intended to say that its
>> _descendants'_ tree objects remain the same. Right?
>
> Right.  So how about:
>
> IOW no tree objects are changed by this.

Ok, will amend.
