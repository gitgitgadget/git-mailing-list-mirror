From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: grafts generalised
Date: Wed, 02 Jul 2008 17:28:50 -0700
Message-ID: <7vy74j6cal.fsf@gitster.siamese.dyndns.org>
References: <20080702143519.GA8391@cuci.nl>
 <20080703001331.GF12567@machine.or.cz> <20080703001614.GG12567@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 03 02:30:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEChx-00054Y-Qx
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 02:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbYGCA3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 20:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbYGCA3A
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 20:29:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbYGCA27 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 20:28:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 39752A29C;
	Wed,  2 Jul 2008 20:28:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 946E1A298; Wed,  2 Jul 2008 20:28:52 -0400 (EDT)
In-Reply-To: <20080703001614.GG12567@machine.or.cz> (Petr Baudis's message of
 "Thu, 3 Jul 2008 02:16:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0632B2B0-4897-11DD-B243-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87212>

Petr Baudis <pasky@suse.cz> writes:

> On Thu, Jul 03, 2008 at 02:13:31AM +0200, Petr Baudis wrote:
>>   So, the real solution is to take the commit objects you want to
>> modify, create new commit objects, then graft the new commit on all the
>> old commit children. It fits neatly in the Git philosophy, there is no
>> need at all to tweak the current infrastructure for this and it should
>> be trivial to automate, too.
>
>   Oops, sorry; I stopped reading the branch of the thread I thought was
> going off on a different tangent one post too early. :-)

What you wrote was a very good summary of what Dmitry suggested earlier
;-)
