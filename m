From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] Clarify documentation of git-cvsserver, particularly in
 relation to git-shell
Date: Wed, 16 Apr 2008 13:03:40 -0700
Message-ID: <7vhce1pnxf.fsf@gitster.siamese.dyndns.org>
References: <39292ba40804151233k2dd9300as5611e65ab6fcd81d@mail.gmail.com>
 <1208295883-19599-1-git-send-email-scc@ScottCollins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Collins <scc@ScottCollins.net>
X-From: git-owner@vger.kernel.org Wed Apr 16 22:24:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmDsG-0000su-K7
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065AbYDPUEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 16:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753554AbYDPUEB
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:04:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbYDPUEA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 16:04:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B7BDE39EB;
	Wed, 16 Apr 2008 16:03:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0A58139E9; Wed, 16 Apr 2008 16:03:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79742>

Scott Collins <scc@ScottCollins.net> writes:

> For SSH clients restricted to git-shell, CVS_SERVER does not have to be
> specified, because git-shell understands the default value of 'cvs' to
> mean git-cvsserver'. This makes it totally transparent to CVS users, but
> the instruction to set up CVS access for people with real shell access
> does not apply.

Thanks.  I was only _guessing_ that the reasoning behind the "cvs" hack in
git-shell was to allow a vanilla "cvs over ssh" to work transparently
without trying, but it appears to work exactly that way.

>
> Note that the .ssh/environment file is a good place to set these, and that
> the .bashrc is shell-specific. Add a bit of text to differentiate cvs -d
> (setting CVSROOT) from cvs co -d (setting the name of the newly checked
> out directory).  Removed an extra 'Example:' string.

Suggesting .ssh/environment as an alternative is a good idea, but not
everybody's sshd pays attention to it, so the user still needs to learn
how to drive his or her ssh environment.  But this document is not a
troubleshooting guide for ssh, so let's not go there too much.  I think
your description is fine.
