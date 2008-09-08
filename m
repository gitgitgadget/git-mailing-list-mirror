From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternates and push
Date: Sun, 07 Sep 2008 19:53:42 -0700
Message-ID: <7vljy3ic09.fsf@gitster.siamese.dyndns.org>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com>
 <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org>
 <20080907234118.GA8161@mit.edu> <7vd4jfjyiq.fsf@gitster.siamese.dyndns.org>
 <20080908004137.GB8161@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Sep 08 04:55:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcWu7-000661-Us
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 04:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbYIHCx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 22:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbYIHCx5
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 22:53:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40436 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbYIHCx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 22:53:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 196B35FF0A;
	Sun,  7 Sep 2008 22:53:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5ACFE5FF09; Sun,  7 Sep 2008 22:53:52 -0400 (EDT)
In-Reply-To: <20080908004137.GB8161@mit.edu> (Theodore Tso's message of "Sun,
 7 Sep 2008 20:41:37 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 60CC30E0-7D51-11DD-A739-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95208>

Theodore Tso <tytso@MIT.EDU> writes:

>> The arguments to make are "Junio is worrying too much; depending on the
>> other repository's ref is no worse than depending on the objects the other
>> repository uses, and here is a proof that it is not just 'not a big deal'
>> but 'no problem at all'", "I've polled the userbase and there is no
>> existing configuration that will be broken by this change", and "I have
>> this configuration that will be broken by above change, don't do it".
>
> So the only configuration I can think of that would be broken by this
> is where $D/refs exists, but is insane.  (i.e., such that git fsck for
> $D would result in errors).  That seems pretty unlikely...

I was more worried about "once $D/ started its life as an actively used
and maintained repository, but it itself has been abandoned and its refs
are not maintained anymore; only $D/objects are still in use", but even in
that case, it won't be "$D/refs exists but insane" case, so we should be
Ok.
