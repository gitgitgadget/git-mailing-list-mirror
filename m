From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Sun, 03 Jan 2010 11:35:07 +0900
Message-ID: <87ljgfgbl0.fsf@catnip.gol.com>
References: <1262182304-19911-1-git-send-email-pclouds@gmail.com>
	<7v637nzky0.fsf@alter.siamese.dyndns.org>
	<7vzl4zy5z3.fsf@alter.siamese.dyndns.org> <20100102115041.GA32381@do>
	<7vtyv4cpna.fsf@alter.siamese.dyndns.org>
	<fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com>
	<7v7hs09tpi.fsf@alter.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 03 03:58:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRGfa-0004kx-CT
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 03:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214Ab0ACCr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 21:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086Ab0ACCrz
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 21:47:55 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:36616 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab0ACCrz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 21:47:55 -0500
X-Greylist: delayed 756 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Jan 2010 21:47:55 EST
Received: from 218.231.177.74.eo.eaccess.ne.jp ([218.231.177.74] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1NRGJ9-0001Wb-Tq; Sun, 03 Jan 2010 11:35:07 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 12419DF32; Sun,  3 Jan 2010 11:35:07 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <7v7hs09tpi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 02 Jan 2010 11:45:29 -0800")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136062>

Junio C Hamano <gitster@pobox.com> writes:
> Then please at least make the second grep "grep ext-grep", droping "-e --"
> from it.  We assume some implementation of external grep to lack "-e"
> (e.g. Solaris).

Isn't "-e" a "classic" grep option tho?

-Miles

-- 
Consult, v.i. To seek another's disapproval of a course already decided on.
