From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Fri, 27 Jun 2008 15:11:34 -0700
Message-ID: <7vabh6plyh.fsf@gitster.siamese.dyndns.org>
References: <7vprq4u66i.fsf@gitster.siamese.dyndns.org>
 <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer>
 <486220CE.3070103@viscovery.net> <alpine.DEB.1.00.0806251334060.9925@racer>
 <20080625135100.GF20361@mit.edu> <7v63rx2zwf.fsf@gitster.siamese.dyndns.org>
 <20080625195003.GB15077@mit.edu>
 <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com>
 <20080625203822.GA7827@mit.edu> <7v8wwtz1c1.fsf@gitster.siamese.dyndns.org>
 <20080625210535.GA8610@mit.edu> <7vod5pxknh.fsf@gitster.siamese.dyndns.org>
 <20080627193325.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Theodore Tso <tytso@mit.edu>, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 00:13:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCMBg-00028w-0c
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346AbYF0WMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757986AbYF0WMB
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:12:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbYF0WMA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:12:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AA258D553;
	Fri, 27 Jun 2008 18:11:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5AE17D54E; Fri, 27 Jun 2008 18:11:46 -0400 (EDT)
In-Reply-To: <20080627193325.6117@nanako3.lavabit.com> (nanako3@lavabit.com's
 message of "Fri, 27 Jun 2008 19:33:25 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0E4F4436-4496-11DD-9413-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86665>

 しらいしななこ <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> > Theodore Tso <tytso@mit.edu> writes:
>> > ...
>> >> Stupid quesiton --- where is this documented?  I don't see this
>> >> documented either in the man page for git or git-checkout.
>> >
>> > You are asking a wrong person.  My git knowledge mostly comes from
>> > yearlong reading of the mailing list articles, and doing a bit myself also
>> > helps ;-).
>> 
>> I couldn't find a good central place to place this as this is more or less
>> used consistently throughout the UI (log, diff, grep, and then I just
>> fixed reset as well).
>> 
>> Whereever the description should end up to be in, here is what I think we
>> should talk about.
>
> Because it is where the convention that is used in all of the UI is
> described, I think gitcli documentation is an appropriate place.

I am still not convinced it is the best place but I guess it would be
better than not documenting it anywhere.

> Don't you also want to talk about distinction between --cached and
> --index that new people are often confused about?  These options are
> defined consistently across commands but people who do not know it bring
> up discussions to rename --cached to some commands to --index to make it
> inconsistent and waste your time every once in a while.
