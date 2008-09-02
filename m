From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-update-index -q
Date: Tue, 02 Sep 2008 13:23:27 -0700
Message-ID: <7vsksijo00.fsf@gitster.siamese.dyndns.org>
References: <quack.20080902T1051.lth1w02mo5l@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Tue Sep 02 22:24:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KacQZ-0003Mp-D7
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 22:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbYIBUXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 16:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbYIBUXe
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 16:23:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbYIBUXd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 16:23:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B7EA87116E;
	Tue,  2 Sep 2008 16:23:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B04877116D; Tue,  2 Sep 2008 16:23:29 -0400 (EDT)
In-Reply-To: <quack.20080902T1051.lth1w02mo5l@roar.cs.berkeley.edu> (Karl
 Chen's message of "Tue, 02 Sep 2008 10:51:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 03544A10-792D-11DD-AAA0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94703>

Karl Chen <quarl@cs.berkeley.edu> writes:

> The git-update-index man page entry for -q says:
>
>        -q
>            Quiet. If --refresh finds that the index needs an
>            update, the default behavior is to error out. This
>            option makes git-update-index continue anyway.
>
> Can someone explain this to me?  As far as I can tell,
> git-update-index without -q does not error out after the first
> update.

: gitster j; git init
Initialized empty Git repository in /var/tmp/j/.git/
: gitster j/master; >afile; git update-index --add afile
: gitster j/master; echo a >afile
: gitster j/master; git update-index --refresh; echo $?
afile: needs update
1
: gitster j/master; git update-index -q --refresh; echo $?
0
: gitster j/master; exit
