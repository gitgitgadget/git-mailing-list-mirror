From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/2] spare warnings on master
Date: Sun, 11 Sep 2011 20:24:18 +0100
Message-ID: <4E6D0AE2.8040200@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 21:43:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2pw2-0004iU-QJ
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 21:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760384Ab1IKTnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 15:43:16 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:42333 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760370Ab1IKTnQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2011 15:43:16 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1R2pvu-0006XY-cd; Sun, 11 Sep 2011 19:43:15 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181183>

Hi Junio,

These patches fix some sparse warnings on the master branch
(from repo.or.cz) @ 3793ac56b4c4f9bf0bddc306a0cec21118683728

    [PATCH 1/2] sparse: Fix an "Using plain integer as NULL pointer"
    [PATCH 2/2] obstack.c: Fix some sparse warnings

They could be squashed into one commit, if you prefer. The second
patch is not required on Linux, because *all* of the code in obstack.c
is #ifdef'd out, but it fixes things up on cygwin and MinGW.

ATB,
Ramsay Jones
