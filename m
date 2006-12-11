X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Bahadir Balban" <bahadir.balban@gmail.com>
Subject: stgit: No patches to pop
Date: Mon, 11 Dec 2006 14:32:46 +0000
Message-ID: <7ac1e90c0612110632x56a2917cu4db33e47923f34c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 14:32:55 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ta9iIGiaH/efklC4u8tZJxgGEVhGXnR9k3r/JqEoRMJXTIZjSzMcl+hAaamFozz0rYbnrUtxxCQeZhF4MhSUfl75PzPoEWU8XNijOwiAWzOX1IByi0jJBVeuKbeLth6Xzr8aEzNntje9vLkrf3/bJ4Y1TBHAtbPtwd9fUYtkPmU=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34008>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtmD7-0003Td-Jb for gcvg-git@gmane.org; Mon, 11 Dec
 2006 15:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935757AbWLKOcu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 09:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935763AbWLKOcu
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 09:32:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:53131 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S935757AbWLKOct (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 09:32:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1345988uga for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 06:32:48 -0800 (PST)
Received: by 10.82.136.4 with SMTP id j4mr1063269bud.1165847566436; Mon, 11
 Dec 2006 06:32:46 -0800 (PST)
Received: by 10.82.186.15 with HTTP; Mon, 11 Dec 2006 06:32:46 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

I've just recently started using stgit (v0.11, git v1.4.3.4). On a
test repository, I do:

% stg applied
first
second
third

but when I pop I get:

% stg pop
stg pop: No patches to pop

I also get things like:

% stg pop second
popping patch "third"... done
Now at patch "second"

Is this normal?

Thanks,
