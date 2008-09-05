From: Junio C Hamano <gitster@pobox.com>
Subject: Re: file deletion in index lost after checkout -b
Date: Thu, 04 Sep 2008 23:12:26 -0700
Message-ID: <7vljy7xgs5.fsf@gitster.siamese.dyndns.org>
References: <20080901034414.GR6619@jabba.hq.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 08:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbUZi-0004cB-0R
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 08:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbYIEGMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 02:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbYIEGMf
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 02:12:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbYIEGMf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 02:12:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DA58074937;
	Fri,  5 Sep 2008 02:12:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AF4A874936; Fri,  5 Sep 2008 02:12:30 -0400 (EDT)
In-Reply-To: <20080901034414.GR6619@jabba.hq.digizenstudio.com> (Jing Xue's
 message of "Sun, 31 Aug 2008 23:44:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A11A1384-7B11-11DD-B286-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94994>

Jing Xue <jingxue@digizenstudio.com> writes:

[jc: please redirect an answer _meant for you_ off to the list with M-F-T header]

> In Git 1.6.0 the following sequence:
> ...
> The deletion of 2.txt appears lost during 'checkout -b foo', while the
> modification and addition were both brought over. Is it a bug?

This behaviour is unchanged since early June 2005.

    http://thread.gmane.org/gmane.comp.version-control.git/4641/focus=4646

This is exactly the case marked as *0*, which both Linus and I said "it
feels somewhat wrong but otherwise we cannot start from an empty index".

We may want to do better this time around, though.
