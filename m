From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] Draft of API for git-vcs-*, transport.c code to use
 it.
Date: Wed, 25 Mar 2009 10:42:58 -0700
Message-ID: <7vocvp7b31.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903242303410.19665@iabervon.org>
 <7vskl284bt.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0903251050430.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 18:44:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmX9f-0002iX-Bv
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 18:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764010AbZCYRnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 13:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763994AbZCYRnH
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 13:43:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763935AbZCYRnG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 13:43:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A5616A599E;
	Wed, 25 Mar 2009 13:43:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AF606A599D; Wed,
 25 Mar 2009 13:43:00 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0903251050430.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 25 Mar 2009 12:20:13 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 64385FCE-1964-11DE-ACFD-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114626>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> > +'import'::
>> > +	Takes the remote name and a list of names of refs, and imports
>> > +	whatever it describes, by outputting it in git-fast-import
>> > +	format.
>> > +
>> > +'export'::
>> > +	Sends the branch to the foreign system and reimports it in
>> > +	fast-import format.
>> 
>> The above two description is inconsistent; say "git-fast-import" for both.
>
> Not "fast-import" for both, now that other systems have adopted the format 
> as input?

I did not mean anything deeper than just pointing out that one sentence
calls the format "git-fast-import format" and the other one calls
"fast-import format".
