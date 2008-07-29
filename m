From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve the placement of core.trustctime in the
 documentation
Date: Mon, 28 Jul 2008 23:23:42 -0700
Message-ID: <7vmyk1ky35.fsf@gitster.siamese.dyndns.org>
References: <20080723164614.GB5283@blimp.local>
 <alpine.DEB.1.00.0807231757550.8986@racer>
 <20080723191647.GF5283@blimp.local>
 <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org>
 <20080725055547.GA3699@blimp.local>
 <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness>
 <20080726153802.GA16868@blimp.local>
 <7v1w1f155p.fsf@gitster.siamese.dyndns.org>
 <20080728063128.GA4234@blimp.local> <20080728162043.GG32184@machine.or.cz>
 <20080728214716.GB3721@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 08:24:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNidl-0002XS-Kf
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 08:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbYG2GXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 02:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbYG2GXx
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 02:23:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbYG2GXw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 02:23:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 684F9435DC;
	Tue, 29 Jul 2008 02:23:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 75776435D8; Tue, 29 Jul 2008 02:23:44 -0400 (EDT)
In-Reply-To: <20080728214716.GB3721@blimp.local> (Alex Riesen's message of
 "Mon, 28 Jul 2008 23:47:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E944177A-5D36-11DD-AB94-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90591>

Alex Riesen <raa.lkml@gmail.com> writes:

> Accidentally, it split a _chapter_ about a file data corrup...
> conversion for a weird, but common operating system.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> Petr Baudis, Mon, Jul 28, 2008 18:20:43 +0200:
>> On Mon, Jul 28, 2008 at 08:31:28AM +0200, Alex Riesen wrote:
>> > diff --git a/Documentation/config.txt b/Documentation/config.txt
>> > index 1a13abc..552c134 100644
>> > --- a/Documentation/config.txt
>> > +++ b/Documentation/config.txt
>> > @@ -149,6 +149,13 @@ core.safecrlf::
>> >  	`core.autocrlf`, git will reject the file.  The variable can
>> >  	be set to "warn", in which case git will only warn about an
>> >  	irreversible conversion but continue the operation.
>> > +
>> > +core.trustctime::
>> > +	If false, the ctime differences between the index and the
>> > +	working copy are ignored; useful when the inode change time
>> > +	is regularly modified by something outside Git (file system
>> > +	crawlers and some backup systems).
>> > +	See linkgit:git-update-index[1]. True by default.
>> >  +
>> >  CRLF conversion bears a slight chance of corrupting data.
>> >  autocrlf=true will convert CRLF to LF during commit and LF to
>> 
>> Somehow, this particular position of the new hunk does not feel like the
>> best choice. ;-)
>> 
>
> It's alphabetical. Why? Oh, shit... Screw alphabetical

Yeah, I think it makes sense to put this after core.filemode.
