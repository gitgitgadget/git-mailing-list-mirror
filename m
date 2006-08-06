From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: EGIT packed delta format reading
Date: Sun, 06 Aug 2006 20:37:48 +0200
Message-ID: <20060806183748.7591.61536.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Aug 06 20:40:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9nYN-0007Ej-38
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 20:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWHFSkk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 14:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWHFSkk
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 14:40:40 -0400
Received: from [83.140.172.130] ([83.140.172.130]:34366 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1750794AbWHFSkj
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 14:40:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id A9B618030C3
	for <git@vger.kernel.org>; Sun,  6 Aug 2006 20:38:33 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13349-06 for <git@vger.kernel.org>; Sun,  6 Aug 2006 20:38:33 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by torino.dewire.com (Postfix) with ESMTP id 65C0980264C
	for <git@vger.kernel.org>; Sun,  6 Aug 2006 20:38:33 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 24ACA27EDE
	for <git@vger.kernel.org>; Sun,  6 Aug 2006 20:40:36 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24988>

Hi,

I deciced to take Shawns Eclipse plugin for a run. There was
some problem reading the pack files that seemed to work after
applying the following fixes, i.e. I could connect to the
project and the interal structures looks ok in the debugger
as far as I can tell, but decorations don't work. That's as
far as I've been testing up to now.

BTW. How should EGIT patches be formatted to distingish them
from git patches? I'm sending this using StGit.

-- robin
