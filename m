From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn: Protect against "diff.color = true".
Date: Fri, 31 Aug 2007 15:14:06 -0700
Message-ID: <7vps13wdw1.fsf@gitster.siamese.dyndns.org>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
	<7vveav21uv.fsf@gitster.siamese.dyndns.org>
	<20070831152153.GA30745@muzzle>
	<7v4pifzawc.fsf@gitster.siamese.dyndns.org>
	<7v4pifxuia.fsf_-_@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0708312237340.28586@racer.site>
	<7vtzqfwf5c.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0708312251510.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Robert Newson <robert.newson@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 01 00:14:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IREl8-0006Br-UD
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 00:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbXHaWON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 18:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbXHaWOM
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 18:14:12 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44380 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbXHaWOM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 18:14:12 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B110812C019;
	Fri, 31 Aug 2007 18:14:29 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0708312251510.28586@racer.site> (Johannes
	Schindelin's message of "Fri, 31 Aug 2007 22:53:08 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57227>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 31 Aug 2007, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> ...
>> > I just tested on a busybox clone: Works as expected.  Without your patch, 
>> > I get the uninitialised values, with your patch it is fine.
>> >
>> > ACK.
>> 
>> Thanks.
>> 
>> It's customary that the privilege to issue Ack is reserved to
>> the primary owner of the code.  We are a relatively small
>> friendly community and it is not a big deal, but if you ever
>> work on the kernel, be somewhat more careful.  People are picky
>> over there on such details.
>
> Happily, we are a much friendlier bunch here ;-)
>
> Besides, since I feel we're really close to 1.5.3 now, I thought that you 
> might want to here as many positive votes as you can get.
>
> But yes, I'll keep that in mind ;-)

Oh, I did not mean to sound like your testing does not count.  I
was just cautioning about using the word "Ack".

I will have a "Tested-by: " line with your name on it, and I am
hoping I can get an Ack from Eric but it is such an "obviously
correct" looking change, so ...
