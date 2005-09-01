X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Cogito(?): git+ssh pulling broken with tcsh as default shell
Date: Thu, 01 Sep 2005 14:21:57 -0700
Message-ID: <431770F5.8080806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 1 Sep 2005 21:23:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1EAwWp-00018q-9g for gcvg-git@gmane.org; Thu, 01 Sep
 2005 23:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030391AbVIAVWI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 1 Sep 2005
 17:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbVIAVWI
 (ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 17:22:08 -0400
Received: from terminus.zytor.com ([209.128.68.124]:43486 "EHLO
 terminus.zytor.com") by vger.kernel.org with ESMTP id S1030391AbVIAVWG (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 1 Sep 2005 17:22:06 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
 (authenticated bits=0) by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id
 j81LM16H030801 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Thu, 1 Sep 2005 14:22:02 -0700
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

: tazenda 54 ; cg-clone -s 
git+ssh://terminus.zytor.com/home/hpa/klibc/official/.git/
defaulting to local storage area
mkdir: cannot create directory `.git/branches': File exists
master 
           100%   41     0.0KB/s   00:00
GIT_DIR=/home/hpa/klibc/official/.git: Command not found.
error: Couldn't read version from remote end
cg-pull: objects pull failed
cg-clone: pull failed


It looks like it tries to execute a sh/bash script on the remote end, 
without forcing the remote end to use sh/bash to execute the script.

