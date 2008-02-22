From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve documentation for git-sh-setup.
Date: Fri, 22 Feb 2008 09:17:51 -0800
Message-ID: <7vbq68ap1c.fsf@gitster.siamese.dyndns.org>
References: <20080221230101.27644.49229.stgit@gandelf.nowhere.earth>
 <20080222093558.GC29114@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:18:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSbXp-0003jT-0N
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 18:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbYBVRSJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 12:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbYBVRSI
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 12:18:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbYBVRSH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 12:18:07 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ACB464710;
	Fri, 22 Feb 2008 12:18:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D4EF4470F; Fri, 22 Feb 2008 12:17:59 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74737>

Pierre Habouzit <madcoder@debian.org> writes:

>   Actually, new scripts should be written using git rev-parse if
> possible, the USAGE/LONG_USAGE were there _before_ and I'd like to ca=
ll
> them the deprecated interface if other git hackers don't mind.
>
>   git rev-parse --parseopt gives consistency in how git parses option=
s,
> and it's A Good Thing=E2=84=A2

I certainly think encouraging use of parse-options in new
scripts is a good idea, even though I suspect "deprecated" above
might be a bit too strong.

I did not find accessible from the command line variant was the
parse-opt-hidden feature, which was frustrating.

>   That makes me think that git-sh-setup(1) use should be documented i=
n
> gitcli(5), maybe even included, and git-sh-setup(1) should *definitel=
y*
> link to gitcli(5). We wondered where to link gitcli from, this is
> definitely the place !

Sounds good.  Please make it so.
