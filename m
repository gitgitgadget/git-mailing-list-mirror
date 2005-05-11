From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] git tracker online
Date: Wed, 11 May 2005 07:01:18 +0000
Organization: linutronix
Message-ID: <1115794878.22180.27.camel@tglx>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 11 09:09:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVlKv-0002r4-2U
	for gcvg-git@gmane.org; Wed, 11 May 2005 09:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVEKHQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 03:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVEKHQF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 03:16:05 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:39298
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261908AbVEKHPs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 03:15:48 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id AC67365C003
	for <git@vger.kernel.org>; Wed, 11 May 2005 09:15:44 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 99019282B6
	for <git@vger.kernel.org>; Wed, 11 May 2005 09:00:25 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

git tracker is online in a beta version:

http://www.tglx.de/gittracker

It does:
- multi repository tracking
- Tree browsing
- File revision history
- File diffs
- File annotation
- commit viewer with filtering (e.g. all commits in a tree which are not
in another tree)

The file histories and annotations are partially messed due to the
missing information about head forward merges. Its a pity that there
seems to be no interest to solve this problem really. It might be not
important for some of you, but it is often quite helpful to have
consistent information across multiple trees available.

The simplest solution would be a head order list per repository, which
is updated every time when the head is changed. Thats a non intrusive
feature, which could be simply added to the current tools. 

tglx


