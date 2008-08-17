From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: [PATCH 0/6] Add support for Haiku hosts
Date: Sun, 17 Aug 2008 10:56:43 +0200
Message-ID: <5501D490-28B5-4447-A48E-C34592EF9792@web.de>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 17 10:58:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUe5b-0005Wl-5A
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 10:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbYHQI5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 04:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbYHQI5J
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 04:57:09 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35029 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbYHQI5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 04:57:07 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1B10BEB47775;
	Sun, 17 Aug 2008 10:57:05 +0200 (CEST)
Received: from [91.18.70.145] (helo=[10.0.1.1])
	by smtp07.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KUe4O-0003YQ-00; Sun, 17 Aug 2008 10:57:05 +0200
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX19Q6NzUXU3Le+hcx1DeOotVSZwOwPYXegUBdfzq
	FF0tgP1tmgE11zYuuuF5rgQwO/LfvvS0ka7Ych0MLcMMgis66G
	msGC6L9B+9iRSfwa8G7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92582>

Hello,

This series of patches adds support for building and running Git on  
Haiku (the open-source BeOS replacement).

#1: Disable IPv6 support
#2: Don't try to link against libsocket
#3: Link against libnetwork
#4: st_blocks workaround
#5: Link to libbsd
#6: Always provide alternative to hardlinks

Andreas
