From: "Guillermo O. Freschi" <tordek@tordek.com.ar>
Subject: url.<base>.insteadOf and git-clone
Date: Thu, 08 May 2008 12:50:48 -0300
Message-ID: <48232158.6090708@tordek.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 17:52:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju8PQ-0000CF-J9
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 17:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906AbYEHPvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 11:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754929AbYEHPvB
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 11:51:01 -0400
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:43518 "EHLO
	friskymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751840AbYEHPvA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2008 11:51:00 -0400
Received: from [192.168.0.101] (host56.190-30-172.telecom.net.ar [190.30.172.56])
	by friskymail-a3.g.dreamhost.com (Postfix) with ESMTP id A3B5C181093
	for <git@vger.kernel.org>; Thu,  8 May 2008 08:50:58 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81533>

Nearly gone insane about this: adding a configuration like
[url "ssh://example.com/foo"]
    insteadOf = foo:

works for git-fetch and git-pull (of what I've tested), but does not on git-clone (As of version 1.5.5.GIT).

Given that this config appears on the git-clone manpage, am I to assume it's a bug?

-- 
Tordek, el enano
http://www.arcanopedia.com.ar - Juegos de Rol en Argentina
http://blog.tordek.com.ar - La Red en la Red
