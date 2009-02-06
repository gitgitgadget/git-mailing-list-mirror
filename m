From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 06 Feb 2009 00:12:41 -0800
Message-ID: <7vprhw6l1i.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902060530450.10279@pacific.mpi-cbg.de>
 <Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain>
 <buobptg6tek.fsf@dhlpc061.dev.necel.com>
 <7vfxis86tp.fsf@gitster.siamese.dyndns.org>
 <buor62c3yin.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gyles19@visi.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 06 09:14:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVLqr-000123-9Z
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 09:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbZBFIMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 03:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbZBFIMv
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 03:12:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55079 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbZBFIMu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 03:12:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BFB2D2A8B9;
	Fri,  6 Feb 2009 03:12:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C87252A893; Fri, 
 6 Feb 2009 03:12:43 -0500 (EST)
In-Reply-To: <buor62c3yin.fsf@dhlpc061.dev.necel.com> (Miles Bader's message
 of "Fri, 06 Feb 2009 14:49:52 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F1250EFA-F425-11DD-AA1C-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108663>

Miles Bader <miles@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>>>> Because there is no configure script provided, and because my autoconf
>>>> is considered too old, I simply can't start the build process because
>>>> I can't generate the missing configure script.
>>>
>>> Er, why don't you upgrade to a less ancient version of autoconf...?
>>
>> Please do not encourage the use of configure/autoconf unnecessarily.
>
> Huh?  I'm not "encouraging the use of configure/autoconf unnecessarily",
> I'm encouraging the use of a non-obsolete version of autoconf, should he
> wish to use it (and he's the one that brought it up, so...).
>
>> Use of configure is tolerated, not encouraged.
>
> You're certainly welcome to discourage people from using it, but I see
> no reason to do so myself.

Hmm, after reading my message again, I did sound rather misleading to
solicit a response like that from a gnu person, so let me try again.

Please do not encourge use of configure/autoconf *in this project*.

Use of configure *in this project* is not encouraged, it is merely
tolerated.

You are of course welcome to use configure and autoconf yourself for your
own projects, not here, but that goes without saying, I would think.
