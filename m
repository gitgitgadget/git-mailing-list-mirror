From: Philip Pokorny <ppokorny@mindspring.com>
Subject: Why /usr/bin/env in scripts
Date: Mon, 25 Apr 2005 00:38:11 -0700
Message-ID: <426C9E63.4050907@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Apr 25 09:34:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPy65-00016B-0O
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 09:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVDYHiY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 03:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVDYHiY
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 03:38:24 -0400
Received: from smtpauth09.mail.atl.earthlink.net ([209.86.89.69]:27867 "EHLO
	smtpauth09.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S262551AbVDYHiN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 03:38:13 -0400
Received: from [68.164.169.208] (helo=[172.16.1.11])
	by smtpauth09.mail.atl.earthlink.net with asmtp (TLSv1:RC4-MD5:128)
	(Exim 4.34)
	id 1DPyAW-000301-5M
	for git@vger.kernel.org; Mon, 25 Apr 2005 03:38:12 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-ELNK-Trace: 662518af21fc89ef9c7f779228e2f6aeda0071232e20db4def98fe55df5cc402386554abe147234b350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.164.169.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I notice that the first line of the pasky shell scripts is

#!/usr/bin/env bash

rather than what I'm more familiar with:

#!/bin/bash

I see that env can be used to alter the environment before running a 
program, but that doesn't seem to be happening here.

In fact, on my system /usr/bin/env is a link to /bin/env...

So what am I missing?  Is this a portability aid?

Thanks,
:v)
