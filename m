From: Bill Lear <rael@zopyra.com>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 08:53:14 -0500
Message-ID: <18039.57290.14570.879740@lisa.zopyra.com>
References: <18039.52754.563688.907038@lisa.zopyra.com>
	<Pine.LNX.4.64.0706191359160.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 15:53:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0e9F-00049C-W7
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 15:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbXFSNxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 09:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbXFSNxU
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 09:53:20 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60004 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbXFSNxU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 09:53:20 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5JDrH825382;
	Tue, 19 Jun 2007 08:53:17 -0500
In-Reply-To: <Pine.LNX.4.64.0706191359160.4059@racer.site>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50482>

On Tuesday, June 19, 2007 at 14:00:07 (+0100) Johannes Schindelin writes:
>
>You are missing libiconv.

Hmm, don't think so:

% ls -l /usr/local/lib/libiconv*
-rw-r--r-- 1 root root     789 May 14 13:31 /usr/local/lib/libiconv.la
lrwxrwxrwx 1 root root      17 May 14 13:31 /usr/local/lib/libiconv.so -> libiconv.so.2.4.0
lrwxrwxrwx 1 root root      17 May 14 13:31 /usr/local/lib/libiconv.so.2 -> libiconv.so.2.4.0
-rw-r--r-- 1 root root 1234292 May 14 13:31 /usr/local/lib/libiconv.so.2.4.0


Bill
