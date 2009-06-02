From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cygwin: Initial clone of repo containing .gitattributes has modified files
Date: Tue, 02 Jun 2009 08:50:56 -0700
Message-ID: <7vd49mfxcv.fsf@alter.siamese.dyndns.org>
References: <4A251F66.2020809@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Raman Gupta <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:51:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBWGd-0002NU-9d
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 17:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbZFBPu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 11:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754507AbZFBPu5
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 11:50:57 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47775 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbZFBPuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 11:50:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090602155055.ICPS17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jun 2009 11:50:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id z3qw1b00N4aMwMQ033qwgd; Tue, 02 Jun 2009 11:50:57 -0400
X-Authority-Analysis: v=1.0 c=1 a=bZa4_FYzNTYA:10 a=lqnXi6H1HwkA:10
 a=tK49qj8FpPCnZlpDQuwA:9 a=OSzdPYm-rDC9qjEtz4cE5rWd1DsA:4
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120525>

Raman Gupta <rocketraman@fastmail.fm> writes:

> When a repository containing a .gitattributes file, which contains
> other files with -crlf set is cloned on cygwin, with autocrlf = true,
> the initial checkout of the working copy sets the line endings for the
> -crlf files incorrectly (it ignores the .gitattributes, presumably
> because it hasn't been checked out yet).

I think this is what v1.6.3-rc0~83^2~1 (Read attributes from the index
that is being checked out, 2009-03-13) was about.

I see you are using a version based on 1.6.1.2; isn't there a newer Cygwin
packaged one available?
