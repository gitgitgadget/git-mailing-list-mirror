X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: git pull and merging.
Date: Wed, 6 Dec 2006 10:21:46 +0530
Message-ID: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 04:51:54 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ahsc3Wcdylx7CVLjW8+IRAe9sPE2VJ0czBT6vtkkNB2XVv7uWx0X8JAgJOwNdLIRsf3YGEawsdAKyqk+tRF6LFlZjOCqQKJXGhcfwlZCfAJvAFc6+zNopTxrEXXReyG0DT8swbxjNbm1H83ulAZgamNmG/egB/lwNQ48bwcJais=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33401>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grol5-0002rS-4Y for gcvg-git@gmane.org; Wed, 06 Dec
 2006 05:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760047AbWLFEvs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 23:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760049AbWLFEvs
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 23:51:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:48965 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760047AbWLFEvr (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 23:51:47 -0500
Received: by nf-out-0910.google.com with SMTP id o25so438068nfa for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 20:51:46 -0800 (PST)
Received: by 10.48.217.20 with SMTP id p20mr1643808nfg.1165380706405; Tue, 05
 Dec 2006 20:51:46 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Tue, 5 Dec 2006 20:51:46 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

I have a git.git clone using --use-separate-remote. That means i have
the master branch created by default. Now i need to build git from the
pu branch too. So i created git branch pu remotes/origin/pu.


How how do i track the pu branch using git pull. What i mean is the
master local branch is tracked by default using git pull. Is there a
way to track the local pu branch too.

I looked at git-repo-config and branch.<name>. config variable usage
is confusing. After initial try i concluded that it is to replace
.git/remotes/origin not the requirement i had.

