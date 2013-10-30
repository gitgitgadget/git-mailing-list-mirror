From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH V3] git clone: is an URL local or ssh
Date: Wed, 30 Oct 2013 07:52:39 +0100
Message-ID: <5270ACB7.6090608@viscovery.net>
References: <201310292207.50869.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: sunshine@sunshineco.com, peff@peff.net, pclouds@gmail.com
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 30 07:52:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbPe6-0005W8-TO
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 07:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175Ab3J3Gwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 02:52:46 -0400
Received: from so.liwest.at ([212.33.55.16]:6566 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab3J3Gwq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 02:52:46 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VbPdw-0007kZ-QS; Wed, 30 Oct 2013 07:52:40 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5160116613;
	Wed, 30 Oct 2013 07:52:40 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <201310292207.50869.tboegi@web.de>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236988>

Just a heads-up: This patch breaks t5601 totally on Windows. Test #4, a
local clone via file: protocol, fails already. I'm investigating now.

-- Hannes
