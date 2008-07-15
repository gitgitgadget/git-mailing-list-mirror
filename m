From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Closing the merge window for 1.6.0
Date: Tue, 15 Jul 2008 11:51:35 -0700
Message-ID: <7v3amb0ymg.fsf@gitster.siamese.dyndns.org>
References: <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
 <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
 <7vzlokhpk7.fsf@gitster.siamese.dyndns.org>
 <20080714085555.GJ32184@machine.or.cz>
 <alpine.DEB.1.00.0807141256310.8950@racer>
 <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org>
 <alpine.LFD.1.10.0807141351540.12484@xanadu.home>
 <7v3amcgujd.fsf@gitster.siamese.dyndns.org>
 <20080715092023.GO10151@machine.or.cz>
 <20080715150626.GA2925@dpotapov.dyndns.org>
 <alpine.DEB.1.00.0807151623120.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Nicolas Pitre <nico@cam.org>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 15 20:52:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIpdp-0001A7-5v
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 20:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617AbYGOSvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 14:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754948AbYGOSvt
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 14:51:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbYGOSvs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 14:51:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 109C031B1C;
	Tue, 15 Jul 2008 14:51:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 13C2C31B1B; Tue, 15 Jul 2008 14:51:37 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1241B17A-529F-11DD-B9CF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88587>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 15 Jul 2008, Dmitry Potapov wrote:
>
>> Those repos that think that access for Git 1.4 users is important for 
>> them can set indexformat=1.
>
> Unfortunately, you place quite a high maintenance burden on the repository 
> maintainers here.
>
> From the time balance sheet, it does not look good at all: a few minutes 
> for Junio to change and commit, up to a few hours (because they missed it 
> in the release notes) for probably more than hundred repository 
> maintainers that are not subscribed to the Git mailing list.
>
> And I absolutely agree with Pasky that this does _nothing_ in the vague 
> direction of wielding a reputation of being easy to use.
>
> Sure, we can make it easy on ourselves.  And it is just as easy to make it 
> hard on others.  If you're okay with that, I am not.

I was not planning to comment on this issue further as the ball is in
Debian's court, but I think you are misguided.

We are not making anything hard on others.  Sticking to 1.4.4.4 codebase
is forced by Debian (for its policy) and choice made by its users (for not
knowing or using backports).  1.5.0 and later are vastly better and we
encourage users to update on every occassion we get.

I do not know the extent of the backporting effort necessary, the size of
potentially impacted population if Debian keeps shipping unpatched
1.4.4.4, nor how much Debian cares about supporting their 1.4.4.4 users
i.e. if they are willing and able to carry distro-only forward
compatibility patches, and knowing all of these is necessary before we
declare this is worth handling _ourselves_.  That is why I did not want to
take a definitive stance on this issue before hearing from the Debian
maintainer about them -- I said "Debian has to ask with list of items",
didn't I?

What troubles me the most is that you seem to be forgetting that we are
using git to manage our codebase.  Even if this turns out to be something
we would want to handle ourselves, it does not have to come from me.  If
you care that much, you could backport whatever change is appropriate to
keep 1.4.4.X codebase alive and arrange it to be published as 1.4.4.5.

In any case, it will _definitely_ *NOT* a few minutes of me nor anybody.
Release engineering takes quite a lot of time.
