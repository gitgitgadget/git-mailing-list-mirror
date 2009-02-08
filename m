From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 4/5] Test and fix normalize_path_copy()
Date: Sun, 8 Feb 2009 01:08:50 +0100
Message-ID: <200902080108.50550.robin.rosenberg.lists@dewire.com>
References: <498CAF73.6050409@lsrfire.ath.cx> <1234019311-6449-4-git-send-email-j6t@kdbg.org> <1234019311-6449-5-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: rene.scharfe@lsrfire.ath.cx,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Feb 08 01:10:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVxG8-0003hj-Q0
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 01:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbZBHAI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 19:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754056AbZBHAI6
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 19:08:58 -0500
Received: from mail.dewire.com ([83.140.172.130]:14889 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753388AbZBHAI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 19:08:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 683BF8026F9;
	Sun,  8 Feb 2009 01:08:52 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0MJhxAdsOVS5; Sun,  8 Feb 2009 01:08:51 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D8FA7800258;
	Sun,  8 Feb 2009 01:08:51 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <1234019311-6449-5-git-send-email-j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108904>


For Windows leading // is special indicating a UNC
path and should not be changed to /.

//foo/bar is different from /foo/bar

-- robin
