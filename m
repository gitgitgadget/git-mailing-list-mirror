From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding Reviewed-by/Tested-by tags to other peoples commits
Date: Sat, 11 Oct 2008 14:18:43 -0700
Message-ID: <7v7i8ekez0.fsf@gitster.siamese.dyndns.org>
References: <b2cdc9f30810102337q13432bepa957acaace9ddc5d@mail.gmail.com>
 <alpine.DEB.1.00.0810111239590.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vfxn3jqt9.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810111457300.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 11 23:20:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kolt9-0003Zu-Tq
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 23:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbYJKVT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 17:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbYJKVT2
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 17:19:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbYJKVT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 17:19:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4F6256DFD5;
	Sat, 11 Oct 2008 17:19:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 131A96DFC3; Sat, 11 Oct 2008 17:18:46 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0810111457300.22125@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Sat, 11 Oct 2008 15:06:48 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4854333E-97DA-11DD-916D-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97989>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Color me puzzled.  You said in another mail that you think this is the 
> task for the MUA.

Not really.  I said that I think people usually do this in MUA with the
current system.  I did not mean to say that I think such a partition of
jobs between commit and MUA is ideal.

>> This is a bit tangent, but perhaps rebase needs a hook so that users can 
>> strip certain tags automatically from the commit log messages (e.g. 
>> things like Reviewd-by: and Tested-by: become less trustworthy when you 
>> rebase; S-o-b: becomes somewhat less trustworthy when you "edit" in 
>> rebase-i; etc).
>
> Maybe.  I am not really convinced of the S-o-b.  You kept stressing that 
> the SOB is not about validity, but a statement that the patch is 
> intellectually proper or some such (IOW it means something like "Darl, 
> forget it").  And the point of origin does not change, even if you rebase 
> the commit.

The "somewhat less trustworthy" kicks in when you "edit" in rebase-i if
you change the tree that gets recorded.  You are right that it is
irrelevant if you ran rebase-i to only edit the commit log message.
