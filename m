From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 11:39:23 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-02-23-11-39-23+trackit+sam@rfc1149.net>
References: <200802221837.37680.chase.venters@clientec.com>
	<7vk5kw4fep.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Chase Venters <chase.venters@clientec.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 11:51:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSryK-0005Z9-DK
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 11:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbYBWKue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 05:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbYBWKud
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 05:50:33 -0500
Received: from anyanka.rfc1149.net ([81.56.47.149]:58697 "EHLO
	mail2.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbYBWKud (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 05:50:33 -0500
X-Greylist: delayed 665 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Feb 2008 05:50:32 EST
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 84238C405D;
	Sat, 23 Feb 2008 11:39:24 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HVs2spgTElhj; Sat, 23 Feb 2008 11:39:23 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id D610AC4096; Sat, 23 Feb 2008 11:39:23 +0100 (CET)
In-Reply-To: <7vk5kw4fep.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 22 Feb 2008 17\:42\:22 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74814>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> Many people prefer to use topic branches, and working in a
Junio> single repository with multiple branches and switching branches
Junio> without ever cd'ing around is certainly a possible and very
Junio> valid way to work.  As long as your build infrastructure is
Junio> sane (e.g. your project does not have a central header file
Junio> that any little subsystem change needs to modify and included
Junio> by everybody, which tends to screw up make quite badly),
Junio> switching branches would not incur too much recompilation
Junio> either and it obviously will save disk space not having to
Junio> leave multiple checkout around.

And even in this case (central header file), ccache will greatly
decrease compilation time in the case of a C/C++ project.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
