From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
Subject: [PATCHv2 0/2] a couple of git-svn patches
Date: Mon,  4 Apr 2011 15:09:06 -0400
Message-ID: <1301944148-7950-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: James Y Knight <jknight@itasoftware.com>
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 04 21:09:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6p9a-0003Bi-Fa
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 21:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294Ab1DDTJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 15:09:26 -0400
Received: from mx2.itasoftware.com ([63.115.78.21]:57814 "EHLO
	mx2.itasoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755135Ab1DDTJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 15:09:25 -0400
Received: from ita4mta2.internal.itasoftware.com (ita4mta2.internal.itasoftware.com [10.4.52.168])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.itasoftware.com (Postfix) with ESMTP id 0497157D41;
	Mon,  4 Apr 2011 15:10:59 -0400 (EDT)
Received: from asedeno.corp.itasoftware.com (lb1.dc4nat149.dc4.internal.itasoftware.com [10.4.199.149])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ita4mta2.internal.itasoftware.com (Postfix) with ESMTPS id E239219D8037;
	Mon,  4 Apr 2011 15:09:10 -0400 (EDT)
Received: from asedeno by asedeno.corp.itasoftware.com with local (Exim 4.74)
	(envelope-from <asedeno@asedeno.corp.itasoftware.com>)
	id 1Q6p9C-0004C1-Ro; Mon, 04 Apr 2011 15:09:10 -0400
X-Mailer: git-send-email 1.7.4.2.1.gd6f1f
X-ITASoftware-MailScanner: Found to be clean
X-ITASoftware-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 3, ALL_TRUSTED -1.00)
X-ITASoftware-MailScanner-From: asedeno@itasoftware.com
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170836>

(The patches themselves haven't changed since I sent them to the list
on Friday, but this does clean up attribution and sign-offs in the
commit messages.)

Here are two independent git-svn patches that my co-worker handed off
to me back in January.

The first changes the behavior of commit_url to be like that of url so
that you can commit to multiple branches.

The second uses Memoize to cache the results of shelling out to
git-config, which has good performance benefits for git-svn fetch.
