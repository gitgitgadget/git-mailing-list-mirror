From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 16:14:09 -0700
Message-ID: <7viqvuo4hq.fsf@gitster.siamese.dyndns.org>
References: <g43jlg$54g$1@ger.gmane.org> <-8386235276716376372@unknownmsgid>
 <9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David Jeske" <jeske@willowmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Robert Anderson" <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 01:15:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCNAB-0001n4-GG
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 01:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbYF0XO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 19:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbYF0XO2
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 19:14:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458AbYF0XO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 19:14:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EA784E276;
	Fri, 27 Jun 2008 19:14:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4A830E273; Fri, 27 Jun 2008 19:14:18 -0400 (EDT)
In-Reply-To: <9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com>
 (Robert Anderson's message of "Fri, 27 Jun 2008 15:55:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C872E4B4-449E-11DD-9739-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86674>

"Robert Anderson" <rwa000@gmail.com> writes:

> There are good reasons for desiring a workflow that does not routinely
> change history as part of the usual workflow.  Maybe there are clones
> of your repo.  Maybe as part of your workflow discipline you do not
> want HEAD states that cannot be pushed to public, because you don't
> want to manually keep track of when it is ok and when it is not ok to
> push HEAD to public, since git cannot tell you this.

Surely you can arrange that.  You keep track of what you pushed out, and
you refrain from rebasing beyond that point.

And fast-forward check in the push to the public will notice if you break
that "workflow discipline" by accident.
