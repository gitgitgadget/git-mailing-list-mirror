From: Phil Susi <psusi@ubuntu.com>
Subject: Compare two diffs on the command line?
Date: Fri, 4 Sep 2015 14:00:36 -0400
Message-ID: <55E9DC44.90303@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 20:01:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXvIF-0003rU-Vw
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 20:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760030AbbIDSAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 14:00:52 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35434 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760004AbbIDSAv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 14:00:51 -0400
Received: by ykek143 with SMTP id k143so28509980yke.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 11:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=q6tyaz7wTkTX/afLMfHDREwqSPMqbp/HzcG4YwvMfnY=;
        b=KrwWxh7rz3z6TYHwvYsm1Y2H5iemAD0SBIYmGUvBIE9jObef2bdoK57er14XO+l2X+
         ckwYObCcEh942Mw9NeJKKpDXA82FVaKc8giFlHALImt/gfe0/tBEcKUA6qVa1T+R67bW
         2tjIAIstjL7DAQ6++zRhNIhmVjJBQYYgM6ARPN9n8IH1ET3RnuU16AKRZ0hgZqwY41f2
         YAjqpRk8JyLQWVaihexUAtHjCIu9I6zz3m9r1NDaxX6/c0PL/gbWBhXKiiHX44QD8VRI
         F9S69hBrrkq/QGw/gnAM0XZt6QjwqWPMRQk6MEGAp1Pj8g4gAmWZVGVivdhHMvE0vA84
         KcOw==
X-Received: by 10.129.60.12 with SMTP id j12mr5777319ywa.76.1441389650332;
        Fri, 04 Sep 2015 11:00:50 -0700 (PDT)
Received: from [10.1.1.200] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by smtp.googlemail.com with ESMTPSA id i1sm2852437ywd.41.2015.09.04.11.00.49
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2015 11:00:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277324>

If you have a commit that exists on two branches, in gitk you can mark 
one, then select the other and choose to compare the two.  This results 
in a diff of the two diffs, rather than a diff between the two trees, 
which include many other changes that have nothing to do with either commit.

Is there a way to do this on the command line?  I thought it would be 
git diff -c or --cc, but it doesn't seem to filter out all of the other 
differences between the branches.
