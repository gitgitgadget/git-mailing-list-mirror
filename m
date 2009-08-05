From: Junio C Hamano <gitster@pobox.com>
Subject: Re: The XZ patch?
Date: Wed, 05 Aug 2009 11:31:31 -0700
Message-ID: <7vhbwm5czg.fsf@alter.siamese.dyndns.org>
References: <5F7EF736-9D0B-4455-A0F7-E7314B4F29E4@uwaterloo.ca>
 <4A795790.9010805@op5.se> <m3zlaepl8v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Mark A Rada <marada@uwaterloo.ca>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:33:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYlIX-00005j-L5
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbZHESbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbZHESbp
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:31:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbZHESbo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:31:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A06D01EE29;
	Wed,  5 Aug 2009 14:31:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F31171EE24; Wed,  5 Aug 2009
 14:31:33 -0400 (EDT)
In-Reply-To: <m3zlaepl8v.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Wed\, 05 Aug 2009 04\:12\:53 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3999781E-81EE-11DE-A606-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124946>

Jakub Narebski <jnareb@gmail.com> writes:

> Andreas Ericsson <ae@op5.se> writes:
>
>> Mark A Rada wrote:
>> >
>> > I was wondering what the fate of my XZ patch was (I didn't do
>> > something dumb, did I?). Never got a response after my last
>> > submit.
>
> I'm sorry, I didn't reply to the last version, did I? I liked both
> patches
>  
>> No comments usually meant noone cared enough about the implemented
>> feature to comment on it. Personally, I'd never use a compression
>> algorithm that hogs as much memory as XZ does. "Good enough" really
>> is just that, imo, and bzip2 and gzip are widely available pretty
>> much everywhere, whereas I've never heard of XZ before.
>
> Well, there were two patches in last series, and I'd rather liked the
> one that decoupled list of _known_ snapshot formats from the list of
> snapshot formats projects are _allowed to use_, when project specific
> override for 'snapshot' feature is turned on.  So for example one can
> allow project specific override (so projects can chose whether to have
> snapshot, and what formats to use) but for example disable chosing
> 'tbz' (bzip2 compression) or 'txz' (XZ / LZMA2 compression) formats.

I kind of liked the generic "disabling" support, even though I was
uninterested in adding xz or any other formats.  Perhaps it is more useful
if the patches were in reverse order.  First allow site administrators to
selectively disable the current set of formats, with documentation updates
for that feature, then finally add xz.
