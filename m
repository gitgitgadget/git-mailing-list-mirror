From: Bill Lear <rael@zopyra.com>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 14:58:07 -0600
Message-ID: <17875.30687.661794.512124@lisa.zopyra.com>
References: <17875.13564.622087.63653@lisa.zopyra.com>
	<7vhctor78j.fsf@assigned-by-dhcp.cox.net>
	<17875.17647.74882.218627@lisa.zopyra.com>
	<7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net>
	<17875.30187.289679.417079@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 21:58:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRCp-0000mJ-9j
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 21:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbXBNU6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 15:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXBNU6K
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 15:58:10 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60301 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932579AbXBNU6J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 15:58:09 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1EKw9j18480;
	Wed, 14 Feb 2007 14:58:09 -0600
In-Reply-To: <17875.30187.289679.417079@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39743>

I forgot to mention that fsck in my original public repo looks fine:

% cd /repos/git/fus

[with 1.4.4.1]
% GIT_DIR=. /usr/bin/git fsck-objects --full
dangling commit 828c0a0649d2d6b43ed13853bba33f7764f034fa

[with 1.5.0]
% GIT_DIR=. git fsck-objects --full
dangling commit 828c0a0649d2d6b43ed13853bba33f7764f034fa


Bill
