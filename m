X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: "git clone" can't clone a gitweb URL
Date: Mon, 06 Nov 2006 16:32:04 +0800
Message-ID: <454EF304.4030304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 08:33:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=qfkehyHY9V94M6LgZcvJy2dfVjr46A6qKW75bloDVXuIceSlda5GsMtoZ71yYXfSghoXAtJ6pXU4dRru/QghBQJnj1hZ+cMUntPUYIyy1V1MPpUuIuhU2O1H2aKlvLj6e+2Zl2ETQ0TVIJ4+MbfR/1ZscldKG2E270E9NkWco/I=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31001>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggzun-0003T4-2j for gcvg-git@gmane.org; Mon, 06 Nov
 2006 09:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423570AbWKFIdF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 03:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423601AbWKFIdF
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 03:33:05 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:18669 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1423570AbWKFIdD
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 03:33:03 -0500
Received: by wx-out-0506.google.com with SMTP id s14so984049wxc for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 00:33:02 -0800 (PST)
Received: by 10.90.105.19 with SMTP id d19mr1858774agc.1162801982575; Mon, 06
 Nov 2006 00:33:02 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id 11sm1710422wrl.2006.11.06.00.33.00; Mon, 06 Nov 2006 00:33:01 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

$ git clone http://repo.or.cz/w/i18n.git
error: Can't lock ref
rm: cannot remove directory `i18n/.git/clone-tmp': Directory not emp
ty

At last I found the URL was a gitweb URL not for mirroring.

It's better git provides clear information like "This is maybe a
gitweb URL, view it in web browser for more information", or
gitweb can send a redirection response to git client. Even more,
git-daemon also can send redirection response to tell git client
that the service is offline temporarily and it can use an alternative
