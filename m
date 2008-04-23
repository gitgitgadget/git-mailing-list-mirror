From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Moving "git remote add --mirror blah" functionality to
 "git clone --bare --origin=blah"
Date: Wed, 23 Apr 2008 15:02:41 -0700
Message-ID: <7vtzhsqlfi.fsf@gitster.siamese.dyndns.org>
References: <480EF334.1090907@gnu.org>
 <7vhcdstv0f.fsf@gitster.siamese.dyndns.org> <480F96A8.6020304@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Apr 24 00:03:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jon42-0007bW-Ap
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 00:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbYDWWC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 18:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbYDWWC4
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 18:02:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbYDWWCz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 18:02:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 65DC43BA3;
	Wed, 23 Apr 2008 18:02:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B613D3BA1; Wed, 23 Apr 2008 18:02:49 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80265>

Paolo Bonzini <bonzini@gnu.org> writes:

> It seems useless to have an option in "git remote add" just because it
> might be necessary in a future refactoring of "git clone", but without
> a good use case beside that one.

Ooo.  But I think that's the other way around.  It was prepared for that
purpose but people never followed through.  Check the archive around
commit 3894439 (Teach "git remote" a mirror mode, 2007-09-02).

> --mirror" is close to useless: anyone who needs it 99% of the time
> knows how to hack the config...

Eh, in that sense, "git remote" itself is useless, isn't it?  I have to
say that this particular point of your argument does not give us any new
or interesting insight to work from.

As I already said, I think "push to backup" option would be useful.  It
just cannot take over --mirror option, which means something different.
