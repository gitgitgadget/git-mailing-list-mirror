From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (Sep 2008, #02; Wed, 10)
Date: Thu, 11 Sep 2008 15:02:19 -0700
Message-ID: <7v8wtys5n8.fsf@gitster.siamese.dyndns.org>
References: <7viqt3tk8b.fsf@gitster.siamese.dyndns.org>
 <48C8E061.5030904@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Sep 12 00:03:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KduGE-0005p0-Aw
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 00:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbYIKWC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 18:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbYIKWC0
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 18:02:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbYIKWCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 18:02:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8AE797C125;
	Thu, 11 Sep 2008 18:02:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C0D6E7C121; Thu, 11 Sep 2008 18:02:21 -0400 (EDT)
In-Reply-To: <48C8E061.5030904@fastmail.fm> (Michael J. Gruber's message of
 "Thu, 11 Sep 2008 11:09:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 50B0DE96-804D-11DD-8EFA-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95654>

Michael J Gruber <michaeljgruber+gmane@fastmail.fm> writes:

> I think the cleanest approach would consist in introducing another
> linkgit macro (for everything linkgit:git-) which ouputs dashed resp.
> dashless forms for docbook (i.e. man) resp. html targets. I'll cook up a
> POC if noone keeps me from doing so ;)

I personally think the links are Ok to be left as they are in git-foo form
but if there is a good way to persuade manual viewers to display "git foo"
and still follow "man git-foo", that would be great.

Names of the programs in "git-foo" form in the plain text, unless they are
the server side programs, should be updated to say "git foo"
(cf. http://thread.gmane.org/gmane.comp.version-control.git/95436/focus=95443)
