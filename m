From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2008, #02; Sun, 14)
Date: Mon, 15 Dec 2008 17:42:47 -0800
Message-ID: <7vr648uc88.fsf@gitster.siamese.dyndns.org>
References: <7v7i632mg9.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0812151423390.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Dec 16 02:44:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCOyq-0002VY-Dh
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 02:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbYLPBmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 20:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbYLPBmy
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 20:42:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbYLPBmx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 20:42:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 79A0F1A5C5;
	Mon, 15 Dec 2008 20:42:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 532681A5BD; Mon,
 15 Dec 2008 20:42:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DA6483F8-CB12-11DD-8002-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103232>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sun, 14 Dec 2008, Junio C Hamano wrote:
>
>> [On Hold]
>> 
>> * nd/narrow (Sun Nov 30 17:54:38 2008 +0700) 17 commits
>>  - wt-status: show sparse checkout info
>>  - Introduce default sparse patterns (core.defaultsparse)
>>  - checkout: add new options to support sparse checkout
>>  - clone: support sparse checkout with --sparse-checkout option
>>  - unpack_trees(): add support for sparse checkout
>>  - unpack_trees(): keep track of unmerged entries
>>  - Introduce "sparse patterns"
>>  - Merge branch 'master' into nd/narrow
>>  + t2104: touch portability fix
>>  + grep: skip files outside sparse checkout area
>>  + checkout_entry(): CE_NO_CHECKOUT on checked out entries.
>>  + Prevent diff machinery from examining worktree outside sparse
>>    checkout
>
> I think this patch (slightly reframed) would be good to have independantly 
> of the series; it also means that we won't do weird things if someone 
> changes a file in the worktree which is marked as CE_VALID, and may well 
> may CE_VALID sufficient for the index representation of paths outside the 
> checkout.

It is a bit unclear which one you meant by "this patch", sorry.
