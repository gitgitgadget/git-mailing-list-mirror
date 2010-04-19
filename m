From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] t7012: Mark missing tests as TODO
Date: Mon, 19 Apr 2010 10:20:08 +0200
Message-ID: <t2wfcaeb9bf1004190120k6cf584b4m1e38c0f90461fd3e@mail.gmail.com>
References: <1584248d122ac952e6c9f4b4243b23c32f23aa3b.1271664768.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 19 10:20:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3mDd-0000sc-67
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 10:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826Ab0DSIUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 04:20:32 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:63320 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0DSIUb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 04:20:31 -0400
Received: by bwz25 with SMTP id 25so5162216bwz.28
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 01:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=ud8IOliSzZb2hELSWNcYZ6PFxqK+742nLcTQ/G3jfEs=;
        b=qMJM27tdva/v42YchGc/DJsiIv++IJC0ZgeMRXxg/CU39/uGyYtZb2qglGJK71Wkr2
         7C3LLgxK++7qn4CYD0FIJzJI7+ZdXfxa5IAg3M1Bo0B2WaSLMMz8Bri0s00qCVkbSaM/
         Bl1CR7x7GPNLZ6ie3zPJX/+B+xjGbBOLRdTJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OXkI+UWkPZ/7GHEy7ZU0hjGCCEYpPT7O8qYVyvgR8MbzyytLgPv+vCFQCLuuhQrWjm
         gQoYabyapDAVL9pxA8IkL34H2pzNQ5fPl06uLBHztw9DTnc/ANf1Ru+9JM6JJx27UT7D
         jbbj5SO7PJebvJ4SZ6J2q0/7cOOo61EtI57Mw=
Received: by 10.204.53.10 with HTTP; Mon, 19 Apr 2010 01:20:08 -0700 (PDT)
In-Reply-To: <1584248d122ac952e6c9f4b4243b23c32f23aa3b.1271664768.git.git@drmicha.warpmail.net>
Received: by 10.204.45.207 with SMTP id g15mr4073148bkf.210.1271665230222; 
	Mon, 19 Apr 2010 01:20:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145279>

2010/4/19 Michael J Gruber <git@drmicha.warpmail.net>:
> Currently, there are 6 tests which are not even written but are
> 'test_expect_failure message false'.
> Do not abuse test_expect_failure as a to do marker, but mark them as
> '#TODO' instead.

Ack.  Need to write those tests soon.
-- 
Duy
