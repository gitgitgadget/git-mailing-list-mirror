From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/4] misc. msvc patches
Date: Wed, 20 Jan 2010 19:19:26 +0000
Message-ID: <4B57573E.2050006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:35:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXhGX-0001VA-90
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 21:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158Ab0ATUex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 15:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754039Ab0ATUex
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 15:34:53 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:47048 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753732Ab0ATUew (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 15:34:52 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1NXhGN-0005e3-Zt; Wed, 20 Jan 2010 20:34:51 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137570>

Hi Junio,

Since we can now build git on Cygwin using msvc, I've been looking to
suppress the *many* compiler warnings issued by msvc; OK I haven't been
trying too hard, since Windows is not my main platform and msvc is not
my primary compiler! ;-)  However, every little helps...

The following patches have been hanging around for several weeks, so I
decided to pass them on now rather than wait until I get around to finishing
the other patches.

[PATCH 1/4] engine.pl: Fix a recent breakage of the buildsystem generator
[PATCH 2/4] msvc: Fix an "unrecognized option" linker warning
[PATCH 3/4] msvc: Fix a compiler warning due to an incorrect pointer cast
[PATCH 4/4] msvc: Add a definition of NORETURN compatible with msvc compiler

These patches remove 86 warnings for me (84 of those due to patch #4).

I have another (small) patch which avoids 109 further warnings, but I
want to provide an alternative solution; this solution is currently a
4 patch series which only removes about 60 warnings so far...

ATB,
Ramsay Jones
