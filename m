From: walter harms <wharms@bfs.de>
Subject: help: bisect single file from repos
Date: Mon, 07 Dec 2009 13:59:56 +0100
Message-ID: <4B1CFC4C.6090406@bfs.de>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 14:00:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHdCK-0008Jd-SF
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 14:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881AbZLGNAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 08:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932872AbZLGNAF
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 08:00:05 -0500
Received: from mx.sz.bfs.de ([194.94.69.70]:34731 "EHLO mx.sz.bfs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755737AbZLGNAE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 08:00:04 -0500
Received: from mail.sz.bfs.de (mail.sz.bfs.de [192.168.0.1])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx.sz.bfs.de (BfS Mail Relay SZ) with ESMTP id C54E4288E1E
	for <git@vger.kernel.org>; Mon,  7 Dec 2009 14:00:09 +0100 (CET)
Received: from localhost (unknown [192.168.2.47])
	by mail.sz.bfs.de (BfS Mail Hub) with ESMTP id A0C94E3908
	for <git@vger.kernel.org>; Mon,  7 Dec 2009 14:00:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bfs.de
Received: from mail.sz.bfs.de ([192.168.2.193])
	by localhost (amavis-sz.sz.bfs.de [192.168.2.47]) (amavisd-new, port 10024)
	with ESMTP id 8JPMufTpVeoa for <git@vger.kernel.org>;
	Mon,  7 Dec 2009 13:59:58 +0100 (CET)
Received: from dc-slave2-fr.fr.bfs.de (unknown [10.177.18.200])
	by mail.sz.bfs.de (BfS Mail Hub) with ESMTP id 7A71BE390E
	for <git@vger.kernel.org>; Mon,  7 Dec 2009 13:59:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dc-slave2-fr.fr.bfs.de (Postfix) with ESMTP id 28C90DB260
	for <git@vger.kernel.org>; Mon,  7 Dec 2009 13:59:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dc-slave2-fr.fr.bfs.de (Postfix) with ESMTP id E8D84DB261
	for <git@vger.kernel.org>; Mon,  7 Dec 2009 13:59:56 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.4.2 (20060627) (Debian) at fr.bfs.de
Received: from dc-slave2-fr.fr.bfs.de ([127.0.0.1])
	by localhost (dc-slave2-fr.fr.bfs.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1QgdKZXkLLtb for <git@vger.kernel.org>;
	Mon,  7 Dec 2009 13:59:56 +0100 (CET)
Received: from [134.92.181.33] (unknown [134.92.181.33])
	by dc-slave2-fr.fr.bfs.de (Postfix) with ESMTP id A9BD0DB260
	for <git@vger.kernel.org>; Mon,  7 Dec 2009 13:59:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134756>

Hi list,
i am new to git (using: git version 1.6.0.2).

I would like to bisect a single file but i have only commit id, no tags.

Background:
I have a copy of the busybox git repos, and i know there is (perhaps) a bug
in ash.c.

how can i do that ?

re,
 wh
