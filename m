From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: How to prevent Git from compressing certain files?
Date: Wed, 22 Jul 2009 21:49:31 +0200
Message-ID: <4A676D4B.7040004@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 22 21:53:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MThsb-0004M5-1S
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 21:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbZGVTth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 15:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754567AbZGVTth
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 15:49:37 -0400
Received: from smtprelay07.ispgateway.de ([80.67.31.30]:39142 "EHLO
	smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438AbZGVTtf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 15:49:35 -0400
Received: from [84.176.90.250] (helo=[192.168.2.100])
	by smtprelay07.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1MThoi-0002Y8-Tg
	for git@vger.kernel.org; Wed, 22 Jul 2009 21:49:33 +0200
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123769>

Hi,

I'm (ab)using Git to store my media files, i.e. digicam pictures (*.jpg)
and the like. This way I can e.g. comment a series of pictures without
installing and learning a special purpose "Photo Archiving" tool. Gitk
shows the roadmap!

Somewhere I read that Git isn't supposed to efficiently handle binary
files. Of course, I don't want to merge my files, just store them with
their history and git-push them to some "safe place".

I figured that pushing and git gc'ing both try to compress those files
(or differences) really hard. Works great for "regular" files, but is
pointless with jpegs.

Question: Is there a way to prevent Git from trying to compress certain
files based on their extension?

-- Dirk
