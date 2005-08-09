From: John Ellson <ellson@research.att.com>
Subject: Newbie question:  equiv of:  cvs co -p <filename>  ?
Date: Tue, 09 Aug 2005 17:59:14 -0400
Message-ID: <ddb8vl$ifq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 10 00:03:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2cAT-0005bg-3u
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 00:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbVHIWBu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 18:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbVHIWBu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 18:01:50 -0400
Received: from main.gmane.org ([80.91.229.2]:32973 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964988AbVHIWBt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 18:01:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E2c8e-0005NV-Uu
	for git@vger.kernel.org; Wed, 10 Aug 2005 00:00:00 +0200
Received: from h-135-207-24-103.research.att.com ([135.207.24.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Aug 2005 00:00:00 +0200
Received: from ellson by h-135-207-24-103.research.att.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Aug 2005 00:00:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h-135-207-24-103.research.att.com
User-Agent: Mozilla Thunderbird 1.0.6-3 (X11/20050806)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

How can we cat the latest committed state of a file to stdout?

I hacked this:

	#!/bin/bash
	ID=`git-ls-files -s | grep $1 | cut -d ' ' -f 2`
	TMP=`git-unpack-file $ID`
	cat $TMP
	rm $TMP

but its really ugly!   It must be easier than this?

John
