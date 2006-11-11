X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: check if a commit is ascendent of a specific commit
Date: Sat, 11 Nov 2006 18:08:56 +0700
Message-ID: <fcaeb9bf0611110308l577d70bfo5046d7d7eb09ac58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 11 Nov 2006 11:09:12 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=A00mCZZYnyQif08pHEO8KRVGIj5vloiqy4JBRbPHNV1YOrsTeYGhv1tso+vld0Edexlp4NULkQKC58LV3egc0XfhHmo4iV75XZeQ96b7FE/v2oBlm468dhoyALCRO2im9kUtc1YruuxaBRokJB8NLedg8iKkfx9kLOqg8XcgS6I=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31211>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiqjO-0007Hm-43 for gcvg-git@gmane.org; Sat, 11 Nov
 2006 12:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966111AbWKKLI6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 06:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966024AbWKKLI6
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 06:08:58 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:4511 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S965982AbWKKLI6
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 06:08:58 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1610992nfa for
 <git@vger.kernel.org>; Sat, 11 Nov 2006 03:08:56 -0800 (PST)
Received: by 10.78.83.13 with SMTP id g13mr3830994hub.1163243336181; Sat, 11
 Nov 2006 03:08:56 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Sat, 11 Nov 2006 03:08:56 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,
I want to create "git-amend-commit" to be able to amend commits before
HEAD. So I need to check whether the commit I'm going to amend is
ascendent of HEAD. Is there any way to check that?
-- 
