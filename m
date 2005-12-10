From: Marcel Holtmann <marcel@holtmann.org>
Subject: Latest cogito broken with bash-3.1
Date: Sat, 10 Dec 2005 14:18:44 +0100
Message-ID: <1134220724.15125.4.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Dec 10 14:23:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1El4fU-0000G7-H3
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 14:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVLJNV3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 08:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVLJNV3
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 08:21:29 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:50841 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932343AbVLJNV2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2005 08:21:28 -0500
Received: from blade (p5487E506.dip.t-dialin.net [84.135.229.6])
	by mail.holtmann.net (8.13.4/8.13.4/Debian-3) with ESMTP id jBADImXB015747
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sat, 10 Dec 2005 14:21:59 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.5.2 
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_96_XX 
	autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on coyote.holtmann.net
X-Virus-Scanned: ClamAV 0.84/1207/Fri Dec  9 23:01:12 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13445>

Hi Petr,

I have a Ubuntu Dapper running and since their update to the latest bash
version the cg-commit command (and maybe others) is broken. It reports:

GNU bash, version 3.1.0(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2005 Free Software Foundation, Inc.

The cogito is the latest from kernel.org and when calling cg-commit it
fails with this message:

cg-commit: line 200: syntax error near unexpected token `('
cg-commit: line 200: `       eval commitfiles=($(cat $filter | path_xargs git-diff-index -r -m HEAD -- | \'

I played a little bit with it and it seems all the eval statements are
broken with this bash version. I have no clue how to fix this, but maybe
you do.

Regards

Marcel
