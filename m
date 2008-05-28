From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry picking changesets instead of commits
Date: Wed, 28 May 2008 11:19:56 -0700
Message-ID: <7v1w3muw8j.fsf@gitster.siamese.dyndns.org>
References: <7f9d599f0805281106w746a0469u6c483d64cf75b823@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Geoffrey Irving" <irving@naml.us>
X-From: git-owner@vger.kernel.org Wed May 28 20:21:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1QGg-0000AZ-7M
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 20:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbYE1SUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 14:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbYE1SUE
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 14:20:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbYE1SUD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 14:20:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C45552D5;
	Wed, 28 May 2008 14:20:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BB56B52D4; Wed, 28 May 2008 14:19:58 -0400 (EDT)
In-Reply-To: <7f9d599f0805281106w746a0469u6c483d64cf75b823@mail.gmail.com>
 (Geoffrey Irving's message of "Wed, 28 May 2008 11:06:10 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AFB3810A-2CE2-11DD-A27D-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83121>

"Geoffrey Irving" <irving@naml.us> writes:

> Would it be straightforward
> to add an option to "git cherry" to ignore differences in metadata?
> The cherry documentation doesn't give its criteria for when commits
> match, and I'm not familiar enough with the code yet to figure out
> those criteria directly from cmd_cherry in builtin-log.c.

cherry does not look at metadata at all.  It compares patch-ids.
