From: Miles Bader <miles@gnu.org>
Subject: Re: [1.8.0] Recursively checkout, merge and reset populated submodules
Date: Tue, 22 Feb 2011 09:51:42 +0900
Message-ID: <87ei70riw1.fsf@catnip.gol.com>
References: <7vwrky5f48.fsf@alter.siamese.dyndns.org>
	<4D5FF6E7.8090104@web.de> <4D628F21.3050808@xiplink.com>
	<4D62AF46.8030508@web.de> <4D62C385.90204@xiplink.com>
	<4D62ED38.7070408@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 22 01:51:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrgTt-0006zS-GJ
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 01:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab1BVAvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 19:51:53 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:44755 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab1BVAvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 19:51:52 -0500
Received: from 218.231.234.87.eo.eaccess.ne.jp ([218.231.234.87] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1PrgTf-0007hO-8r; Tue, 22 Feb 2011 09:51:43 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 95E3EDFA0; Tue, 22 Feb 2011 09:51:42 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <4D62ED38.7070408@web.de> (Jens Lehmann's message of "Mon, 21 Feb
	2011 23:54:48 +0100")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167520>

Jens Lehmann <Jens.Lehmann@web.de> writes:
>> So, .gitmodules initially controls recursion.  When a submodule gets
>> populated, it gets an entry in .git/config which then determines the
>> recursion behavior from then on.  Changing branches might change .gitmodules,
>> but anything in .git/config will persist so any customizations the user makes
>> will also persist.
>
> Yes. Upstream can give sane defaults but the user has the last word.

If .git/config entries are created _automatically_ based on the initial
.gitmodules, doesn't that means it will cease to respect the upstream
defaults in the case where .gitmodules changes, even if the user didn't
actually change anything himself...?

-Miles

-- 
`The suburb is an obsolete and contradictory form of human settlement'
