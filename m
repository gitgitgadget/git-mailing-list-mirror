From: Thomas Gleixner <tglx@linutronix.de>
Subject: BK -> git export done
Date: Sat, 16 Apr 2005 17:57:26 +0200
Message-ID: <1113667047.23734.10.camel@tglx.tec.linutronix.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 16 16:54:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMogL-0002p3-C3
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 16:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVDPO5h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 10:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVDPO5h
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 10:57:37 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:54200
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262674AbVDPO5c
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 10:57:32 -0400
Received: from mail.tec.linutronix.de (213-239-205-147.clients.your-server.de [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id AAE6065C003
	for <git@vger.kernel.org>; Sat, 16 Apr 2005 16:56:19 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 9FCEA28222
	for <git@vger.kernel.org>; Sat, 16 Apr 2005 16:57:27 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi folks,

I managed finally to export the complete kernel history into git format
The resulting number of objects is ~ 500000
The required disk space is ~ 3.2 GiB

We also tracked the blob/tree/commit references in a SQL database. We
will post a SQL dump when the database is in a bit better shape. This
should make history tracking quite simple.

I currently figure out a way to post the data. My poor DSL line is a bit
too slow :)

tglx



