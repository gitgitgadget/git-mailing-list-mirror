From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Wed, 11 Jun 2008 16:01:52 -0700
Message-ID: <7v3anjbmov.fsf@gitster.siamese.dyndns.org>
References: <484F2174.9020508@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Rene Herman <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Thu Jun 12 01:03:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ZLJ-0007Yi-An
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 01:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbYFKXCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 19:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbYFKXCA
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 19:02:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbYFKXB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 19:01:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8BE66485D;
	Wed, 11 Jun 2008 19:01:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 07ABA485C; Wed, 11 Jun 2008 19:01:53 -0400 (EDT)
In-Reply-To: <484F2174.9020508@keyaccess.nl> (Rene Herman's message of "Wed,
 11 Jun 2008 02:51:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 63C40C78-380A-11DD-A87F-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84678>

Rene Herman <rene.herman@keyaccess.nl> writes:

> Good day.
>
> The manpages seem to be making somewhat of a point of mentioning "git
> pull . <branch>" as the way to merge a local branch into the current
> one but a simple "git merge <branch>" seems to work well. Is there a
> difference?

There isn't any.

"git pull . this_branch" is just a natural and logical consequence that
you can fetch and merge a branch B from remote U with "git pull $U $B".

"git merge that_branch" exists and useful because people on average merge
local branches more than they fetch and merge from remote repository.
