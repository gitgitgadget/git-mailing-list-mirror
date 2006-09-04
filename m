From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: [PATCH] git-repack: create new packs inside $PACKDIR, not cwd
Date: Mon, 04 Sep 2006 14:42:46 +1200
Message-ID: <44FB92A6.7020406@catalyst.net.nz>
References: <1157337502104-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Sep 04 04:43:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK4QW-00048C-Ei
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 04:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWIDCm5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 22:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWIDCm5
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 22:42:57 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:25001 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751320AbWIDCm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 22:42:56 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GK4Q9-0002d6-Ja; Mon, 04 Sep 2006 14:42:45 +1200
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <1157337502104-git-send-email-martin@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26396>

Martin Langhoff wrote:

> Avoid failing when cwd is !writable by writing the
> packfiles directly in the $PACKDIR.

Urgh. At the very top of the script there's

rm -f .tmp-pack-*
PACKDIR="$GIT_OBJECT_DIRECTORY/pack"

which relies on cwd again. Hmm.


m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------

-- 
VGER BF report: U 0.804452
