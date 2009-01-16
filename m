From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2009, #03; Wed, 14)
Date: Fri, 16 Jan 2009 00:21:53 -0800
Message-ID: <7vd4enacf2.fsf@gitster.siamese.dyndns.org>
References: <7vmydu3yy7.fsf@gitster.siamese.dyndns.org>
 <20090115194926.GA6899@roro3.zxlink>
 <7vd4eos3rp.fsf@gitster.siamese.dyndns.org>
 <20090116080807.GA10792@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Fri Jan 16 09:23:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNjzH-0008Rr-8I
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 09:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038AbZAPIWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 03:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756015AbZAPIWF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 03:22:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbZAPIWD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 03:22:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AB3909030D;
	Fri, 16 Jan 2009 03:21:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DC8B09030C; Fri,
 16 Jan 2009 03:21:55 -0500 (EST)
In-Reply-To: <20090116080807.GA10792@landau.phys.spbu.ru> (Kirill Smelkov's
 message of "Fri, 16 Jan 2009 11:08:08 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BE3F82D4-E3A6-11DD-B4E3-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105927>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> On Thu, Jan 15, 2009 at 12:39:06PM -0800, Junio C Hamano wrote:
> ...
>> So please either say "Yes, you are welcome to cherry-pick -- fetching and
>> cherry-picking would be easier than e-mail for this kind of patch", or
>> "Ok, I'll rebase my series on top of ddfb369".
>> 
>> Well, I just noticed that some of your commits already conflict with the
>> two patches that I already have, so I guess we would need at least one
>> rebase anyway, so this time around, I'd really prefer you not to say "you
>> are welcome to cherry-pick" ;-)
>
> Sure, I've rebased my series on top of ddfb369 :)
>
>     git://repo.or.cz/git/kirr.git   for-junio-maint
>
>
> Kirill Smelkov (3):
>       mailinfo: more smarter removal of rfc822 comments from 'From'
>       mailinfo: add explicit test for mails like '<a.u.thor@example.com> (A U Thor)'
>       mailinfo: tests for RFC2047 examples

Thanks.

I thought there is somebody on this list who insists his name is of form:

	From: A U Thor (MonikeR) <a.u@thor.xz>

and vaguely recall the current code was tweaked to keep that extra moniker
in his (or her?) name.  It is too late at night for me to double check but
I suspect the first one in the series may break things for that kind of
names.
