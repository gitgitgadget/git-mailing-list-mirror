From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC variant 2 of 2] "needs update" considered harmful
Date: Sun, 20 Jul 2008 12:29:33 -0700
Message-ID: <7v4p6k73s2.fsf@gitster.siamese.dyndns.org>
References: <7vtzelf4mf.fsf@gitster.siamese.dyndns.org>
 <7v7ibhdmii.fsf@gitster.siamese.dyndns.org>
 <20080720112957.GE32184@machine.or.cz>
 <alpine.DEB.1.00.0807201435450.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 21:30:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKecD-0008Op-KN
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 21:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbYGTT3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 15:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbYGTT3l
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 15:29:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbYGTT3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 15:29:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 747EC2F467;
	Sun, 20 Jul 2008 15:29:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C328A2F465; Sun, 20 Jul 2008 15:29:35 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807201435450.3305@eeepc-johanness> (Johannes
 Schindelin's message of "Sun, 20 Jul 2008 14:41:25 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31F99842-5692-11DD-9228-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89219>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 20 Jul 2008, Petr Baudis wrote:
>
>> Scripts need to be modified for the reorganization anyway,
>
> No.  They do not, if the 1st variant is applied.

I think Pasky's point is that people who did not bother updating their
scripts with PATH=$(git --exec-path):$PATH as described in the deprecation
notice when we went 1.5.4 now have to do so.

But if they did, they have to update again.  The more elaborate variant
avoids that, at the expense of different wordings between Porcelain and
plumbing.

I personally think there is nothing wrong if Porcelain and plumbing use
different languages, by the way.  It seems that the general concensus will
be to split the Porcelain and the plumbing manuals into separate volumes
targetted for different audiences, and it is more important to keep the
plumbing output stable as part of an established API than making the same
thing called using the same wording in different languages.
